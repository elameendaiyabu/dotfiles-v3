-- Disable built-in LSP progress notifications
vim.lsp.handlers["$/progress"] = function() end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.shortmess:append("I")
vim.opt.guicursor = ""
vim.opt.textwidth = 80
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.mouse = ""
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.signcolumn = "no"
vim.opt.shortmess:append("c")
vim.opt.cmdheight = 0

-- loading lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("keymaps")

-- loading plugins
require("lazy").setup({
	require("plugins/gitsigns"),
	require("plugins/telescope"),
	require("plugins/colorscheme"),
	require("plugins/tmux-navigator"),

	require("plugins/lspkind"),
	require("plugins/cmp"),
	require("plugins/lspconfig"),
	require("plugins/treesitter"),
	require("plugins/autopairs"),
	require("plugins/autotag"),
	require("plugins/mini"),
	require("plugins/lualine"),
	require("plugins/conform"),
	require("plugins/noice"),

	require("plugins/extras"),
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- editing lsp popup menu
local cmp = require("cmp")
cmp.setup({
	formatting = {
		expandable_indicator = true,
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				show_labelDetails = true,
			})(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		}),
	},
	view = {
		entries = {
			name = "custom",
			selection_order = "near_cursor",
			follow_cursor = true,
		},
	},
	preselect = cmp.PreselectMode.None,
})

vim.cmd([[
augroup TransparentBackground
autocmd!
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
augroup END
]])

require("system-theme").setup()

vim.lsp.enable("biome")

vim.notify = require("noice").notify
