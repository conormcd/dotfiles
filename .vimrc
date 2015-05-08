set nocompatible				" Make Vim not act like vi

" Just disable YouCompleteMe if there isn't a modern enough vim to handle it.
" We don't really care for a warning on every startup.
if v:version < 703 || (v:version == 703 && !has('patch584'))
	let g:loaded_youcompleteme = 1
endif

call pathogen#infect()			" Load all the things in .vimrc/bundle
" call pathogen#helptags()		" Generate all the docs
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

" Set a leader character for Command-T et al.
let mapleader = ","

" Make smartindent stop outdenting lines beginning with #
inoremap # X#

" F keys
nmap <F7> :call ToggleSpelling()<CR>
nmap <F8> :TagbarToggle<CR>

" Undo search highlighting on enter
nnoremap <CR> :nohlsearch<CR>

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

" Put the cursor back where it was the last time we edited the file.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Powerline customization
let g:Powerline_symbols = 'fancy'
call Pl#Theme#RemoveSegment('fileformat')
call Pl#Theme#RemoveSegment('fileencoding')
call Pl#Theme#RemoveSegment('filetype')

" Syntastic tweaks
let g:syntastic_c_compiler_options = ' -std=c99'
let g:syntastic_php_phpcs_args = '--report=csv --standard=/Users/conor/.phpcs/phpcs.xml'

" YouCompleteMe tweaks
let g:ycm_autoclose_preview_window_after_completion=1

" Dash support
nmap <silent> <leader>d <Plug>DashSearch

" Turn on spell checking
setlocal spelllang=en_gb
function! ToggleSpelling()
	if &spell
		set nospell
	else
		set spell
	endif
endfunction

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/

" I want text wrapping for some file types
autocmd FileType markdown,plaintex,tex,text setlocal textwidth=78

" Python-specific rules
autocmd FileType python call PythonRules()
function! PythonRules()
	highlight TrailingSemiColon ctermbg=red guibg=red
	match TrailingSemiColon /\;$/
endfunction

" Spot Ruby *file files.
autocmd BufNewFile,BufRead Berksfile set filetype=ruby
autocmd BufNewFile,BufRead Thorfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

" Rainbow parens for Clojure
" Remove Black Parens
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
