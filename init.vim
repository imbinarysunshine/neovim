set nocompatible
filetype off
map <Space> <Leader>
set splitbelow
set splitright
 
call plug#begin()
 
" Load plugins
" VIM enhancements
 
" GUI enhancements
Plug 'machakann/vim-highlightedyank'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"
"Syntax
Plug 'rust-lang/rust.vim'


"Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'w0rp/ale'
Plug 'OmniSharp/omnisharp-vim'

 
call plug#end()

" Tab Config
set softtabstop=4 " Use 4 spaces when pressing tab.
set shiftwidth=4 " Shift indentation by 4 spaces.
set expandtab " Use spaces instead of tab-characters.
set smarttab " Insert tabs on the start of the line according to shiftwidth.

" Color Config

colo base16-eighties
set termguicolors
set background=dark
syntax on
 
" Undo Config
set undodir=~/.vimdid
set undofile
 
set copyindent " Copy the previous indentation on auto indentation
set shiftround " Use multiple of shiftwidth when indenting with < and >
set showmatch " Show matching parenthesis
set cursorline " Highlight the line the cursor is on
set nofoldenable " No folding

set relativenumber " Relative line numbering
set number " Now we have hybrid numbering!
set hidden " Hide buffers instead of closing them
set hlsearch " Highlight search terms
set incsearch " Show mathces as you type
set gdefault " g flag on by default when searching
set fileformats=unix,dos,mac

set scrolloff=5 " Always have 5 lines above and below the cursor
set visualbell " Visual bell instead of beeping
set noerrorbells " Don't ring the error bells
set title


set noswapfile

set nowrap " Don't wrap lines
filetype plugin indent on
set number
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set ttyfast
" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
 
" Remaps
" Ctrl+c and Ctrl+j as Esc
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>q :q<CR>
nnoremap <leader><leader> <c-^>
inoremap jk <Esc>
vnoremap jk <Esc>
nnoremap jk <Esc>
snoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <Esc>
onoremap jk <Esc>
lnoremap jk <Esc>
tnoremap jk <Esc>
nnoremap ; :


" Airline Config
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#checks = []
let g:airline_section_y = airline#section#create_right(['%{printf("%s%s",&fenc,&ff!="unix"?":".&ff:"")}'])
let g:airline_section_z = airline#section#create_right(['%3l:%2c'])
let g:airline#extensions#ctrlp#color_template = 'replace'
let g:airline#extensions#tabline#enabled = 1

" Deoplete Config
 let g:deoplete#enable_at_startup = 1
" Deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

call deoplete#custom#option('sources', {
            \ 'c': ['LanguageClient'],
            \ 'cpp': ['LanguageClient'],
            \ 'rust': ['LanguageClient'],
            \ 'python': ['LanguageClient'],
            \})

" LanguageClient-Neovim setup
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_settingsPath = '/Users/wesleygahr/.config/nvim/settings.json'
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ 'php': ['php', '~/.tooling/php-language-server/bin/php-language-server.php'],
    \ 'sh': ['bash-language-sever', 'start'],
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'javascript': ['~/source/javascript-typescript-langserver/lib/language-server-stdio'],
    \ }

" Ale config
let g:ale_rust_rls_toolchain = "stable"
let g:ale_linters = {
            \ 'python': ['pylint', 'pyls'],
            \ 'rust': ['rls', 'cargo'],
            \ 'php': ['langserver', 'php_cs_fixer'],
            \ 'bash': ['shellcheck'],
            \ 'c': ['ccls']
            \ }

let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \ 'rust': ['rustfmt'],
            \ 'php': ['php_cs_fixer'],
            \ 'bash': ['shfmt'],
            \ 'c': ['uncrustify'],
            \ 'python': ['black'],
            \ }

noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
