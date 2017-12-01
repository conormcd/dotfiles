set nocompatible

call pathogen#infect()
filetype plugin indent on
syntax on

set autoindent
set autoread
set backspace=eol,indent,start
set clipboard=unnamed
set complete=.,t
set encoding=utf-8
set history=500
set hlsearch
set incsearch
set laststatus=2
set modelines=10
set mouse=a
set nofoldenable
set nowrap
set ruler
set smartindent
set title
set viminfo='50,\"50

let mapleader = ","

inoremap # X#
nnoremap <CR> :nohlsearch<CR>

autocmd BufNewFile,BufRead Berksfile set filetype=ruby
autocmd BufNewFile,BufRead Thorfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
autocmd FileType markdown,plaintex,tex,text setlocal textwidth=78

" Language-specific syntax tweaks
let g:markdown_fenced_languages = ['bash=sh', 'clojure', 'go', 'java', 'php', 'python', 'ruby', 'sh']
let java_highlight_debug = 1
let java_space_errors = 1
let php_htmlInStrings = 1
let php_sql_query = 1
let python_space_error_highlight = 1
let ruby_space_errors = 1

"
" Plugin configs from here down
"

" PLUGIN:github.com/w0rp/ale
let g:ale_completion_enabled = 1
call ale#linter#Define('clojure', {
\   'name': 'cljlint',
\   'output_stream': 'stdout',
\   'executable': 'cljlint',
\   'command': 'cljlint %t',
\   'callback': 'ale#handlers#unix#HandleAsError',
\})

" PLUGIN:github.com/rizzatti/dash.vim
nmap <silent> <leader>d <Plug>DashSearch

" PLUGIN:github.com/conormcd/matchindent.vim

" PLUGIN:github.com/vim-scripts/paredit.vim

" PLUGIN:github.com/kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 15
autocmd Filetype clojure RainbowParenthesesActivate
autocmd Syntax clojure RainbowParenthesesLoadRound

" PLUGIN:github.com/ervandew/supertab
let g:SuperTabCompletionContexts = ['ClojureContext', 's:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
function! ClojureContext()
  let curline = getline('.')
  let cnum = col('.')
  let synname = synIDattr(synID(line('.'), cnum - 1, 1), 'name')
  if curline =~ '(\S\+\%' . cnum . 'c' && synname !~ '\(String\|Comment\)'
    return "\<c-x>\<c-o>"
  endif
endfunction

" PLUGIN:github.com/vim-airline/vim-airline

" PLUGIN:github.com/guns/vim-clojure-static
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1
let g:clojure_maxlines = 100

" PLUGIN:github.com/tpope/vim-commentary

" PLUGIN:github.com/tpope/vim-endwise

" PLUGIN:github.com/tpope/vim-fireplace

" PLUGIN:github.com/tpope/vim-fugitive

" PLUGIN:github.com/tpope/vim-git

" PLUGIN:github.com/jamessan/vim-gnupg
