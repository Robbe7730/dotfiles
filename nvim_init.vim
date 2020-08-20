set ignorecase
set mouse=v
set hlsearch
set autoindent
set number
set wildmode=longest,list
filetype plugin indent on
syntax on
set tw=80

" Enable ALE completion
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

call plug#begin()

Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
"NEW_PLUG (add new Plug lines above this line)

call plug#end()

"---- preservim/nerdtree ----

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"---- dense-analysis/ale ----
"https://github.com/dense-analysis/ale/blob/master/supported-tools.md

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'sh': ['shfmt'],
\   'python': ['autopep8', 'reorder-python-imports'],
\   'c': ['clang-format'],
\   'json': ['jq'],
\   'md': ['prettier']
\}

nmap <F8> <Plug>(ale_fix)

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-Up> <Plug>(ale_previous_wrap)

nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-Down> <Plug>(ale_next_wrap)

nmap <Tab> :ALEDetail<CR>

let g:ale_set_quickfix = 1

let g:ale_completion_enabled = 1


"---- vim-airline/vim-airline ----
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#:%v%#__accent_bold#/%L%#__restore__#'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.dirty = '*'
let g:airline_symbols.notexists = '?'


let g:airline#extensions#branch#empty_message = 'no branch'

let g:airline#extensions#branch#vcs_checks = ['untracked', 'dirty']

let g:airline#extensions#ale#enabled = 1

"---- vim-airline/vim-airline-themes ----
"let g:airline_theme='simple'

"---- lervag/vimtex ----
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'evince'

nmap <C-t> :VimtexTocToggle<CR>
