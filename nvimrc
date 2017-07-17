"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>


Plug 'vim-airline/vim-airline'

" Improved syntax hilighting, required for themes to look sensible. Requires `syntax on`
Plug 'sheerun/vim-polyglot'

" https://github.com/ndmitchell/ghcid/tree/master/plugins/nvim
" Very fast haskell syntax checking
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

" Solarised theme fixed for truecolor
Plug 'joshdick/onedark.vim'

Plug 'terryma/vim-multiple-cursors'


" Initialize plugin system
call plug#end()


" Standard settings "
"""""""""""""""""""""

set number     " show line numbers
set ruler
set expandtab
set warn
set autoindent
set smartcase
set hlsearch
set showcmd    " show command in bottom bar
set showmatch  " highlight matching [{()}]
set incsearch
set wildmenu   " visual autocomplete for command menu

set mouse=a
set tabstop=2
set shiftwidth=2
set list " Show `listchars` characters
set listchars=tab:=»,trail:·
set laststatus=2
set fillchars+=vert:\
set cc=121
set textwidth=0
set wrapmargin=0
set backspace=indent,eol,start


" Custom settings "
"""""""""""""""""""

" Powerline font support
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" Drop the background color to use the terminal one instead
let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting

syntax on
colorscheme onedark

" Custom Mappings "
"""""""""""""""""""


" Strip whitespace on write
fun! StripTrailingWhitespace()
  if &ft =~ 'vim\|vimrc'
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

" String trailing empty newlines on write
fun! StripTrailingNewlines()
  %s/\($\n\s*\)\+\%$//e
endfun
autocmd BufWritePre * call StripTrailingNewlines()
