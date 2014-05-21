file-list
=========

A plugin to open files (automatic choose the proper application using config in vimrc) in vim.

### Configuration
    
add this in your .vimrc:

    "{{{ plugin- deal with filelist
    noremap <leader>co :call OpenFileWithDefApp()<cr>
    noremap <leader>rm :call DelFile()<cr>
    noremap <leader>cd :call ChDir()<cr>
    noremap <leader>to :call CopyFile()<cr>
    let g:applist={
                \'pdf':'evince',
                \'png,gif,jpg':'eog',
                \'rmvb,mkv,flv,avi,mp4,m4v':'mplayer',
                \'mp3,wma,fla':'!mocp %',
                \'rar':'!unrar l %',
                \'epub':'!calibre %',
                \'zip':'!unzip -O CP936 -l %',
                \'pwd':'nautilus',
                \'docx,xlsx,pptx,ppt':'libreoffice',
                \'default':':e %'
                \}
    "}}}

### Usage
    
when met with a file path in your vim. like:
    
    /home/cxh/C++ Primer中文版（第4版）.pdf
    /media/cxh/backup/work/doc/C++应用程序性能优化.pdf
    
you can put cursor on it and press <leader>co to open it with evince.

supports line number linke: a.txt:11

need visualmark.vim to have a strinking effect.

