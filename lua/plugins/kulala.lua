return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    opts = {
      -- cURL path
      -- if you have curl installed in a non-standard path,
      -- you can specify it here
      curl_path = "curl",
      -- Display mode
      -- possible values: "split", "float"
      display_mode = "split",
      -- split direction
      -- possible values: "vertical", "horizontal"
      split_direction = "vertical",
      -- default_view, body or headers or headers_body
      default_view = "headers_body",
      -- dev, test, prod, can be anything
      -- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
      default_env = "dev",
      -- enable/disable debug mode
      debug = false,
      show_icons = "on_request",
      -- default icons
      icons = {
        inlay = {
          loading = "⏳",
          done = "✅",
          error = "❌",
        },
        lualine = "🐼",
      },
      -- additional cURL options
      -- see: https://curl.se/docs/manpage.html
      additional_curl_options = {},
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
      -- enable winbar
      winbar = false,
      -- Specify the panes to be displayed by default
      -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats" },
      default_winbar_panes = { "body", "headers", "headers_body" },
      -- enable reading vscode rest client environment variables
      vscode_rest_client_environmentvars = false,
      -- parse requests with tree-sitter
      treesitter = false,
      -- disable the vim.print output of the scripts
      -- they will be still written to disk, but not printed immediately
      disable_script_print_output = false,
      -- set scope for environment and request variables
      -- possible values: b = buffer, g = global
      environment_scope = "b",
      -- certificates
      certificates = {},
      -- Specify how to escape query parameters
      -- possible values: always, skipencoded = keep %xx as is
      urlencode = "always",
    },
    keys = {
      { "<leader>mr", "<cmd>lua require('kulala').run()<cr>", desc = "Send Request", buffer = true },
      { "<leader>ml", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay", buffer = true },
      { "<leader>mf", "<cmd>lua require('kulala').from_curl()<cr>", desc = "From cURL", buffer = true },
      { "<leader>mc", "<cmd>lua require('kulala').copy()<cr>", desc = "To cURL", buffer = true },
      { "[r", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Prev req", buffer = true },
      { "]r", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next req", buffer = true },
    },
  },
  {
    "mistweaverco/kulala.nvim",
    opts = function()
      require("which-key").add {
        { "<leader>m", group = "HTTP" },
      }
    end,
  },
}
