" Assembled from http://blog.mojotech.com/post/68181056882/a-veterans-vimrc

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-t>  <esc>:tabnew<CR>
map <C-x>  <C-w>c


"set t_kb
fixdel

" Setup term color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif


set history=100     " Default history is only 20
set undolevels=100  " Use more levels of undo

" Ruler on
set ruler

" Line numbers on
set nu

" dont use backup files
set nobackup
set noswapfile
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp   " store swap files here

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" make markdown work with .md as well as .markdown
au BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setlocal spell

colorscheme github  "solorized slate railscasts ron, murphy
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Search Settings
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set nohlsearch  " dont highlight search results

" make regexp search not suck by default -
nnoremap / /\v
vnoremap / /\v

" remap'd keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <Tab><Tab> <C-W>w

" Softtabs, 2 spaces
set autoindent 
set tabstop=2
set expandtab 
set shiftwidth=2
set autowrite " Automatically :write before running commands

" Display extra whitespace
set list listchars=tab:»·,trail:·

"splits stuff
set splitbelow
set splitright

set laststatus=2  " Always show status line.

" match ruby blocks on %
runtime macros/matchit.vim

" wrap git messages at 72
autocmd Filetype gitcommit setlocal spell textwidth=72

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

