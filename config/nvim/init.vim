set clipboard+=unnamedplus
set tabstop=2 shiftwidth=2

set list spelllang=en,it shada="NONE"

set number relativenumber
set splitbelow splitright

autocmd BufWritePre * | %s/\s\+$//e

nnoremap <C-g> :Goyo<CR>
nnoremap <C-n> :n<CR>
nnoremap <C-p> :N<CR>
nnoremap <F10> :nohlsearch<CR>
nnoremap <F11> :set spell!<CR>

let g:mapleader = " "
let g:vimwiki_list =
			\ [{
			\ 'syntax': 'markdown',
			\ 'path': '~/schedule',
			\ 'index': 'README',
			\ 'ext': '.md',
			\ 'auto_diary_index': 1
			\ }]
