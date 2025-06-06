return {
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "dart" } },
  },

  -- Other extensions
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    init = function()
      require("which-key").add {
        { "<leader>m", group = "flutter" },
        { "<leader>mt", "<cmd>telescope flutter commands<cr>", desc = "menu", buffer = true },
        { "<leader>mf", "<cmd>telescope flutter fvm<cr>", desc = "fvm", buffer = true },
      }
    end,
    opts = {
      ui = {
        -- the border type to use for all floating windows, the same options/formats
        -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
        border = "rounded",
        -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
        -- please note that this option is eventually going to be deprecated and users will need to
        -- depend on plugins like `nvim-notify` instead.
        notification_style = "plugin",
      },
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = false,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = false,
          -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
          -- this will show the currently selected project configuration
          project_config = false,
        },
      },
      debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = false,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |:help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {},
        -- register_configurations = function(paths)
        --   require("dap").configurations.dart = {
        --     <put here config that you would find in .vscode/launch.json>
        --   }
        -- end,
      },
      -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
      flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
      fvm = true, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "NonText", -- highlight for the closing tag
        prefix = "> ", -- character to use for close tag e.g. > Widget
        enabled = true, -- set to false to disable
      },
      dev_log = {
        enabled = true,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "10sp", -- command to use to open the log buffer
      },
      dev_tools = {
        autostart = false, -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
      },
      outline = {
        open_cmd = "30vnew", -- command to use to open the outline buffer
        auto_open = false, -- if true this will open the outline automatically when it is first populated
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = true, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 20, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = false, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        on_attach = require("plugins.lsp.keymaps").on_attach,
        capabilities = require("plugins.lsp.keymaps").capabilities, -- e.g. lsp_status capabilities
        -- see the link below for details on each option:
        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          -- analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
          renameFilesWithClasses = "prompt", -- "always"
          enableSnippets = true,
          updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        },
      },
    },
  },
}
