local bufmode = require 'bufmode'

vim.keymap.set('n', '<Plug>(BufmodeEnter)', bufmode, {silent = true, unique = true})
vim.keymap.set('n', '<leader>b', '<Plug>(BufmodeEnter)', {remap = true, silent = true, unique = true})

vim.api.nvim_create_user_command('BufmodeEnter', bufmode, {force = false})
