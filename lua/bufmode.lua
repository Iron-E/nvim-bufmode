--[[/* MODULE */]]

local M = {}

-- the key combos for this mode.
local default_keymaps =
{
	['$'] = 'blast',
	['0'] = 'bfirst',
	['?'] = 'help bufmode-usage',
	['b'] = 'bprevious',
	['d'] = 'silent! bdelete',
	['w'] = 'bnext',
}

local barbar_keymaps =
{
  ['$'] = 'BufferLast',
  ['0'] = 'BufferFirst',
  ['B'] = 'BufferMovePrevious',
  ['b'] = 'BufferPrevious',
  ['d'] = 'BufferDelete',
  ['p'] = 'BufferPick',
  ['r'] = 'BufferClose',
  ['W'] = 'BufferMoveNext',
  ['w'] = 'BufferNext',
}

local bufferline_keymaps =
{
  ['B'] = 'BufferLineMovePrev',
  ['b'] = 'BufferLineCyclePrev',
  ['p'] = 'BufferLinePick',
  ['W'] = 'BufferLineMoveNext',
  ['w'] = 'BufferLineCycleNext',
}

---@class BufmodeOptions
---@field barbar? boolean Whether to add bindings for barbar.nvim
---@field bufferline? boolean Whether to add bindings for bufferline.nvim
---@field keymaps? table custom key bindings to apply
---@field enter_mapping? string custom binding to enter buffers mode

---@param opts? BufmodeOptions
function M.setup(opts)
  opts = opts or {}
  local libmodal = require 'libmodal'

  -- add user mappings
  local keymaps = vim.tbl_extend('force', default_keymaps, vim.g.bufmode_mappings or {})

  -- Add mappings for `barbar.nvim`
  if opts.barbar then
    keymaps = vim.tbl_extend('force', keymaps, barbar_keymaps)
  -- Add mappings for `bufferline.nvim`
  elseif opts.bufferline then
    keymaps = vim.tbl_extend('force', keymaps, bufferline_keymaps)
  end

  keymaps = vim.tbl_extend('force', keymaps, opts.keymaps or {})

  -- create a `new` link for some `existing` mapping
  local function inherit(child, parent)
    keymaps[child] = keymaps[parent]
  end

  -- Turn some special character value into a character code.
  local function tochar(val)
    return vim.api.nvim_replace_termcodes(val, true, true, true)
  end

  -- Synonyms for '0'
  inherit('^', '0')
  inherit(tochar '<Home>', '0')
  inherit(tochar '<Up>',   '0')

  -- Synonyms for '$'
  inherit(tochar '<End>',  '$')
  inherit(tochar '<Down>', '$')

  -- Synonyms for 'b'
  inherit('j', 'b')
  inherit('h', 'b')
  inherit(tochar '<Left>',   'b')
  inherit(tochar '<PageUp>', 'b')

  -- Synonyms for 'B'
  inherit('J', 'B')
  inherit('H', 'B')
  inherit(tochar '<S-Left>',   'B')
  inherit(tochar '<S-PageUp>', 'B')

  -- Synonyms for 'w'
  inherit('k', 'w')
  inherit('l', 'w')
  inherit(tochar '<Right>',    'w')
  inherit(tochar '<PageDown>', 'w')

  -- Synonyms for 'W'
  inherit('K', 'W')
  inherit('L', 'W')
  inherit(tochar '<S-Right>',    'W')
  inherit(tochar '<S-PageDown>', 'W')

  local function bufmode()
    libmodal.mode.enter('BUFFERS', keymaps)
  end

  if vim.fn.hasmapto '<Plug>(BufmodeEnter)' == '1' then
    vim.keymap.del('n', '<Plug>(BufmodeEnter)')
  end
  vim.keymap.set('n', '<Plug>(BufmodeEnter)', bufmode, {silent = true, unique = true, desc = 'Enter buffers mode'})

  if (opts.enter_mapping ~= false) then
    vim.keymap.set('n', opts.enter_mapping or '<leader>b', bufmode, {remap = true, silent = true, unique = true, desc = 'Enter buffers mode'})
  end

  vim.api.nvim_create_user_command('BufmodeEnter', bufmode, {force = false, desc = "Enter buffers mode"})
end

--[[/* PUBLICIZE MODULE */]]

return M
