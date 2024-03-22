set clipboard+=unnamedplus
set tabstop=2 shiftwidth=2

set expandtab list noru
set spelllang=en,it shada="NONE"

set number relativenumber
set splitbelow splitright

autocmd BufWritePre * | %s/\s\+$//e

nnoremap <C-g> :Goyo<CR>
nnoremap <C-n> :n<CR>
nnoremap <C-p> :N<CR>

nnoremap <F10> :UndotreeToggle<CR>
nnoremap <F11> :nohlsearch<CR>
nnoremap <F12> :set spell!<CR>
