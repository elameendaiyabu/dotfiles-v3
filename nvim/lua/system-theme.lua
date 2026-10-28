-- Follow the desktop theme chosen with theme-switch, live.
-- ~/.config/themes/current/nvim.lua is rewritten on every switch; we watch it.
local M = {}

local dir = vim.fn.expand("~/.config/themes/current")
local file = dir .. "/nvim.lua"

function M.apply()
	local ok, spec = pcall(dofile, file)
	if not ok or type(spec) ~= "table" then
		return
	end
	vim.o.background = spec.background
	local applied = spec.scheme ~= "base16" and pcall(vim.cmd.colorscheme, spec.scheme)
	if not applied then
		vim.cmd("highlight clear")
		require("mini.base16").setup({ palette = spec.palette, use_cterm = true })
		vim.g.colors_name = "system-" .. spec.name
		-- mini.base16 doesn't go through :colorscheme, so fire the event for
		-- lualine and the transparency autocmd
		vim.api.nvim_exec_autocmds("ColorScheme", { pattern = vim.g.colors_name })
	end
end

function M.setup()
	M.apply()
	local watcher = vim.uv.new_fs_event()
	local timer = vim.uv.new_timer()
	if not watcher or not timer then
		return
	end
	watcher:start(dir, {}, function(_, fname)
		if fname ~= "nvim.lua" then
			return
		end
		-- debounce: the file is replaced atomically, but events can arrive in bursts
		timer:start(80, 0, vim.schedule_wrap(M.apply))
	end)
end

return M
