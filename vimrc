"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'jbohren-forks/vim-gitgutter'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-rails'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


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
set wrapmargin=0
set backspace=indent,eol,start

" Custom settings "
"""""""""""""""""""
" Unite mappings
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <C-f> :Unite grep:.<cr>


" Powerline font support
let g:airline_powerline_fonts = 1

" Custom Mappings "
"""""""""""""""""""

" One less keystroke!
map ; :

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


" Gitgutter
highlight clear SignColumn
let g:gitgutter_sign_column_always = 1

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
