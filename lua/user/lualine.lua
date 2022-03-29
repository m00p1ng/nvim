local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_gps_ok, gps = pcall(require, "nvim-gps")
if not status_gps_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 120
end

local icons = require "user.icons"

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
	cond = hide_in_width,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
	cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return str:sub(1,1)
	end,
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
	cond = hide_in_width,
}

local filename = {
	"filename",
	file_status = true,
	path = 1,
	shorting_target = 40,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
	cond = hide_in_width,
}

local encoding = {
	"encoding",
	cond = hide_in_width,
}

-- cool function for progress
local progress = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		return chars[index]
	end,
	cond = hide_in_width,
}

local spaces = {
	function()
		return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end,
	cond = hide_in_width,
}

local nvim_gps = {
	function()
		local gps_location = gps.get_location()
		if gps_location == "error" then
			return ""
		else
			return gps.get_location()
		end
	end,
	cond = hide_in_width
}

lualine.setup {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "DiffviewFiles" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { mode, filename },
		lualine_c = { nvim_gps },
		lualine_x = { diff, spaces, encoding, filetype },
		lualine_y = { "location" },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}