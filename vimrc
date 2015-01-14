" Plugins "
"""""""""""
filetype off
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jbohren-forks/vim-gitgutter'
Plugin 'slim-template/vim-slim'
Plugin 'junegunn/vim-easy-align'

call vundle#end()
filetype plugin indent on
filetype indent on          " load filetype-specific indent files


" Standard settings "
"""""""""""""""""""""
syntax on
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=16
colorscheme solarized

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
set textwidth=80
set backspace=indent,eol,start

" Custom settings "
"""""""""""""""""""

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:NERDTreeWinSize = 42

" Powerline font support
let g:airline_powerline_fonts = 1

" Custom Mappings "
"""""""""""""""""""

map Y y$

" Ctrl-c/x to copy/cut
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" NerdTree plugin
nmap <leader>f :NERDTreeToggle
nmap <leader>F :NERDTreeFind

"nnoremap <esc> :noh<return><esc>
:noremap <Space>n :cnext<C-m>
:noremap <Space>p :cprev<C-m>

hi VertSplit guibg=#000000 gui=NONE guifg=#414243 ctermfg=235
hi NonText ctermfg=238

" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-S-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Tabularize mappings
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
endif

" CtrlP settings
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v[\/](node_modules)$'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" Gitgutter
highlight clear SignColumn

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

" FZF
set rtp+=~/.fzf

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
