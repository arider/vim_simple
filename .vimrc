set nocompatible              " be iMproved, required
filetype off                  " required

" Docs {{{
" --- Docs ---
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USEFUL COMMANDSs
" ### tabs ###
" <C-W>T -- move the current window to a new tab.
" gt -- switch to next tab.
" 3gt -- switch to 3rd tab
" :tabonly -- close all other tabs.
"
" ### tags ###
" <C-W>} -- open small window to definition.
" <C-]> -- jump to def.
" <C-t> -- jump back to start.
" ############
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

" Plugin management.. {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " ### Favorites ###
    Plug 'junegunn/vim-plug'
    Plug 'tpope/vim-obsession'
    Plug 'roman/golden-ratio'
    Plug 'unblevable/quick-scope'
    Plug 'ajh17/VimCompletesMe'
    Plug 'zakj/vim-showmarks'
    Plug 'luochen1990/rainbow'
    Plug 'JuliaLang/julia-vim'

    " ### Rare but nice ###
    Plug 'scrooloose/nerdtree'
    Plug 'wesQ3/vim-windowswap'

    " Not so sure.
"    Plug 'sjl/gundo.vim'
"    Plug 'tpope/vim-endwise'
"    Plug 'tpope/vim-surround'
"
"    TODO: Need to change mappings for this
"    Plug 'ap/vim-buftabline'
"    Plug 'godlygeek/tabular'
call plug#end()

" toggle gundo -- plugin binding.
"nnoremap <leader>u :GundoToggle<CR>

"" Nerdtree mapings
map <C-n> :NERDTreeToggle<CR>
"""autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeShowHidden=1

" Set use rainbow
let g:rainbow_active = 1

" VimCompletesMe settings
autocmd FileType py,go,jl let b:vcm_tab_complete = 'omni'
set complete+=t


" }}}

" Manage session {{{
let g:session_name = $HOME . '/.vim/sessions/' . join(split(getcwd(), '/') + ['session.vim'], '_')
function! HandleSession(session_name)
    if !(filereadable(a:session_name))
        exe ':Obsess ' . a:session_name
    else
        exe ':source ' . a:session_name
    endif
endfunction
au VimEnter * call HandleSession(session_name)
" }}}

" Tab (space) and indent / fold behavior. {{{
" --- Tab (space) and indent / fold behavior. ---
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Minimize code based on indent.
set foldmethod=indent
set foldlevel=99
set foldenable          " enable folding.
set foldlevelstart=10   " open most folds by default.
set foldnestmax=10      " 10 nested fold max.
" space open/closes folds.
nnoremap <space> za

" }}}

" Language specific filetype settings. {{{
" --- Language specific filetype settings. ---
augroup configgroup
    " Highlight Class and Function names
    " Add function call highlighting (not perfect).
    autocmd BufEnter *.* syn match    cCustomParen    "(" contains=cParen,cCppParen
    autocmd BufEnter *.* syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
    autocmd BufEnter *.* syn match    cCustomScope    "::"
    autocmd BufEnter *.* syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
    autocmd BufEnter *.* hi link cCustomFunc  Function
    autocmd BufEnter *.* hi link cCustomClass Function

    autocmd BufWritePost *.* syn match    cCustomParen    "(" contains=cParen,cCppParen
    autocmd BufWritePost *.* syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
    autocmd BufWritePost *.* syn match    cCustomScope    "::"
    autocmd BufWritePost *.* syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
    autocmd BufWritePost *.* hi link cCustomFunc  Function
    autocmd BufWritePost *.* hi link cCustomClass Function

""    " Julia settings.
""    autocmd FileType julia
""        \ let b:endwise_addition = 'end' |
""        \ let b:endwise_words = 'module,struct,if,else,while,for,elseif'
augroup END
" }}}

" Misc. {{{
" --- Misc ---

" Store temporary files in a central spot,
" instead of all over the place:
if has('unix')
	set backupdir=~/.swp
	set directory=~/.swp
endif

syntax on
set backspace=indent,eol,start

colorscheme gremlin

set wildmenu            " visual autocomplete for command menu.
set wildmode=full     " Need this for the session management trick.
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]a
set nowrap

set autoindent
set copyindent
"set textwidth=79

" " Enable block-wize movements for julia
" runtime macros/matchit.vim

" highlight last inserted text
" nnoremap gV `[v`]

" Jump to last position on enter.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Keep the cursor in the center of the window.
set scrolloff=999

" Hide buffers instead of closing them.
set hidden
" Use shiftwidth instead of tab width at start of line.
set smarttab

" Undo history.
set history=1000
set undolevels=1000
" Ignore files like these for path matching.
set wildignore=*.swp,*.bak,*.pyc,*.class
" change the terminal's title
set title
" set paste / nopaste
set pastetoggle=<F2>
" }}}

" Search behavior. {{{
" --- Search behavior. ---
set hlsearch
hi SpellBad ctermfg=001 ctermbg=015 guifg=#d75f00 guibg=#d75f00
hi SpellCap ctermfg=002 ctermbg=007 guifg=#d75f00 guibg=#d75f00
hi Search cterm=NONE ctermfg=black ctermbg=007
set incsearch           " search as characters are entered.
" Ignore case when searching.
"set ignorecase
" Ignore case when search string is all lower.
set smartcase
" }}}

" Custom keybindings. {{{
" --- Custom keybindings. ---

" set <Leader> as ; and replace esc with ;j
let mapleader=';'
nnoremap <Leader>j <Esc>:w<CR>
onoremap <Leader>j <Esc>:w<CR>
inoremap <Leader>j <Esc>`^:w<CR>
inoremap <Leader>j <Esc>:w<CR>
" Set how long to wait between multiple character keybindings.
set timeoutlen=100

" Numbers on the left side.
set number
set relativenumber
" Toggle numbers on and off.
nnoremap <Leader>n :set nonumber! norelativenumber!<CR>

" line comments
" au FileType py map <Leader>q 0i#<Leader>j
" au FileType go map <Leader>q 0i//<Leader>j

" Make tag file in working directory.
command! Mt !ctags -R .

" Navigation between windows.
" Max out the height of the current split
" ctrl + w _
" Max out the width of the current split
" ctrl + w |
" Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Overwrite windowswap default mappings.
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>w :call WindowSwap#EasyWindowSwap()<CR>
" }}}

" Highlighting stuff {{{

" Highlight all occurences of word under cursor.
autocmd CursorMoved * silent! exe printf('match PMenu /\<%s\>/', expand('<cword>'))


" ############# toggle color current column #############
"nnoremap <Leader>h :set colorcolumn=virtcol('.')<CR>
function! ToggleHLCol()
    if &colorcolumn
        setlocal colorcolumn&
    else
        let &colorcolumn=virtcol('.')
    endif
endfunction

nnoremap <silent> <Leader>h :call ToggleHLCol()<CR>

" Marks plugin
let g:showmarks_enable=1
let g:showmarks_include='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
highlight ShowMarksHLl ctermbg=grey
highlight ShowMarksHLu ctermbg=grey

let g:showmarks_hlline_lower=1
let g:showmarks_hlline_upper=1
nmap <silent> <unique> <leader>c :ShowMarksClearAll<cr>
nmap <silent> <unique> <leader>m :ShowMarksPlaceMark<cr>
" }}}


" This has to be at the end for nice formatting of this file.
" vim:foldmethod=marker:foldlevel=0
