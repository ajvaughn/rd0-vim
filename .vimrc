" Modeline and Notes {
    " vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
    " This is the personal .vimrc file of Adam Vaughn.

    " It is based heavily on the one by Steve Francia (https://github.com/spf13/spf13-vim.git).
" }

" Environment {
    " Basics {
        set nocompatible " This must be the first line.
        set background=dark " Assume a dark background.
    " }

    " Windows Compatibility {
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Pathogen {
        call pathogen#infect() " Add everything under .vim/bundle to the runtimepath.
        call pathogen#helptags()
    " }
" }

" General {
    set background=dark

    if !has('win32' ) && ! has('win64')
        set term=$TERM " Make arrow keys and others work.
    endif

    filetype plugin indent on " Automatic file type detection
    syntax on " Syntax highlighting

    set autochdir " Always switch to the directory of the current file.

    scriptencoding utf-8

    set shortmess+=filmnrxoOtT " Abbreviation of messages to avoid 'Hit ENTER' prompts
    set viewoptions=folds,options,cursor,unix,slash " Consistency between Windows and UNIX
    set virtualedit=onemore " Allow cursor beyond last character.
    set history=1000 " Save up to 1000 actions in history.
    set spell " Turn on spell checking.

    " Directories {
        set backup " Use backups.
        set undofile " Use persistent undo.
        set undolevels=1000 " Undo up to 1000 changes.
        set undoreload=10000 " Maximum 10000 lines to save for undo on a buffer reload

        au BufWinLeave * silent! mkview " Save view state when leaving a buffer.
        au BufWinEnter * silent! loadview " Load view state when entering a buffer.
    " }
" }

" UI {
    colorscheme solarized " Use the solarized colorscheme.

    set tabpagemax=15 " Show only 15 tabs.
    set showmode " Display the current mode.

    set cursorline " Highlight the current line.
    hi cursorline guibg=#333333 " Highlight color of the current line
    hi CursorColumn guibg=#333333 " Highlight the cursor.

    if has('cmdline_info')
        set ruler " Show the ruler.
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
        set showcmd " Show partial commands in the status line and selected region in visual mode.
    endif

    if has('statusline')
        set laststatus=2

        " Awesome status line.
        set statusline=%<%f\ " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} " Git
        set statusline+=\ [%{&ff}/%Y] " File type
        set statusline+=\ [%{getcwd()}] " Current directory
        set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file navigation information
    endif

    set backspace=indent,eol,start " Expected backspace functionality
    set linespace=0 " No extra spaces between rows
    set number " Line numbers on
    set showmatch " Show matching brackets.
    set incsearch " Use incremental search.
    set hlsearch " Highlight search terms.
    set winminheight=0 " Allow windows to use 0 line height.
    set ignorecase " Case insensitive search
    set smartcase " Case sensitive search when upper case search terms used
    set wildmenu " Show list instead of just completing.
    set wildmode=list:longest,full " Command <Tab> completion, list matches, then longest common part, then all
    set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys to wrap
    set scrolljump=5 " Scroll five lines when the cursor leaves the screen.
    set scrolloff=3 " Keep a minimum of 3 lines above and below the cursor.
    set foldenable " Auto fold code
    set gdefault " Use the /g flag on :s commands by default.
    set list
    set listchars=tab:>.,trail:.,extends:#,nbsp:.
" }

" Formatting {
    set nowrap " Wrap long lines.
    set autoindent " Automatically indent to the level of the last line.
    set shiftwidth=4 " Use indents of 4 spaces.
    set expandtab " Use spaces instead of tabs.
    set tabstop=4 " An indentation every 4 columns
    set softtabstop=4 " Let backspace delete an indent.
    set pastetoggle=<F12> " Use same indentation on pastes.

    " Remove trailing spaces
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Key Maps {
    " Change the mapleader to ,
    let mapleader = ','

    " Eliminate common typos.
    nnoremap ; :
    cmap W w
    cmap WQ wq
    cmap wQ wq
    cmap Q q
    cmap Tabe tabe

    " Quick movement in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Go to next row on wrapped lines when using j and k instead of going to the next line in the file.
    nnoremap j gj
    nnoremap k gk

    " Set Y to yank from cursor to end of line.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " <leader>/ clears highlighted search.
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Allow shifting in visual mode.
    vnoremap < <gv
    vnoremap > >gv

    " Fix home and end key bindings in screen.
    map [F $
    imap [F $
    map [H g0
    map [H g0

    " Write the file when sudo is forgotten.
    cmap w!! w !sudo tee % >/dev/null

    " Toggle line numbers with <F2>
    nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
" }

" Functions {
function! InitializeDirectories()
    let separator = '.'
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory',
        \ 'undo': 'undodir'}

    for [dir_name, setting_name] in items(dir_list)
        let dir = parent . '/' . prefix . dir_name . '/'

        if exists("*mkdir")
            if !isdirectory(dir)
                call mkdir(dir)
            endif
        endif

        if !isdirectory(dir)
            echo "Warning: Unable to create backup directory: " . dir
            echo "Try: mkdir -p " . dir
        else
            let dir = substitute(dir, " ", "\\\\ ", "")

            exec "set " . setting_name . "=" . dir
        endif
    endfor
endfunction
call InitializeDirectories()
" }
