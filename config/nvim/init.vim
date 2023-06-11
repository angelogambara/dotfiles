set list foldmethod=marker spelllang=en
set tabstop=4 shiftwidth=4 shada="NONE"

set number relativenumber
set splitbelow splitright

let mapleader = " "
let g:vimwiki_list = [{
			\ 'path': '~/notebook', 'index': 'README', 'ext': '.md',
			\ 'syntax': 'markdown', 'auto_diary_index': 1 }]

nnoremap <C-g> :Goyo<CR>
nnoremap <C-n> :n<CR>
nnoremap <C-p> :N<CR>
nnoremap <F10> :nohlsearch<CR>
nnoremap <F11> :set spell!<CR>

autocmd BufWritePre * | %s/\s\+$//e
