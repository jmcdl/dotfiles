""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show line numbers
set number
" Lines of history to remember
set history=500

" Highlight search results
set hlsearch

" Filetype detection, plugins, and indent rules
filetype plugin indent on

" Readability
syntax on

" Use spaces instead of tabs
set expandtab
set softtabstop=4
set backspace=indent,eol,start  " more powerful backspacing

set autoindent "Use indent from current line for next line
set autoread "Detect when file changes outside of Vim
set smartindent "Be clever when code cues are recognized
set wrap "Wrap lines

" Spell check and line wrap for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
