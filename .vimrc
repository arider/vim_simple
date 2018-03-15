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

" Vundle plugins {{{
" --- Vundel plugins ---
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'luochen1990/rainbow'
Plugin 'fatih/vim-go'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'sjl/gundo.vim'
Plugin 'ajh17/VimCompletesMe'
Plugin 'unblevable/quick-scope'
Plugin 'tpope/vim-endwise'
Plugin 'roman/golden-ratio'
Plugin 'tpope/vim-surround'
" Plugin 'rhysd/vim-crystal'
Plugin 'wesQ3/vim-windowswap'
Plugin 'JuliaLang/julia-vim'
Plugin 'ap/vim-buftabline'
Plugin 'godlygeek/tabular'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" toggle gundo -- plugin binding.
nnoremap <leader>u :GundoToggle<CR>

" CtrlP settings
" order matches top to bottom.
" let g:ctrlp_match_window = 'bottom,order:ttb'
" Open files in new buffer.
" let g:ctrlp_switch_buffer = 0
" Change the working directory.
" let g:ctrlp_working_path_mode = 0
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" use ag as underlying search for speed.
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Nerdtree mapings
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeShowHidden=1

" Set use rainbow
let g:rainbow_active = 1

" vim-go mappings
" au FileType go nmap ds <Plug>(go-def-split)
" au FileType go nmap ss <Plug>(go-implements-split)
" au FileType go nmap gd <Plug>(go-doc-vertical)
au FileType go nmap gr <Plug>(go-run)
au FileType go nmap gt <Plug>(go-test)
" au FileType go nmap gb <Plug>(go-build)
" au FileType go nmap gc <Plug>(go-coverage)

" VimCompletesMe settings
autocmd FileType py,go let b:vcm_tab_complete = 'omni'
" make it check tags for omni-completion (This is probably redundant -- " vim
" detaults to using tags).
set complete+=t

" }}}

" Tab (space) and indent / fold behavior. {{{
" --- Tab (space) and indent / fold behavior. ---
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Language specific filetype settings. {{{
" --- Language specific filetype settings. ---
augroup configgroup
    " Python
    autocmd FileType python setlocal commentstring=#\ %s
    " flake8 on save python file.
    " au BufReadPost *.py call flake8#Flake8()
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal shiftwidth=2
    autocmd FileType python setlocal softtabstop=2

    " Bash
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    
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

    " Go settings.
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal shiftwidth=4
    autocmd FileType go setlocal softtabstop=4

augroup END
" }}}

" Minimize code based on indent.
set foldmethod=indent
set foldlevel=99
set foldenable          " enable folding.
set foldlevelstart=10   " open most folds by default.
set foldnestmax=10      " 10 nested fold max.
" space open/closes folds.
nnoremap <space> za
" }}}

" Misc. {{{
" --- Misc ---
" Store temporary files in a central spot,
" instead of all over the place:
syntax on
set backspace=indent,eol,start

if has('unix')
	set backupdir=~/.swp
	set directory=~/.swp
endif

set wildmenu            " visual autocomplete for command menu.
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]a
"set textwidth=79

" highlight last inserted text
" nnoremap gV `[v`]

" Jump to last position on enter.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Highlight all occurences of word under cursor.
autocmd CursorMoved * silent! exe printf('match PMenu /\<%s\>/', expand('<cword>'))

" Keep the cursor in the center of the window.
set scrolloff=999

colorscheme gremlin


" Hide buffers instead of closing them.
set hidden
" Ignore case when searching.
" set ignorecase
" Ignore case when search string is all lower.
set smartcase
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

"" Highlight Class and Function names
"syn match    cCustomParen    "(" contains=cParen,cCppParen
"syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
"syn match    cCustomScope    "::"
"syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
"
" hi link cCustomFunc  Function
" hi link cCustomClass Function



" }}}

" Search behavior. {{{
" --- Search behavior. ---
set hlsearch
hi SpellBad ctermfg=001 ctermbg=015 guifg=#d75f00 guibg=#d75f00
hi SpellCap ctermfg=002 ctermbg=007 guifg=#d75f00 guibg=#d75f00
hi Search cterm=NONE ctermfg=black ctermbg=007
set incsearch           " search as characters are entered.
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

" HLMarks {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make highlighted lines that can be jumped to.
" Minor tweaks to version here: https://github.com/AT-AT/hlmarks.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mark the HL marks automatically
autocmd BufReadPost * call HLMarks()

hi Marks term=reverse ctermfg=0 ctermbg=40 guibg=Grey40

function! HLMarks()
        call clearmatches()
        let index = char2nr('a')
        while index < char2nr('z')
                call matchadd( 'WildMenu', '\%'.line( "'".nr2char(index)).'l')
"                call matchadd( a:group, '\%'.line( "'".nr2char(index)).'l')
                let index = index + 1
        endwhile
endfunction

function! AddHLMark()
        let index = char2nr('a')
        while getpos("'".nr2char(index))[2] != 0
                let index = index + 1
        endwhile
        if index != char2nr('z')
                exe 'normal m'.nr2char(index)
                call HLMarks()
        endif
endfunction

function! DelHLMark()
        let index = char2nr('a')
        while index < char2nr('z')
                if line(".") == line("'".nr2char(index))
                        exe 'delmarks '.nr2char(index)
                        call HLMarks()
                        let index = char2nr('z')
                endif
                let index = index + 1
        endwhile
endfunction


" nmap <silent> <Leader>z :call HLMarks()<CR>
" nmap <silent> <Leader>y :call clearmatches()<CR>
nmap <silent> <Leader>c :call clearmatches()\|:delmarks a-z<CR>
nmap <silent> <Leader>m :call AddHLMark()<CR>
nmap <silent> <Leader>d :call DelHLMark()<CR>

nmap <silent> <Leader>f ['
nmap <silent> <Leader>b ]'

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

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""
" WIPS
"""""""""""""""""""""""""""""""""""""""""""""""""



" To get the highlight colors.
" so $VIMRUNTIME/syntax/hitest.vim

" open all java files in this directory subtree as hidden buffers (so we can
" search them for autocomplete) argadd **/.java

" Grep behavior replaced with tags TODO: need to auto-make tags file in
" current directory on open vim.
"
" grep in set paths for word under cursor C-i or current path C-o
" set file types to ignore in vimgrep
" set wildignore+=bin/**,*.pyc
" map <C-i> :execute "vimgrep /" . expand("<cword>") . "/j " . paths <Bar> cw<CR>
" map <C-o> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Change where new splits appear.
" set splitbelow
" set splitright

" Set up folding in this file.
"set foldmethod=marker
"set foldlevel=0
"set modelines=1
" This has to be at the end for nice formatting of this file.
" vim:foldmethod=marker:foldlevel=0
