 " Last Change:  2023 March 21
 " Author:       Abdulkerim Akan

if exists('g:loaded_comment') | finish | endif " prevent loading file twice
 
let s:save_cpo = &cpo
set cpo&vim
 
command! CommentBlock lua require'comment'.comment_block()
command! CommentLine lua require'comment'.comment_line()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_comment = 1
nnoremap <space>hl :CommentLine<CR>
vnoremap <space>hk :<C-U>CommentBlock<CR>
nnoremap <space>hk :CommentBlock<CR>
