" Modeline and Notes {
    " vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
    " This is the personal .vimrc file of Adam Vaughn for Python files.
" }

" General {
    filetype indent on
" }

" Folding {
    set foldmethod=indent
    set foldlevel=99
" }

" Formatting {
    set tabstop=8
    set expandtab
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set smarttab
    set formatoptions=croql
    set textwidth=79
" }

" Key Maps {
    nnoremap <buffer> <silent> <F3> :w<CR>:!python %<CR>
" }

" Plugins {
    " SuperTab {
        set omnifunc=pythoncomplete#Complete
        set completeopt=menuone,longest,preview

        let g:SuperTabDefaultCompletionType = "context"
    " }

    " PyFlakes {
        let g:pyflakes_use_quickfix = 0
    " }
" }
