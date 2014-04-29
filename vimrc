" Assembled from http://blog.mojotech.com/post/68181056882/a-veterans-vimrc

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>t :tabe <C-R>=expand("%:p:h") . '/'<CR>

map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-t>  <esc>:tabnew<CR>
map <C-x>  <C-w>c


" set t_kb
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
let g:markdown_github_languages = ['ruby', 'erb=eruby', 'javascript']

" reopen file at the same line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" F5 removes all trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

colorscheme smyck "github  solorized slate railscasts ron, murphy
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
set cursorline

" Search Settings
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set nohlsearch  " dont highlight search results

" make regexp search not suck by default -
nnoremap / /\v
vnoremap / /\v

" make capital w/q actually write/quit
cnoreabbrev W w
cnoreabbrev Q q

" remap'd keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <Tab><Tab> <C-W>w

" Softtabs, 2 spaces
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
set autowrite " Automatically :write before running commands

" Wrapping
set nowrap
set linebreak
" :Wrap command to turn on wrapping mapped to \w
command! -nargs=* Wrap set wrap! nolist! wrap?
nnoremap <Leader>w :Wrap<CR>
" Make wrapped lines easier to read
let &showbreak=repeat(' ', 14)

" Display extra whitespace
set list listchars=tab:»·,trail:·

" more normal splits
set splitbelow
set splitright

set laststatus=2  " Always show status line.

" match ruby blocks on %
runtime macros/matchit.vim

" wrap git messages at 72
autocmd Filetype gitcommit setlocal spell textwidth=72

" Use The Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " use git grep
  set grepprg=git\ grep\ --no-color
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_use_caching = 0
  " bind K to grep word under cursor
  "nnoremap K :Ggrep <C-R>=expand("<cword>")<CR><CR>
endif
autocmd QuickFixCmdPost *grep* cwindow

" use zsh as shell
set shell=/bin/zsh

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

