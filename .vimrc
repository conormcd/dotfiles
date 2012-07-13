set nocompatible				" Make Vim not act like vi

call pathogen#infect()			" Load all the things in .vimrc/bundle
call pathogen#helptags()		" Generate all the docs
filetype plugin indent on		" Use the filetype detection magic
syntax on						" Switch syntax highlighting on
set ofu=syntaxcomplete#Complete	" Use omnicomplete

set autoindent				" Turn on automatic indenting
set autoread				" Automatically read files if they've changed
set backspace=2				" Allow you to backspace over everything
set clipboard=unnamed		" Use the system clipboard
set encoding=utf-8			" Try and keep things away from funny encodings
set history=500				" Keep 500 lines of command line history
set hlsearch				" Highlight searches
set incsearch				" Incremental search
set laststatus=2			" Always show the status line.
set modelines=10			" Search the first 10 lines for modes
set mouse=a					" Make the mouse work in all modes
set noexpandtab
set nofoldenable			" Disable folding.
set nowrap					" Turn off wrapping
set ruler					" Show the cursor position all the time
set smartcase				" Case insensitive when all lower case.
set smartindent				" Set smart indenting on
set shiftwidth=4
set softtabstop=4
set tabstop=4
set title					" Put the name of the file in the terminal title
set ttyfast					" Should be activated due to TERM, but anyway...
set viminfo='20,\"50		" Use a viminfo file (remember 20 files, 50 lines)

" Make smartindent stop outdenting lines beginning with #
inoremap # X#

" F keys
nmap <F8> :TagbarToggle<CR>

" Set some syntax highlighting options.
let c_space_errors = 1
let java_allow_cpp_keywords = 1
let java_highlight_java_lang = 1
let java_highlight_java_lang_ids = 1
let java_space_errors = 1
let jproperties_show_messages = 1
let php_sql_query = 1
let php_htmlInStrings = 1
let python_highlight_all = 1
let is_posix = 1

" Powerline customization
let g:Powerline_symbols = 'fancy'
call Pl#Theme#RemoveSegment('fileformat')
call Pl#Theme#RemoveSegment('fileencoding')
call Pl#Theme#RemoveSegment('filetype')

" Snipmate snippets
let g:snippets_dir = '~/.vim/snippets'

" Supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Syntastic tweaks
let g:syntastic_phpcs_disable = 1

" Turn on spell checking
setlocal spell spelllang=en_gb
autocmd FileType gitconfig setlocal nospell

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/

" Python-specific rules
autocmd BufNewFile,BufRead *.py call PythonRules()
autocmd FileType python call PythonRules()
function! PythonRules()
	highlight TrailingSemiColon ctermbg=red guibg=red
	match TrailingSemiColon /\;$/
endfunction

" Text file specific rules
autocmd BufNewFile,BufRead *.txt call PlaintextRules()
autocmd FileType text call PlaintextRules()
function! PlaintextRules()
	setlocal textwidth=78
endfunction
