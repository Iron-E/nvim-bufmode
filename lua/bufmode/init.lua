--[[
	/*
	 * IMPORTS
	 */
--]]

local cmd  = vim.api.nvim_command
local eval = vim.api.nvim_eval

--[[
	/*
	 * MODULE
	 */
--]]

-- Wrap some vim command in a function.
local function _exe(command)
	return function() cmd(command) end
end

-- the key combos for this mode.
local _combos = {
	['$'] = _exe('blast'),
	['0'] = _exe('bfirst'),
	['?'] = _exe('help bufmode-usage'),
	['b'] = _exe('bprevious'),
	['d'] = _exe('silent! bdelete'),
	['w'] = _exe('bnext'),
}

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
_inherit(_to_char('<Home>') , '0')
_inherit(_to_char('<Up>')   , '0')

-- Synonyms for '$'
_inherit(_to_char('<End>'), '$')
_inherit(_to_char('<Down>'), '$')

-- Synonyms for 'b'
_inherit('j', 'b')
_inherit('h', 'b')
_inherit(_to_char('<Left>'), 'b')
_inherit(_to_char('<PageUp>'), 'b')

-- Synonyms for 'w'
_inherit('k', 'w')
_inherit('l', 'w')
_inherit(_to_char('<Right>'), 'w')
_inherit(_to_char('<PageDown>'), 'w')

--[[
	/*
	 * PUBLICIZE MODULE
	 */
--]]

return function()
	require('libmodal').mode.enter('BUFFERS', _combos)
end
