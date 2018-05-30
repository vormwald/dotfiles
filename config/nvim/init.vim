" Manage plugins with minpac
packadd minpac
call minpac#init()

call minpac#add('tpope/vim-unimpaired')
call minpac#add('k-takata/minpac', {'type': 'opt'})

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Leader
let mapleader = " "

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vsplit <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>t :tabe <C-R>=expand("%:p:h") . '/'<CR>

" easier save
map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" remap split navigation keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" more normal splits
set splitbelow
set splitright

" easier tab navigation
map <leader>[ gT
map <leader>] gt
