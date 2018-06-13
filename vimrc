" example vimrc

" Vim Plug {{{
call plug#begin('~/.vim/bundle')
Plug 'takac/vim-hardtime'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'    " load .editorconfig file
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'gabesoft/vim-ags'
Plug 'Chiel92/vim-autoformat'
Plug 'mhinz/vim-startify'
Plug 'w0rp/ale'
Plug 'isRuslan/vim-es6'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'             " Help with commenting
Plug 'tpope/vim-endwise'               " Smart enc blocks, braces ...
Plug 'tpope/vim-fugitive'              " git
Plug 'tpope/vim-repeat'                " repeat
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter'
Plug '907th/vim-auto-save'
Plug 'kchmck/vim-coffee-script'
Plug 'terryma/vim-expand-region'
Plug 'NLKNguyen/papercolor-theme'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rakr/vim-one'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leshill/vim-json'
Plug 'chrisbra/Colorizer'
Plug 'cakebaker/scss-syntax.vim'
Plug 'janko-m/vim-test'
Plug 'dkprice/vim-easygrep'
Plug 'ervandew/supertab'
" Plug 'sheerun/vim-polyglot'
Plug 'elmcast/elm-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()
" }}}
" PLugin config {{{
" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_switch_bufeqlfer = 0
" }}}
" NERDTree {{{
map <leader>n :NERDTree<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=0
let NERDChristmasTree = 1       " colored NERD Tree
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
let NERDTreeMapActivateNode='<CR>' " map enter to activating a node
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_theme='one'

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode',' ', 'branch'])
  let g:airline_section_b = airline#section#create_left(['ffenc', '%f'])
  let g:airline_section_c = airline#section#create(['filetype'])
  let g:airline_section_x = airline#section#create(['%P'])
  let g:airline_section_y = airline#section#create(['%B'])
  let g:airline_section_z = airline#section#create(['%l', '%c'])
  let g:airline_section_error = airline#section#create(['%{ALEGetStatusLine()}'])
endfunction
" }}}
" ALE Linting {{{
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" }}}
" Startify {{{
let g:startify_change_to_dir = 0
" }}}
" HardTime {{{
let g:hardtime_default_on = 0
" }}}
" GoldenRatio {{{
let g:loaded_golden_ratio = 1
" }}}
" Vim-test {{{
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>
let test#strategy = "dispatch"
" }}}
" The Silver Searcher {{{
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
" }}}
" VimTest {{{
let test#strategy = "basic"
" }}}
" }}}
" Common sense settings {{{
set nocompatible            " do not maintain vi compatibility
let mapleader=","
inoremap jk <ESC>           " remap ESC key
set backspace=2             " Backspace deletes like most programs in insert mode
set history=50
set laststatus=2            " Always display the status line
set autowrite               " Automatically :write before running commands
set hidden                  " Allow new buffer without saving and closing other one
set timeoutlen=500          " Wait only 0,5s for key combination to complete
set encoding=utf-8
set spelllang=en_gb
set nowrap
nmap <silent> <leader>z :set spell!<CR>     " Easily spell check
nnoremap <leader>q <C-w>q
map zx :wqa<CR>
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y yy
" }}}
" Colors {{{
if !exists("g:syntax_on")
  syntax enable       " enable syntax processing
endif
colorscheme one
set background=light
" }}}
" Autocomplete {{{
set completeopt=longest,menuone

autocmd FileType js setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType js setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}
" Autogroups {{{
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd FocusLost * :wa

  " remove trailing whitespaces on saving
  autocmd BufWritePre * :%s/\s\+$//e

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.ejs set filetype=html
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  autocmd FileType javascript setl sw=4 sts=4 et
  autocmd FileType javascript set textwidth=100

augroup END

augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
" }}}
" Backups {{{
set backup
set backupdir=$HOME/.vim/tmp//
set backupskip=/tmp/*,/private/tmp/*
set directory^=$HOME/.vim/tmp//
set writebackup
" }}}
" Spaces & Tabs {{{
set tabstop=2           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 4 space tab
set shiftwidth=2        " Number of spaces to use for each step of (auto)indent.
set shiftround
set modelines=1
filetype indent on      " load filetype-specific indent files
filetype plugin on
set autoindent
" }}}
" UI Layout {{{
set number              " show line numbers
set relativenumber
set numberwidth=5
set ruler               " show the cursor position all the time
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to.
set showmatch           " higlight matching parenthesis
set scrolloff=5   " keep at least 4 lines below cursor
set textwidth=80
set colorcolumn=+1
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" }}}
" Searching {{{
set ignorecase                      " ignore case when searching
set incsearch                       " search as characters are entered
set hlsearch                        " highlight all matches
set smartcase
" No highlight after a search
nnoremap <leader>h :noh<cr>
" search next/previous -- center in page
nmap n nzz
nmap N Nzz

" Open quick fix after grepping
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" Search for visually selected text
vnoremap // y/<C-R>"<CR>
" }}}
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
nnoremap <space> za
" }}}
" Leader Shortcuts {{{
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
vnoremap <leader>y "+y      " yank to clipboard

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y yy

" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>

" Split edit your vimrc. Type ',', v, r in sequence to trigger
nmap <leader>vr :vsp $MYVIMRC<cr>

" " Fix indenting on whole file
" map <leader>i mmgg=G`m
map <leader>i <Plug>(Prettier)

" Shortcut to hide current job
map <leader>. <C-z>
" }}}
" Navigation {{{
set cursorline          " highlight the current line the cursor is on
set suffixesadd+=.js    " add js when searching navigating files using gv
set path+=,,            " paths to search with gv
set splitbelow          " Open new split panes to right and bottom, which feels more natural
set splitright
set mouse=nicr
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]               " highlight last inserted text
nnoremap <leader>. <C-z>        " Switch into background mode
nnoremap <S-Tab> :bprevious<CR> " Move left between splits
nnoremap <Tab> :bnext<CR>       " Move right between splits
nnoremap <leader>w <C-w>v<C-w>1 " Create vertical split
nnoremap <leader>q <C-w>q       " close split


" Visual expand region
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" Normal mode
noremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
"
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" }}}

" vim:foldmethod=marker:foldlevel=0
