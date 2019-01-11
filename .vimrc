" Plugins {{{

set nocompatible
filetype off

call plug#begin()

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/vim-zsh'
Plug 'elzr/vim-json'
Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'lervag/vimtex'

Plug 'Raimondi/delimitMate'
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'
Plug 'qpkorr/vim-bufkill'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'chrisbra/csv.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

" }}}

" Options {{{

set nocompatible
syntax on
filetype plugin indent on

set autoread
set autowrite
set backspace=2
set belloff=all
set clipboard=unnamed
set conceallevel=2
set cmdheight=2
set encoding=utf-8
set expandtab
set fileformats=unix,dos

set history=1000
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    let &listchars = "space:\u00b7,tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    let &fillchars = "vert:\u259a,fold:\u00b7"
else
    set listchars=space:.,tab:>\ ,trail:-,extends:>,precedes:<
endif
set modelines=5
set mouse=a
set nowrap
set pastetoggle=<C-p>
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
set softtabstop=4
set spellfile=~/.vim/spell/dict.utf-8.add
set spelllang=en,el
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%*%=%-14.(%l,%c%V%)\ %P
set tabstop=4
set t_ti= t_te= " Don't use alternate screen
set timeout timeoutlen=1000 ttimeoutlen=100 " Fix slow O inserts
set title
set ttyfast
set updatetime=100
set viminfo='100,\"1000
set wildignore+=.git,.hg,.svn,tmp,log
set wildignore+=*.o,*.pyc,*.pyo,*.so
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=.DS_Store
set wildignore+=*.orig
set wildignore+=tags
set wildignore+=*.egg-info
set wildignore+=build,dist,__pycache__,.pytest_cache,.tox,.coverage
set wildmenu
set wildmode=longest:full,full

if has('gui_running')
    set lines=25
    set columns=80
    set guioptions=egmt
    set guifont=Menlo:h12
endif

" }}}

" Autocommands {{{

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Jump to the last position when reopening a file
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
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
    autocmd!
    autocmd FileType python,ruby setlocal cc=120
    autocmd FileType c,cpp,java,go setlocal cc=120
    autocmd FileType javascript,python,ruby,sh,zsh,go setlocal ai
    autocmd FileType c,cpp,java setlocal ci
    autocmd FileType c,cpp,java,go,javascript,python,ruby,sh,zsh autocmd BufWritePre <buffer> :call StripTrailingWhitespace()
augroup END

augroup ft_python
    autocmd!
    autocmd FileType python setlocal makeprg=prospector\ %:S
    autocmd BufNewFile,BufRead *requirements.txt,**/requirements/*.txt setlocal nospell
augroup END

augroup ft_ruby
    autocmd!
    autocmd BufNewFile,BufRead Capfile,Rakefile,Vagrantfile setlocal ft=ruby
    autocmd FileType ruby setlocal et sts=2 sw=2 ts=2
augroup END

augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal fdm=marker
augroup END

augroup ft_markdown
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.mkd setlocal ft=markdown
    autocmd FileType markdown setlocal spell tw=78
augroup END

augroup ft_make
    autocmd!
    autocmd FileType make setlocal noet nolist sw=8 ts=8
augroup END

augroup ft_yaml
    autocmd!
    autocmd BufNewFile,BufRead *.yml.sample setlocal ft=yaml
    autocmd FileType yaml setlocal et sts=2 sw=2 ts=2
augroup END

augroup ft_html
    autocmd!
    autocmd FileType html setlocal et sts=2 sw=2 ts=2
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

" Backup/swap/undo {{{

set backup
set undofile
set undoreload=10000

set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

" Key bindings {{{

let mapleader=','

" Remove trailing white space http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <silent><leader>c :call StripTrailingWhitespace()<CR>

nnoremap <leader>l :setlocal list!<CR>
nnoremap <leader>n :setlocal number!<CR>
nnoremap <leader>s :setlocal spell!<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

" }}}

" Runtime {{{

let python_highlight_all=1
let ruby_space_errors=1
let g:vim_markdown_autowrite=1

let NERDTreeChDirMode=2
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1

" }}}

" Printing {{{

set printexpr=PrintFile(v:fname_in)
set printoptions=syntax:n,paper:A4

function! PrintFile(fname)
    call system("lp " . a:fname)
    call delete(a:fname)
    return v:shell_error
endfunc

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

" }}}

