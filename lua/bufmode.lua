--- The keymaps for this mode
local MODE_KEYMAPS =
{
	--- barbar.nvim integration
	BARBAR =
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
	},

	--- bufferline.nvim integration
	BUFFERLINE =
	{
		['B'] = 'BufferLineMovePrev',
		['b'] = 'BufferLineCyclePrev',
		['p'] = 'BufferLinePick',
		['W'] = 'BufferLineMoveNext',
		['w'] = 'BufferLineCycleNext',
	},

	--- the default mode mappings
	DEFAULT =
	{
		['$'] = 'blast',
		['0'] = 'bfirst',
		['?'] = 'help bufmode-usage',
		['b'] = 'bprevious',
		['d'] = 'silent! bdelete',
		['w'] = 'bnext',
	},
}

--- @type boolean|nil
--- whether the previous `setup` call was done automatically by the `plugin` folder
local prev_setup_auto

--[[/* MODULE */]]

--- @class bufmode.options
--- @field auto boolean whether the `setup` call was performed by the `plugin/bufmode.lua` file
--- @field barbar boolean Whether to add bindings for barbar.nvim
--- @field bufferline boolean Whether to add bindings for bufferline.nvim
--- @field enter_mapping false|string custom binding to enter buffers mode
--- @field keymaps? {[string]: fun()|string} custom key bindings to apply
local DEFAULT_OPTS =
{
	auto = false,
	barbar = false,
	bufferline = false,
	enter_mapping = '<Leader>b',
	keymaps = nil,
}

--- @class bufmode
local bufmode = {}

--- @param opts? bufmode.options
function bufmode.setup(opts)
	--- @type bufmode.options
	opts = opts and vim.tbl_extend('keep', opts, DEFAULT_OPTS) or vim.deepcopy(DEFAULT_OPTS)

	-- if a setup was run manually once before, don't let plugin override the user's settings
	if opts.auto and prev_setup_auto == false then
		return
	end

	-- add user mappings
	local keymaps = vim.deepcopy(MODE_KEYMAPS.DEFAULT)

	if opts.barbar then -- Add mappings for `barbar.nvim`
		keymaps = vim.tbl_extend('force', keymaps, MODE_KEYMAPS.BARBAR)
	elseif opts.bufferline then -- Add mappings for `bufferline.nvim`
		keymaps = vim.tbl_extend('force', keymaps, MODE_KEYMAPS.BUFFERLINE)
	end

	--- create a link to some existing mapping
	--- @param parent string
	--- @param children string[]
	local function inherit(parent, children)
		for _, child in ipairs(children) do
			keymaps[child] = keymaps[parent]
		end
	end

	--- Turn some special character value into a character code.
	--- @param val string
	--- @return string termcodes_replaced
	local function tochar(val)
		return vim.api.nvim_replace_termcodes(val, true, true, true)
	end

	inherit('0', {'^', tochar '<Home>', tochar '<Up>'})
	inherit('$', {tochar '<End>', tochar '<Down>'})
	inherit('b', {'j', 'h', tochar '<Left>', tochar '<PageUp>'})
	inherit('B', {'J', 'H', tochar '<S-Left>', tochar '<S-PageUp>'})
	inherit('w', {'k', 'l', tochar '<Right>', tochar '<PageDown>'})
	inherit('W', {'K', 'L', tochar '<S-Right>', tochar '<S-PageDown>'})

	if vim.g.bufmode_mappings then
		keymaps = vim.tbl_extend('force', keymaps, vim.g.bufmode_mappings)
	elseif opts.keymaps then
		keymaps = vim.tbl_extend('force', keymaps, opts.keymaps)
	end

	local libmodal = require 'libmodal'
	local function mode()
		libmodal.mode.enter('BUFFERS', keymaps)
	end

	--- The description used for mappings
	local DESC = 'Enter buffer mode'

	if prev_setup_auto then
		vim.keymap.del('n', DEFAULT_OPTS.enter_mapping)
	end

	if opts.enter_mapping ~= false then
		vim.keymap.set('n', opts.enter_mapping, mode, {desc = DESC})
	end

	vim.keymap.set('n', '<Plug>(BufmodeEnter)', mode, {desc = DESC})
	vim.api.nvim_create_user_command('BufmodeEnter', mode, {desc = DESC})

	prev_setup_auto = opts.auto
end

--[[/* PUBLICIZE MODULE */]]

return bufmode
