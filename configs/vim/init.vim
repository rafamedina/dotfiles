"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Personal plugins
Plug 'scrooloose/nerdtree'
Plug 'numkil/ag.nvim'
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

Plug 'bakpakin/fennel.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'ncm2/float-preview.nvim'
Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' }
Plug 'w0rp/ale'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'chrisbra/Colorizer'
" Conjure
Plug 'Olical/conjure', { 'tag': 'v3.0.0', 'do': 'bin/compile' }
" Initialize plugin system.
" "ANSI colorized 
let g:colorizer_auto_filetype='clojure'
let g:colorizer_disable_bufleave = 1
call plug#end()

" => Configure clojure plugins
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
"" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Find setup 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**
set wildignorecase
" regex completion instead of whole word completion
nnoremap <leader>f :find *
" restrict the matching to files under the directory
" of the current file, recursively
nnoremap <leader>F :find <C-R>=expand('%:p:h').'/**/*'<CR>

" same as the two above but opens the file in an horizontal window
nnoremap <leader>s :sfind *
nnoremap <leader>S :sfind <C-R>=expand('%:p:h').'/**/*'<CR>

" same as the two above but with a vertical window
nnoremap <leader>v :vert sfind *
nnoremap <leader>V :vert sfind <C-R>=expand('%:p:h').'/**/*'<CR>
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
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('file', 'enable_buffer_path', 1)
if !exists('g:deoplete#omni#input_patterns')
  call deoplete#custom#var('omni', 'input_patterns', {})
endif

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"Cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Denite 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 nnoremap <C-p> :Denite file/rec<CR>

" denite file_rec will use ag (ag will use .gitignore)
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
	" For ripgrep
	" Note: It is slower than ag

        " Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction

