" Ignore case in searches and commands
set smartcase

" Enable Mouse support in all modes
set mouse=a

" Highlight all search matches (turn off temporarily with :nohlsearch)
set hlsearch

" Automatically indent when starting a new line
set autoindent

" Enable line numbers
set number

" Set completion mode for wildcards
set wildmode=longest,list

" Set indentation on for the plugin filetype
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Set textwidth to 80
" set tw=80

" Set fancy colors
set termguicolors

" Expand tabs to spaces
set expandtab

" Press ctrl+s for spell-check options
map <C-s>ea :set spell spelllang=en_us<CR>
map <C-s>eb :set spell spelllang=en_gb<CR>
map <C-s>n :set spell spelllang=nl<CR>
map <C-s><C-s> :set nospell<CR>

" Set the default shiftwidth to 4
set shiftwidth=4

" Shortcuts for shiftwidth
noremap <C-t>8 :set shiftwidth=8<CR>
noremap <C-t>4 :set shiftwidth=4<CR>
noremap <C-t>3 :set shiftwidth=3<CR>
noremap <C-t>2 :set shiftwidth=2<CR>


call plug#begin()

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'niklasl/vim-rdf'
Plug 'whonore/Coqtail'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-easy-align'
Plug 'prettier/vim-prettier'
Plug 'ziglang/zig.vim'
"NEW_PLUG (add new Plug lines above this line)

call plug#end()

"---- preservim/nerdtree ----

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

"let g:airline#extensions#ale#enabled = 1

"---- vim-airline/vim-airline-themes ----
"let g:airline_theme='simple'

"---- lervag/vimtex ----
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'evince'

" Close the quickfix/linter window when a key is pressed
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

let g:vimtex_quickfix_open_on_warning = 0

nmap <C-t> <Plug>(vimtex-toc-toggle)

let g:vimtex_complete_close_braces = 1

" For DERP
if @% == 'hoofdstuk*.tex'
	let b:main_tex_file='samenvatting.tex'
endif

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"---- neoclide/coc.vim ----

let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-rust-analyzer',
            \ 'coc-tsserver',
            \ 'coc-eslint',
            \ 'coc-vimtex',
            \ 'coc-python',
            \ 'coc-omnisharp',
            \ 'coc-docthis',
            \ 'coc-zig',
\]

nnoremap <A-CR> :CocAction<CR>
nnoremap <leader>dt :CocCommand docthis.documentThis<CR>

" ----- Parts of coc example configuration -----

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience. 
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" No clue why, but this seems to be needed
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ----- End of parts of coc example configuration -----

"---- junegunn/vim-easy-align ----

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"---- ziglang/zig.vim ----
" The zig formatter often sucks
let g:zig_fmt_autosave = 0

