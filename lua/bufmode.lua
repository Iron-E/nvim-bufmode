--[[/* IMPORTS */]]

local libmodal = require 'libmodal'

--[[/* MODULE */]]

-- the key combos for this mode.
local keymaps =
{
	['$'] = 'blast',
	['0'] = 'bfirst',
	['?'] = 'help bufmode-usage',
	['b'] = 'bprevious',
	['d'] = 'silent! bdelete',
	['w'] = 'bnext',
}

-- Add mappings for `barbar.nvim`
if vim.fn.exists ':BufferClose' > 0 then
	keymaps = vim.tbl_extend('force', keymaps,
	{
		['$'] = 'BufferLast',
		['0'] = 'BufferFirst',
		['B'] = 'BufferMovePrevious',
		['d'] = 'BufferDelete',
		['p'] = 'BufferPick',
		['r'] = 'BufferClose',
		['w'] = 'BufferNext',
		['W'] = 'BufferMoveNext',
	})
end

-- add user mappings
keymaps = vim.tbl_extend('force', keymaps, vim.g.bufmode_mappings or {})

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

--[[/* PUBLICIZE MODULE */]]

return function() libmodal.mode.enter('BUFFERS', keymaps) end
