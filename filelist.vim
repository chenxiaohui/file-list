"=============================================================================
"     FileName: filelist.vim
"         Desc:
"       Author: ChenXiaohui
"        Email: sdqxcxh@gmail.com
"     HomePage: http://www.cxh.me
"      Version: 0.0.1
"   LastChange: 2013-11-06 20:31:23
"      History:
"=============================================================================
function! GetCmd(type,line)
    let cmd=get(g:applist,a:type)
    if empty(cmd)
        let cmd=get(g:applist,'default')
    endif
    "no %
    if cmd[0] != '!' && cmd[0] != ':'
        let cmd="!nohup ".cmd." '".Trans(a:line)."' >/dev/null 2>&1 &"
    else
        let cmd=substitute(cmd,'%',Trans(Trans(a:line)),'g')
    endif

    "let cmd=substitute(cmd,'%<',a:line,'g')
    return cmd
endfunction

function! OpenFileWithDefApp()
    "Replace loose ampersands (as in DeAmperfy())...
    let cmd = ''
    let curr_line = getline('.')
    let origin_line = Trim(Trim(curr_line,'\\'), ' ')

    let line_arr = split(origin_line,':')
    let line = line_arr[0]
    let line_num_or_content = ''
    if len(line_arr) > 1
        let line_num_or_content = line_arr[1]
    endif

    if !filereadable(line)
        "Directory
        let cmd=GetCmd('pwd',line)
    else
        let idx=strridx(line,".")
        "has no ext
        if idx==-1
            let cmd=GetCmd('default',line)
        else
            let fileExt = tolower(matchstr(line,'\.\w\+$'))
            let fileExt=tolower(strpart(fileExt,1))
            for [exts,app] in items(g:applist)
                let supportExt=split(exts,',')
                if index(supportExt,fileExt)>=0
                    let cmd=GetCmd(exts,line)
                endif
            endfor
        endif
    endif

    if empty(cmd)
        let cmd=GetCmd('default',line)
    endif
    "echo cmd
    execute cmd
    if line_num_or_content != ''
        if match(line_num_or_content, '^\d\+$') != -1
            execute ':'.line_num_or_content
        else
            let line_num_or_content = Trim(line_num_or_content, '')
            let line_num_or_content=substitute(line_num_or_content,'\.','\\.','g')
            let line_num_or_content=substitute(line_num_or_content,'\*','\\*','g')
            execute '/'.line_num_or_content
        endif
        execute ':call Vm_toggle_sign()'
        "execute ':set cursorline'
        "normal V
    endif
endf

function! DelFile () range
    for linenum in range(a:firstline, a:lastline)
        "Replace loose ampersands (as in DeAmperfy())...
        let curr_line = getline(linenum)
        if !filereadable(curr_line)
            "echo "!rm -ri ".Trans(getline("."))
            :execute "!rm -ri ".Trans(curr_line)
        else
            "echo "!rm -i ".Trans(getline("."))
            :execute "!rm -i ".Trans(curr_line)
        endif
    endfor
    for linenum in range(a:firstline, a:lastline)
        :del
    endfor
endf

function! CopyFile() range
    for linenum in range(a:firstline, a:lastline)
        "Replace loose ampersands (as in DeAmperfy())...
        let curr_line = getline(linenum)
        let cmd=''

        if filereadable(curr_line)
            "Directory
            let cmd='!$HOME/repo/scripts/mob.sh '.Trans(curr_line)
            echo cmd
            :execute cmd
        endif
    endfor
endf

function! ChDir()
    let cmd=''
    let line=getline(".")

    if !filereadable(line)
        "Directory
        let cmd=':cd '.Trans(line)
    else
        let cmd=':cd '.Trans(DirName(line))
    endif
    :execute cmd
    ":echo cmd
    :sh
endf

function! DirName(line)
    let idx=strridx(a:line,'/')
    return strpart(a:line,0,idx)
endf

function! Trans(line)
    let line=Trim(a:line, ' ')
    let line=substitute(line,"'","\\\\'","g")
    let line=substitute(line,' ','\\ ','g')
    let line=substitute(line,'!','\\!','g')
    let line=substitute(line,'#','\\#','g')
    let line=substitute(line,'&','\\&','g')
    let line=substitute(line,'(','\\(','g')
    let line=substitute(line,')','\\)','g')
    return line
    "return "'".line."'"
    "return "'".substitute(a:line,"'","'\\\\''","g")."'"
endf
