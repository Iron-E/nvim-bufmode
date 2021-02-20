if exists('g:loaded_bufmode')
	finish
endif
let g:loaded_bufmode = 1

nnoremap <unique> <silent> <Plug>(BufmodeEnter) <Cmd>lua require('bufmode')()<CR>
nmap <unique> <silent> <leader>b <Plug>(BufmodeEnter)

if !exists(':BufmodeEnter')
	command! BufmodeEnter lua require('bufmode')()
endif
