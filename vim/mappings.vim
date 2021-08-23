"""""""""""""""""""""""""""""""
"键盘映射
"""""""""""""""""""""""""""""""
nnoremap <leader>wq :wq<cr>
nnoremap <leader>w :w<cr> 
nnoremap <leader>q :wq<cr> 
nnoremap <c-n> :nohls<cr>
" markdown-preview "
nnoremap <leader>mp :markdownpreview<cr>
nnoremap <leader>mps :markdownpreviewstop<cr>
nnoremap <leader>mpt :markdownpreviewtoggle<cr>
nnoremap <leader>ev :split $myvimrc<cr>
nnoremap <leader>sv :source $myvimrc<cr>
nnoremap <silent><leader>vp :vsplit<cr>
nnoremap <silent><leader>sp :split<cr>
nnoremap <silent>w+ :vertical resize +10<cr>
nnoremap <silent>w- :vertical resize -10<cr>
nnoremap <silent>w; :resize +5<cr>
nnoremap <silent>w, :resize -5<cr>

inoremap <c-u> <esc>guiw
inoremap jk <esc>

vnoremap <c-u> gu

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction





