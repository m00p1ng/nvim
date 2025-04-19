return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "http" } },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       kulala_ls = {
  --         mason = false,
  --       },
  --     },
  --   },
  -- },

  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    init = function()
      require("utils").add_ui_ft {
        "json.kulala_ui",
        "text.kulala_ui",
        "markdown.kulala_ui",
        "kulala_verbose_result.kulala_ui",
      }
      require("utils.winbar").add_plugin {
        "json.kulala_ui",
        "text.kulala_ui",
        "markdown.kulala_ui",
        "kulala_verbose_result.kulala_ui",
      }
    end,
    opts = {
      -- cURL path
      -- if you have curl installed in a non-standard path,
      -- you can specify it here
      curl_path = "curl",
      -- additional cURL options
      -- see: https://curl.se/docs/manpage.html
      additional_curl_options = {},
      -- gRPCurl path, get from https://github.com/fullstorydev/grpcurl.git
      grpcurl_path = "grpcurl",
      -- websocat path, get from https://github.com/vi/websocat.git
      websocat_path = "websocat",
      -- openssl path
      openssl_path = "openssl",

      -- set scope for environment and request variables
      -- possible values: b = buffer, g = global
      environment_scope = "b",
      -- dev, test, prod, can be anything
      -- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
      default_env = "dev",
      -- enable reading vscode rest client environment variables
      vscode_rest_client_environmentvars = false,

      -- default timeout for the request, set to nil to disable
      request_timeout = nil,
      -- continue running requests when a request failure is encountered
      halt_on_error = true,

      -- certificates
      certificates = {},
      -- Specify how to escape query parameters
      -- possible values: always, skipencoded = keep %xx as is
      urlencode = "always",

      -- default formatters/pathresolver for different content types
      contenttypes = {
        ["application/json"] = {
          ft = "json",
          formatter = vim.fn.executable "jq" == 1 and { "jq", "." },
          pathresolver = function(...)
            return require("kulala.parser.jsonpath").parse(...)
          end,
        },
        ["application/xml"] = {
          ft = "xml",
          formatter = vim.fn.executable "xmllint" == 1 and { "xmllint", "--format", "-" },
          pathresolver = vim.fn.executable "xmllint" == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
        },
        ["text/html"] = {
          ft = "html",
          formatter = vim.fn.executable "xmllint" == 1 and { "xmllint", "--format", "--html", "-" },
          pathresolver = nil,
        },
      },

      ui = {
        -- display mode: possible values: "split", "float"
        display_mode = "split",
        -- split direction: possible values: "vertical", "horizontal"
        split_direction = "horizontal",
        -- window options to override defaults: width/height/split/vertical
        win_opts = {},
        -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
        default_view = "body",
        -- enable winbar
        winbar = true,
        -- Specify the panes to be displayed by default
        -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats", "verbose", "report", "help" },
        default_winbar_panes = { "body", "headers", "headers_body", "verbose", "script_output", "report", "help" },
        -- enable/disable variable info text
        -- this will show the variable name and value as float
        -- possible values: false, "float"
        show_variable_info_text = false,
        -- icons position: "signcolumn"|"on_request"|"above_request"|"below_request" or nil to disable
        show_icons = "on_request",
        -- default icons
        icons = {
          inlay = {
            loading = "⏳",
            done = "✅",
            error = "❌",
          },
          lualine = "🐼",
          textHighlight = "WarningMsg", -- highlight group for request elapsed time
        },

        -- enable/disable request summary in the output window
        show_request_summary = true,
        -- disable notifications of script output
        disable_script_print_output = false,

        report = {
          -- possible values: true | false | "on_error"
          show_script_output = true,
          -- possible values: true | false | "on_error" | "failed_only"
          show_asserts_output = true,
          -- possible values: true | false | "on_error"
          show_summary = true,

          headersHighlight = "Special",
          successHighlight = "String",
          errorHighlight = "Error",
        },

        -- scratchpad default contents
        scratchpad_default_contents = {
          "@MY_TOKEN_NAME=my_token_value",
          "",
          "# @name scratchpad",
          "POST https://httpbin.org/post HTTP/1.1",
          "accept: application/json",
          "content-type: application/json",
          "",
          "{",
          '  "foo": "bar"',
          "}",
        },

        disable_news_popup = false,

        -- enable/disable built-in autocompletion
        autocomplete = true,

        -- enable/disable lua syntax highlighting in HTTP scripts
        lua_syntax_hl = true,
      },

      -- enable/disable debug mode
      debug = 3,

      -- set to true to enable default keymaps (check docs or {plugins_path}/kulala.nvim/lua/kulala/config/keymaps.lua for details)
      -- or override default keymaps as shown in the example below.
      ---@type boolean|table
      global_keymaps = {
        ["Open scratchpad"] = {
          "<leader>Rb",
          function()
            require("kulala").scratchpad()
          end,
        },
        ["Open kulala"] = {
          "<leader>Ro",
          function()
            require("kulala").open()
          end,
        },

        ["Toggle headers/body"] = {
          "<leader>mt",
          function()
            require("kulala").toggle_view()
          end,
          ft = { "http", "rest" },
        },
        ["Show stats"] = {
          "<leader>mS",
          function()
            require("kulala").show_stats()
          end,
          ft = { "http", "rest" },
        },

        ["Close window"] = {
          "<leader>mq",
          function()
            require("kulala").close()
          end,
          ft = { "http", "rest" },
        },

        ["Copy as cURL"] = {
          "<leader>mc",
          function()
            require("kulala").copy()
          end,
          ft = { "http", "rest" },
        },
        ["Paste from curl"] = {
          "<leader>mf",
          function()
            require("kulala").from_curl()
          end,
          ft = { "http", "rest" },
        },

        ["Send request"] = {
          "<leader>mr",
          function()
            require("kulala").run()
          end,
          mode = { "n", "v" },
          ft = { "http", "rest" },
        },
        ["Send request <cr>"] = {
          "<CR>",
          function()
            require("kulala").run()
          end,
          mode = { "n", "v" },
          ft = { "http", "rest" },
        },
        ["Send all requests"] = {
          "<leader>ma",
          function()
            require("kulala").run_all()
          end,
          mode = { "n", "v" },
          ft = { "http", "rest" },
        },

        ["Inspect current request"] = {
          "<leader>mi",
          function()
            require("kulala").inspect()
          end,
          ft = { "http", "rest" },
        },
        ["Replay the last request"] = {
          "<leader>ml",
          function()
            require("kulala").replay()
          end,
          ft = { "http", "rest" },
        },

        ["Find request"] = {
          "<leader>mm",
          function()
            require("kulala").search()
          end,
          ft = { "http", "rest" },
        },
        ["Jump to next request"] = {
          "]]",
          function()
            require("kulala").jump_next()
          end,
          ft = { "http", "rest" },
        },
        ["Jump to previous request"] = {
          "[[",
          function()
            require("kulala").jump_prev()
          end,
          ft = { "http", "rest" },
        },

        ["Select environment"] = {
          "<leader>me",
          function()
            require("kulala").set_selected_env()
          end,
          ft = { "http", "rest" },
        },
        ["Download GraphQL schema"] = {
          "<leader>mg",
          function()
            require("kulala").download_graphql_schema()
          end,
          ft = { "http", "rest" },
        },

        ["Clear globals"] = {
          "<leader>mx",
          function()
            require("kulala").scripts_clear_global()
          end,
          ft = { "http", "rest" },
        },
        ["Clear cached files"] = {
          "<leader>mX",
          function()
            require("kulala").clear_cached_files()
          end,
          ft = { "http", "rest" },
        },
      },

      -- Kulala UI keymaps, override with custom keymaps as required (check docs or {plugins_path}/kulala.nvim/lua/kulala/config/keymaps.lua for details)
      ---@type boolean|table
      kulala_keymaps = {
        ["Show headers"] = {
          "H",
          function()
            require("kulala.ui").show_headers()
          end,
        },
        ["Show body"] = {
          "B",
          function()
            require("kulala.ui").show_body()
          end,
        },
        ["Show headers and body"] = {
          "A",
          function()
            require("kulala.ui").show_headers_body()
          end,
        },
        ["Show verbose"] = {
          "X",
          function()
            require("kulala.ui").show_verbose()
          end,
        },

        ["Show script output"] = {
          "O",
          function()
            require("kulala.ui").show_script_output()
          end,
        },
        ["Show stats"] = {
          "S",
          function()
            require("kulala.ui").show_stats()
          end,
        },
        ["Show report"] = {
          "R",
          function()
            require("kulala.ui").show_report()
          end,
        },

        ["Next response"] = {
          "]]",
          function()
            require("kulala.ui").show_next()
          end,
        },
        ["Previous response"] = {
          "[[",
          function()
            require("kulala.ui").show_previous()
          end,
        },
        ["Jump to response"] = {
          "<CR>",
          function()
            require("kulala.ui").jump_to_response()
            vim.cmd "noh"
          end,
        },

        ["Clear responses history"] = {
          "K",
          function()
            require("kulala.ui").clear_responses_history()
          end,
        },

        ["Show help"] = {
          "?",
          function()
            require("kulala.ui").show_help()
          end,
        },
        ["Close"] = {
          "q",
          function()
            require("kulala.ui").close_kulala_buffer()
          end,
        },
      },
    },
  },
  {
    "mistweaverco/kulala.nvim",
    opts = function()
      require("which-key").add {
        { "<leader>m", group = "HTTP" },
        { "<leader>R", group = "Kulala" },
      }
    end,
  },
}
