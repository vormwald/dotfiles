""
"" Plugin config
""

packadd minpac " Manage plugins with minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Plugins
call minpac#add('airblade/vim-gitgutter') " display git changes
call minpac#add('chriskempson/base16-vim') " colorschemes
call minpac#add('janko-m/vim-test') " knows lots of test configs
call minpac#add('junegunn/fzf') " fuzzy finding basics
call minpac#add('junegunn/fzf.vim') " fuzzy finding ++
call minpac#add('mhinz/vim-grepper') " search files
call minpac#add('milkypostman/vim-togglelist') " toggle quickfix/loc list
call minpac#add('radenling/vim-dispatch-neovim') "neovim terminal for dispatch commands
call minpac#add('tpope/vim-dispatch') " async compiler actions
call minpac#add('tpope/vim-endwise') " add ends to do/if in ruby
call minpac#add('tpope/vim-fugitive') " git actions
call minpac#add('tpope/vim-rails') " projectionist setting for rails
call minpac#add('tpope/vim-rhubarb') " :Gbrowse to view file on github
call minpac#add('tpope/vim-unimpaired') " bracket mappings for common actions
call minpac#add('vim-airline/vim-airline') "pretty statusbar
call minpac#add('vim-airline/vim-airline-themes') "pretty statusbar themes
call minpac#add('w0rp/ale') " async Linting Engine
"goyo.vim
"rename.vim

" Plugin commands
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()


"""""""""""
" FZF setup
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

" pack update / clean commands
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"""""""""""
" Grepper setup

let g:grepper       = {}
let g:grepper.tools = ['grep', 'git', 'rg']
let g:grepper.simple_prompt = 1
"runtime plugin/grepper.vim
let g:grepper.rg = { 'grepprg': 'rg -H --no-heading --vimgrep --sort-files' }
"let g:grepper.quickfix      = 0

" Search for the current word
nnoremap <Leader>* :Grepper -tool rg -cword -noprompt<CR>
" backwards compatible from my old setup
nnoremap \| :Grepper -tool rg<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)


""""""""
" Airline Setup
"
let g:airline_theme='base16_eighties' " also good,'bubblegum', 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#parts#ffenc#skip_expected_string='[unix]'

""""""""
" Git Gutter Setup
let g:gitgutter_map_keys = 0



""
"" Regular config
""

" Leader is spacebar
let mapleader = " "

" Softtabs, 2 spaces
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

" more normal splits
set splitbelow
set splitright

" remap split navigation keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Colors
set termguicolors
set t_Co=256 " Setup term color support
let base16colorspace=256  " Access colors present in 256 colorspace

if $ITERM_PROFILE =~ 'Light'
  colorscheme base16-google-light
else
  colorscheme base16-eighties
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
map <Leader>t :tabe <C-R>=expand("%:p:h") . '/'<CR>

" easier save
map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" easier tab navigation
map \[ gT
map \] gt

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
