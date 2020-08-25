set ignorecase
set mouse=v
set hlsearch
set autoindent
set number
set wildmode=longest,list
filetype plugin indent on
syntax on
set tw=80

call plug#begin()

Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'ycm-core/YouCompleteMe'
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

" Fix on F8
nmap <F8> <Plug>(ale_fix)

" Jump to previous or next warning
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-Up> <Plug>(ale_previous_wrap)

nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-Down> <Plug>(ale_next_wrap)

" Details on Tab
nmap <Tab> :ALEDetail<CR>

" Enable quickfix
let g:ale_set_quickfix = 1

" Disable ALE for latex
autocmd FileType tex :ALEDisable

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

" Close the quickfix/linter window when a key is pressed
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

let g:vimtex_quickfix_open_on_warning = 0

nmap <C-t> <Plug>(vimtex-toc-toggle)

"---- ycm-core/YouCompleteMe ----

" Turn off YCM
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
" Turn on YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>

" Also allow enter as completion key
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']

" Latex completion 
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex=['re!\\[A-Za-z]+',
  \ 're!\\(usepackage|RequirePackage)(\s*\[[^]]*\])?\s*\{[^}]*',
  \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
  \ 're!\\begin(\s*\[[^]]*\])?\s*\{[^}]*',
  \ 're!\\end(\s*\[[^]]*\])?\s*\{[^}]*',
  \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
  \ 're!\\(text|block)cquote\*?(\[[^]]*\]){0,2}{[^}]*',
  \ 're!\\(for|hy)[A-Za-z]*cquote\*?{[^}]*}(\[[^]]*\]){0,2}{[^}]*',
  \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
  \ 're!\\hyperref\[[^]]*',
  \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
  \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
  \ 're!\\(include(only)?|input|subfile){[^}]*',
  \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
  \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*']
