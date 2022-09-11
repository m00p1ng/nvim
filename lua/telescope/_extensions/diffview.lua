local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local utils = require "telescope.utils"
local strings = require "plenary.strings"
local entry_display = require "telescope.pickers.entry_display"
local themes = require("telescope.themes")
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local diffview = function(opts)
  local format = "%(HEAD)"
      .. "%(refname)"
      .. "%(authorname)"
      .. "%(upstream:lstrip=2)"
  local output = utils.get_os_command_output(
    { "git", "for-each-ref", "--perl", "--format", format, opts.pattern },
    opts.cwd
  )

  local results = {}
  local widths = {
    name = 0,
    authorname = 0,
    upstream = 0,
  }
  local unescape_single_quote = function(v)
    return string.gsub(v, "\\([\\'])", "%1")
  end
  local parse_line = function(line)
    local fields = vim.split(string.sub(line, 2, -2), "''", true)
    local entry = {
      head = fields[1],
      refname = unescape_single_quote(fields[2]),
      authorname = unescape_single_quote(fields[3]),
      upstream = unescape_single_quote(fields[4]),
    }
    local prefix
    if vim.startswith(entry.refname, "refs/remotes/") then
      prefix = "refs/remotes/"
    elseif vim.startswith(entry.refname, "refs/heads/") then
      prefix = "refs/heads/"
    else
      return
    end
    local index = 1
    if entry.head ~= "*" then
      index = #results + 1
    end

    entry.name = string.sub(entry.refname, string.len(prefix) + 1)
    for key, value in pairs(widths) do
      widths[key] = math.max(value, strings.strdisplaywidth(entry[key] or ""))
    end
    if string.len(entry.upstream) > 0 then
      widths.upstream_indicator = 2
    end
    table.insert(results, index, entry)
  end
  for _, line in ipairs(output) do
    parse_line(line)
  end
  if #results == 0 then
    return
  end

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 1 },
      { width = widths.name },
      { width = widths.authorname },
      { width = widths.upstream_indicator },
      { width = widths.upstream },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.head },
      { entry.name, "TelescopeResultsIdentifier" },
      { entry.authorname },
      { string.len(entry.upstream) > 0 and "=>" or "" },
      { entry.upstream, "TelescopeResultsIdentifier" },
    }
  end

  local picker_opts = themes.get_dropdown({
    previewer = false,
  })

  pickers.new(picker_opts, {
    prompt_title = "Compare HEAD - Diffview",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        entry.value = entry.name
        entry.ordinal = entry.name
        entry.display = make_display
        return entry
      end,
    },
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_command(':DiffviewOpen '.. selection.value)
        vim.notify('Diff `' .. selection.value .. '` with HEAD', vim.log.levels.INFO)
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension({
  exports = {
    diffview = diffview,
  },
})
