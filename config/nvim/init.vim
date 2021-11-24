" leader is spacebar
let mapleader = " "

""
"" Plugin config
""

packadd minpac " Manage plugins with minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Plugin Essentials
call minpac#add('airblade/vim-gitgutter') " display git changes
call minpac#add('chriskempson/base16-vim') " colorschemes
call minpac#add('danro/rename.vim') " easily rename file with :Rename
call minpac#add('janko-m/vim-test') " knows lots of test configs
call minpac#add('junegunn/fzf') " fuzzy finding basics
call minpac#add('junegunn/fzf.vim') " fuzzy finding ++
call minpac#add('mhinz/vim-grepper') " search files
call minpac#add('milkypostman/vim-togglelist') " toggle quickfix/loc list
call minpac#add('mustache/vim-mustache-handlebars') " syntax highlighting for handlebars templates
call minpac#add('radenling/vim-dispatch-neovim') " neovim terminal for dispatch commands
call minpac#add('tpope/vim-dispatch') " async compiler actions
call minpac#add('tpope/vim-fugitive') " git actions
call minpac#add('tpope/vim-rhubarb') " :Gbrowse to view file on github
call minpac#add('tpope/vim-vinegar') " improve netrw
call minpac#add('tpope/vim-unimpaired') " bracket mappings for common actions
call minpac#add('vim-airline/vim-airline') " pretty statusbar
call minpac#add('vim-airline/vim-airline-themes') " pretty statusbar themes

call minpac#add('w0rp/ale') " async Linting Engine

" Ruby/Rails plugins
call minpac#add('tpope/vim-endwise') " add ends to do/if in ruby
call minpac#add('tpope/vim-rails') " projectionist setting for rails
call minpac#add('kana/vim-textobj-user') " add custom text objects
call minpac#add('nelstrom/vim-textobj-rubyblock') " text object for ruby blocks


" JS / React work
call minpac#add('mxw/vim-jsx') " JSX syntax
call minpac#add('pangloss/vim-javascript') " javascript syntax
call minpac#add('styled-components/vim-styled-components') " I guess we use styled components

" Writing
call minpac#add('junegunn/goyo.vim') " Distraction free writing
call minpac#add('junegunn/limelight.vim') " Focused writing

" quality of life improvements
call minpac#add('zorab47/procfile.vim') " Procfile syntax highlighting


" Plugin commands
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()


"""""""""""
" FZF setup
"
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <C-b> :<C-u>Buffers<CR>
nnoremap <C-g> :<C-u>GFiles?<CR>

let g:fzf_layout = { 'down': '~35%' }

" hide status bar when fuzzy finding
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"""""""""""
" ALE setup
"
let g:ale_sign_column_always = 1
let g:ale_linters = { 'javascript': ['eslint'], 'typescript': ['tslint'], 'ruby': ['standardrb'] }
let g:ale_fixers = { 'javascript': ['prettier'], 'ruby': ['standardrb'] }

" default to fix on save, but add a toggle
let g:ale_fix_on_save = 1
nnoremap <C-f> :let g:ale_fix_on_save = !g:ale_fix_on_save<CR>

"""""""""""
" Grepper setup
"
let g:grepper       = {}
let g:grepper.tools = ['grep', 'git', 'rg']
let g:grepper.simple_prompt = 1
let g:grepper.rg = { 'grepprg': 'rg -H --no-heading --vimgrep --sort-files' }

" Search for the current word
nnoremap <Leader>* :Grepper -tool rg -cword -noprompt<CR>
" backwards compatible from my old setup
nnoremap \| :Grepper -tool rg<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

""""""""
" Test Setup
"
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'dispatch',
  \}
let test#ruby#rspec#options = {
\ 'nearest': '--backtrace',
\ 'file':    '--format progress',
\ 'suite':   '--fail-fast',
\}

nmap <Leader>tt :TestNearest<CR>
nmap <Leader>tl :TestLast<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>T :TestFile<CR>
nmap <Leader>ff :TestFile --fail-fast<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tg :TestVisit<CR> " go to the last test run
set autowrite " save buffers before leaving or running tests

""""""""
" Dispatch Setup
"
let g:dispatch_quickfix_height=14

""""""""
" Airline Setup
"
let g:airline_theme='base16' " also good,'bubblegum', 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0 " disable git hunk count
"let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
"let g:airline#parts#ffenc#skip_expected_string='[unix]'

""""""""
" Git Gutter Setup
"
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0


""""""""
" Writing
"
"autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!


""
"" Regular config
""

" Softtabs, 2 spaces
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

set nu " show linenumbers
set scrolloff=1 " always display a line above/below cursor
set nowrap " dont wrap lines

" dont use backup files
set nobackup
set noswapfile

" setup undo
set undodir=$VIMDATA/undo
autocmd BufWritePre /tmp/* setlocal noundofile " dont track /tmp
if !has('nvim')
  set undodir=~/.vim/undo
endif
augroup vimrc
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
set history=100     " Default history is only 20
set undolevels=100  " Use more levels of undo

" more normal splits
set splitbelow
set splitright

" remap split navigation keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" search Settings
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
" make regexp search better
nnoremap / /\v
vnoremap / /\v
" global replace by default
set gdefault

" mouse is useful sometimes
set mouse=a

" Colors
set termguicolors
set t_Co=256 " Setup term color support
let base16colorspace=256  " Access colors present in 256 colorspace

if $ITERM_PROFILE =~ 'Light'
  colorscheme base16-google-light
else
  colorscheme base16-oceanicnext
endif

highlight LineNr guibg=NONE " no background for number column
" clear background color for gutter
highlight SignColumn guibg=NONE
highlight GitGutterAdd guibg=NONE
highlight GitGutterChange guibg=NONE
highlight GitGutterDelete guibg=NONE
highlight GitGutterChangeDelete guibg=NONE


"" Terminal config
" escape terminal mode with ESC
tnoremap <Esc> <C-\><C-n>
" highlight cursor nicely
highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=lightgreen guifg=white ctermbg=1 ctermfg=15

" edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vsplit <C-R>=expand("%:p:h") . '/'<CR>

" easier save
map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" easier tab navigation
map \[ gT
map \] gt

runtime macros/matchit.vim

" reopen file at the same line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " But don't do that if it's a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
endif

" remove whitespace on save
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown let b:noStripWhitespace=1
