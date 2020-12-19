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

-- Wrap some vim command in a function.
local function _exe_wrap(command)
	return function() exe(command) end
end

-- the key combos for this mode.
local _combos = {
	['$'] = _exe_wrap 'blast',
	['0'] = _exe_wrap 'bfirst',
	['?'] = _exe_wrap 'help bufmode-usage',
	['b'] = _exe_wrap 'bprevious',
	['d'] = _exe_wrap 'silent! bdelete',
	['w'] = _exe_wrap 'bnext',
}

if vim.fn.exists ':BufferClose' > 0 then _combos =
	vim.tbl_extend('force', _combos, {
		['?'] = _exe_wrap 'help bufmode-usage',
		['B'] = _exe_wrap 'BufferMovePrevious',
		['d'] = _exe_wrap 'BufferDelete',
		['f'] = function()
			local buffer = vim.fn.input('Go to buffer: ', '', 'buffer')
			exe('BufferGoto '..vim.fn.bufnr(buffer))
		end,
		['p'] = _exe_wrap 'BufferPick',
		['r'] = _exe_wrap 'BufferClose',
		['W'] = _exe_wrap 'BufferMoveNext',
	})
end

-- create a `new` link for some `existing` mapping
local function _inherit(child, parent)
	_combos[child] = _combos[parent]
end

-- Turn some special character value into a character code.
local function _to_char(val)
	return eval('"\\'..val..'"')
end

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
