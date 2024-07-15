" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'mg979/vim-visual-multi'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'ledger/vim-ledger'
Plug 'plasticboy/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" }}}

" Options {{{

color lunaperche

set autoindent
set autoread
set autowrite
set backspace=2
set belloff=all
set clipboard+=unnamed
set complete+=kspell
set conceallevel=2
set encoding=utf-8
set expandtab
set fileformats=unix
set history=1000
set hlsearch
set incsearch
set laststatus=2
set listchars = "space:\u00b7,tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
set fillchars = "vert:\u259a,fold:\u00b7"
set modelines=5
set mouse=a
set nowrap
set number
set numberwidth=5
set report=0
set ruler
set scrolloff=1
set smarttab
set shiftround
set shiftwidth=4
set shortmess+=I
set showcmd
set showmode
set showmatch
set smartcase
set smarttab
set softtabstop=-1
set spellfile=~/.vim/spell/dict.utf-8.add
set spelllang=en,el
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%*%=%-14.(%l,%c%V%)\ %P
set termguicolors
set timeout timeoutlen=1000 ttimeoutlen=100 " Fix slow O inserts
set title
set viminfo='100,\"1000
set wildignore+=*.o,*.pyc,*.pyo,*.so
set wildignore+=.DS_Store
set wildignore+=*.egg-info
set wildignore+=build,dist,__pycache__,.pytest_cache,.tox,.coverage,.mypy_cache
set wildignore+=target
set wildmenu
set wildmode=longest:full,full

" }}}

" Autocommands {{{

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Jump to the last position when reopening a file
autocmd BufReadPost *
            \ if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif

augroup ft_text
    autocmd!
    autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO
                \ if &filetype == "" |
                \   set ft=text |
                \ endif
    autocmd FileType text setlocal spell fo=tcwan1 tw=78
    autocmd FileType text map <leader>f :%!fmt<CR>
augroup END

augroup ft_mail
    autocmd!
    autocmd FileType mail setlocal spell fo=tcwan1
augroup END

augroup ft_prog
    autocmd FileType c,cpp,java,javascript,python,ruby,sh,zsh
                \ autocmd BufWritePre <buffer> :call StripTrailingWhitespace()
augroup END

augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal fdm=marker
augroup END

" http://vim.wikia.com/wiki/Encryption#GPG
augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg set viminfo=
    " We don't want a various options which write unencrypted data to disk
    autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg let ch_save=&ch|set ch=2
    " (If you use tcsh, you may need to alter this line.)
    autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg2 --decrypt 2> /dev/null

    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg let &ch=ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    " (If you use tcsh, you may need to alter this line.)
    autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost *.gpg u
augroup END

augroup ui_settings
    autocmd VimEnter * if !has("gui_running") | set notitle noicon | endif
augroup END

" }}}

" Swap/undo {{{

set undofile
set undoreload=10000

setglobal undodir=~/.cache/vim/undo
setglobal directory=~/.cache/vim/swap

call mkdir(&undodir, 'p')
call mkdir(&directory, 'p')

" }}}

" Key bindings {{{

let mapleader=' '

" Remove trailing white space http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <silent><leader>c :call StripTrailingWhitespace()<CR>

nnoremap <leader>l :setlocal list!<CR>
nnoremap <leader>n :setlocal number!<CR>
nnoremap <leader>s :setlocal spell!<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

" }}}

" Runtime {{{

let g:vim_markdown_frontmatter=1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:gutentags_ctags_exclude_wildignore=1

" }}}

" Functions {{{

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

function! Today()
    let today = strftime("%Y\/%m\/%d")
    exe "normal a". today
endfunction
command! Today :call Today()

" }}}

