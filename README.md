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
