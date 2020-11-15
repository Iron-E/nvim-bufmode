if exists('g:loaded_bufmode')
	finish
endif
let g:loaded_bufmode = 1

nnoremap <silent> <unique> <Plug>(BufmodeEnter) <Cmd>lua require('bufmode')()<CR>
nmap <silent> <unique> <leader>b <Plug>(BufmodeEnter)
nmap <silent> <unique> <leader>B <Cmd>BufferPick<CR>

if !exists(':BufmodeEnter')
	command! BufmodeEnter lua require('bufmode')()
endif
