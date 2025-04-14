return {
  "johmsalas/text-case.nvim",
  opts = {
    -- Set `default_keymappings_enabled` to false if you don't want automatic keymappings to be registered.
    default_keymappings_enabled = true,
    -- `prefix` is only considered if `default_keymappings_enabled` is true. It configures the prefix
    -- of the keymappings, e.g. `gau ` executes the `current_word` method with `to_upper_case`
    -- and `gaou` executes the `operator` method with `to_upper_case`.
    prefix = "s",
    -- If `substitude_command_name` is not nil, an additional command with the passed in name
    -- will be created that does the same thing as "Subs" does.
    substitude_command_name = nil,
    -- By default, all methods are enabled. If you set this option with some methods omitted,
    -- these methods will not be registered in the default keymappings. The methods will still
    -- be accessible when calling the exact lua function e.g.:
    -- "<CMD>lua require('textcase').current_word('to_snake_case')<CR>"
    enabled_methods = {
      "to_upper_case",
      "to_lower_case",
      "to_snake_case",
      "to_dash_case",
      "to_title_dash_case",
      "to_constant_case",
      "to_dot_case",
      "to_comma_case",
      "to_phrase_case",
      "to_camel_case",
      "to_pascal_case",
      "to_title_case",
      "to_path_case",
      "to_upper_phrase_case",
      "to_lower_phrase_case",
    },
  },
  keys = {
    "s", -- Default invocation prefix
    -- ref: https://github.com/johmsalas/text-case.nvim/issues/183#issuecomment-2680755032
    {
      "s.",
      function()
        local plugin = require "textcase.plugin.plugin"
        local presets = require "textcase.plugin.presets"
        local constants = require "textcase.shared.constants"
        local api = require("textcase").api
        local function get_conversion_methods()
          local methods = {}

          for _, method in pairs {
            api.to_upper_case,
            api.to_lower_case,
            api.to_snake_case,
            api.to_dash_case,
            api.to_title_dash_case,
            api.to_constant_case,
            api.to_dot_case,
            api.to_comma_case,
            api.to_phrase_case,
            api.to_camel_case,
            api.to_pascal_case,
            api.to_title_case,
            api.to_path_case,
          } do
            if presets.options.enabled_methods_set[method.method_name] then
              table.insert(methods, {
                label = method.desc,
                method_name = method.method_name,
              })
            end
          end

          return methods
        end

        local function normal_mode_change()
          -- Create both quick conversion and LSP options
          local quick_methods = get_conversion_methods()
          local lsp_methods = get_conversion_methods()

          local options = {}

          -- Add quick conversion options
          for _, method in ipairs(quick_methods) do
            table.insert(options, {
              label = "Convert to " .. method.label,
              method_name = method.method_name,
              type = constants.change_type.CURRENT_WORD,
            })
          end

          -- Add LSP rename options
          for _, method in ipairs(lsp_methods) do
            table.insert(options, {
              label = "LSP rename " .. method.label,
              method_name = method.method_name,
              type = constants.change_type.LSP_RENAME,
            })
          end

          vim.ui.select(options, {
            prompt = "Text Case:",
            format_item = function(item)
              return item.label
            end,
          }, function(choice)
            if not choice then
              return
            end

            if choice.type == constants.change_type.CURRENT_WORD then
              plugin.current_word(choice.method_name)
            elseif choice.type == constants.change_type.LSP_RENAME then
              plugin.lsp_rename(choice.method_name)
            end
          end)
        end
        local function visual_mode_change()
          local methods = get_conversion_methods()

          vim.ui.select(methods, {
            prompt = "Convert selection to:",
            format_item = function(item)
              return item.label
            end,
          }, function(choice)
            if not choice then
              return
            end
            vim.cmd "normal! gv"
            plugin.visual(choice.method_name)
          end)
        end
        local mode = vim.api.nvim_get_mode().mode
        if mode == "v" or mode == "V" then
          visual_mode_change()
        elseif mode == "n" then
          normal_mode_change()
        end
      end,
      mode = { "n", "x" },
    },
  },
}
