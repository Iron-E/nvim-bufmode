--[[
	/*
	 * IMPORTS
	 */
--]]

local vim  = vim
local eval = vim.api.nvim_eval
local exe  = vim.api.nvim_command
local libmodal = require 'libmodal'

--[[
	/*
	 * MODULE
	 */
--]]

-- the key combos for this mode.
local _combos =
{
	['$'] = 'blast',
	['0'] = 'bfirst',
	['?'] = 'help bufmode-usage',
	['b'] = 'bprevious',
	['d'] = 'silent! bdelete',
	['w'] = 'bnext',
}

-- Add mappings for `barbar.nvim`
if vim.fn.exists ':BufferClose' > 0 then _combos =
	vim.tbl_extend('force', _combos,
	{
		['$'] = 'BufferLast',
		['0'] = 'BufferFirst',
		['B'] = 'BufferMovePrevious',
		['d'] = 'BufferDelete',
		['f'] = function()
			local buffer = vim.fn.input('Go to buffer: ', '', 'buffer')
			exe('BufferGoto '..vim.fn.bufnr(buffer))
		end,
		['p'] = 'BufferPick',
		['r'] = 'BufferClose',
		['w'] = 'BufferNext',
		['W'] = 'BufferMoveNext',
	})
end

-- add user mappings
vim.tbl_extend('force', _combos, vim.g.bufmode_mappings or {})

-- create a `new` link for some `existing` mapping
local function _inherit(child, parent) _combos[child] = _combos[parent] end

-- Turn some special character value into a character code.
local function _to_char(val) return eval('"\\'..val..'"') end

-- Synonyms for '0'
_inherit('^', '0')
_inherit(_to_char '<Home>', '0')
_inherit(_to_char '<Up>',   '0')

-- Synonyms for '$'
_inherit(_to_char '<End>',  '$')
_inherit(_to_char '<Down>', '$')

-- Synonyms for 'b'
_inherit('j', 'b')
_inherit('h', 'b')
_inherit(_to_char '<Left>',   'b')
_inherit(_to_char '<PageUp>', 'b')

-- Synonyms for 'B'
_inherit('J', 'B')
_inherit('H', 'B')
_inherit(_to_char '<S-Left>',   'B')
_inherit(_to_char '<S-PageUp>', 'B')

-- Synonyms for 'f'
_inherit('g', 'f')
_inherit('t', 'f')

-- Synonyms for 'w'
_inherit('k', 'w')
_inherit('l', 'w')
_inherit(_to_char '<Right>',    'w')
_inherit(_to_char '<PageDown>', 'w')

-- Synonyms for 'W'
_inherit('K', 'W')
_inherit('L', 'W')
_inherit(_to_char '<S-Right>',    'W')
_inherit(_to_char '<S-PageDown>', 'W')

--[[
	/*
	 * PUBLICIZE MODULE
	 */
--]]

return function() libmodal.mode.enter('BUFFERS', _combos) end
