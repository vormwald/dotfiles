" vimrc examples
" - http://blog.mojotech.com/post/68181056882/a-veterans-vimrc

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" use zsh as shell
set shell=/bin/zsh

" set t_kb
fixdel
" TODO, this is a workaround for iterm2 2.0 ?
set backspace=indent,eol,start
set t_kD=^[[3~

" dont use backup files
set nobackup
set noswapfile
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp   " store swap files here

" Setup term color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

set history=100     " Default history is only 20
set undolevels=100  " Use more levels of undo

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Ruler on
set ruler

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vsplit <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>t :tabe <C-R>=expand("%:p:h") . '/'<CR>

" go to file in tab / vertical split / split
map <Leader>tgf <C-w>gf
map <Leader>sgf <C-w>f
nnoremap <silent> <Leader>gf :vertical botright wincmd f<CR>

" easier save
map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-x>  <C-w>c

" Line numbers on
set nu
" easy relative numbers toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <Leader>n :silent call NumberToggle()<cr>

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" make markdown work with .md as well as .markdown
au BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setlocal spell
let g:markdown_github_languages = ['ruby', 'erb=eruby', 'javascript']
" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" reopen file at the same line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

colorscheme jellybeans "smyck solorized slate railscasts ron, murphy
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
set cursorline

" Search Settings
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set nohlsearch  " dont highlight search results
set hlsearch

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

" source $MYVIMRC reloads the saved $MYVIMRC
:nmap <Leader>S :source $MYVIMRC<CR><CR>
" opens $MYVIMRC for editing
:nmap <Leader>E :e $MYVIMRC<CR><CR>

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

" draw a line at column 80
set textwidth=80
let &colorcolumn=join(range(80,80),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" set custom cursor -- vertical bar in insert mode (iTerm2)
" from http://www.iterm2.com/#/section/documentation/escape_codes
if !has("gui")
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" if using iterm and my light profile, lighten things up
if $ITERM_PROFILE == 'Light'
  colorscheme github
  highlight ColorColumn ctermbg=255 guibg=#121212
  " copied this line from above
  hi CursorLine cterm=none
endif

" Close the quickfix when it's the last thing open
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Surround.vim
" leader-a then a thing will surround the current word with that thing
map <Leader>a ysiw

" NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP + ctags
nnoremap <leader>p :CtrlPTag<CR>

" WindowSwap settings
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

let g:airline_powerline_fonts = 1

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

