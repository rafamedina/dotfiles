"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Personal plugins
Plug 'scrooloose/nerdtree'
" Plug 'numkil/ag.nvim'
Plug 'tpope/vim-commentary'
Plug 'fortino645/vim-swap-lines'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rizzatti/dash.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load clojure plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'liuchengxu/vim-clap'
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'liquidz/vim-iced-asyncomplete', {'for': 'clojure'}
Plug 'kien/rainbow_parentheses.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}
" Initialize plugin system.
call plug#end()

" => Configure clojure plugins
let g:iced_enable_default_key_mappings = v:true
aug MyVimIcedSetting
  au!
  au VimEnter * call iced#nrepl#auto_connect()
aug END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set encoding=utf8 
scriptencoding utf-8
"-- FOLDING --
set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=1 "defines 1 col at window left, to indicate folding
set foldlevelstart=99 "start file with all folds opened
noremap <space> za

"Relative number
set relativenumber
set number
"Mouse support

set mouse=a

"General mapping
let mapleader = ","
map <Leader>s <Esc>:w<CR>
imap <Leader>s <Esc>:w<CR>
imap <Leader>q <Esc>:q!<CR>
map <Leader>q <Esc>:q!<CR>
" if eslintrc file present use eslint, else use standard
if findfile('.eslintrc', '.;') !=# ''
let g:neomake_javascript_enabled_makers = ['eslint']
" load local eslint in the project root to avoid global plugin installations
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
else
let g:neomake_javascript_enabled_makers = ['standard']
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Highlight 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow parenthesis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"NERDTree map
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw=0
"
" Jump to the main window.
autocmd VimEnter * wincmd p
"
"Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
"
"Indentation
set expandtab
set shiftwidth=2
set softtabstop=2
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
" syntax enable

try
    "colorscheme solarized
    colors gruvbox
catch
endtry

set background=dark

" Set Vagrantfile colors
au BufRead,BufNewFile Vagrantfile set ft=ruby

"Clipboard
" set clipboard+=unnamed
vnoremap <C-c> "+y

"Swipe lines
noremap <silent> <c-k> :call <SID>swap_up()<CR>
noremap <silent> <c-j> :call <SID>swap_down()<CR>

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"



"omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css,less,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

"Cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


