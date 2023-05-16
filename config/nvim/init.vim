set clipboard+=unnamedplus
set tabstop=4 shiftwidth=4
set foldmethod=marker
set list shada="NONE"
set number relativenumber
set splitbelow splitright

let mapleader = " "
let g:vimwiki_list = [{'path': '~/markdown/', 'auto_diary_index': 1,
                      \ 'syntax': 'markdown', 'ext': '.md'}]

nnoremap <silent> <F10> :nohlsearch<cr>
nnoremap <silent> <F11> :set spell!<cr>
nnoremap <silent> <F12> :Goyo<cr>
nnoremap <silent> <C-w> :w<cr>
nnoremap <silent> <C-q> :q<cr>
nnoremap <silent> <C-n> :n<cr>
nnoremap <silent> <C-p> :N<cr>

autocmd BufWritePre * | %s/\s\+$//e
