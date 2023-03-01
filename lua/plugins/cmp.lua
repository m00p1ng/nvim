return {
  "hrsh7th/nvim-cmp", -- The completion plugin
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
    "rcarriga/cmp-dap",
    { "tzachar/cmp-tabnine", build = "./install.sh" },

    "L3MON4D3/LuaSnip", --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  },
  config = function()
    local cmp = require "cmp"
    local cmp_dap = require "cmp_dap"
    local luasnip = require "luasnip"
    local compare = require "cmp.config.compare"
    require("luasnip/loaders/from_vscode").lazy_load()

    local icons = require "utils.icons"

    local kind_icons = icons.kind

    vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or cmp_dap.is_dap_buffer()
      end,
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs( -1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = icons.misc.Lightning
            local detail = (entry.completion_item.data or {}).detail
            if detail and detail:find ".*%%.*" then
              vim_item.kind = vim_item.kind .. " " .. detail
            end

            if (entry.completion_item.data or {}).multiline then
              vim_item.kind = vim_item.kind .. " " .. "[ML]"
            end

            vim_item.kind_hl_group = "CmpItemKindTabnine"
          end

          if entry.source.name == "emoji" then
            vim_item.kind = icons.misc.Smiley
            vim_item.kind_hl_group = "CmpItemKindEmoji"
          end
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          -- NOTE: order matters
          vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[Nvim]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                cmp_tabnine = "[T9]",
                path = "[Path]",
                emoji = "",
                dap = "",
              })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = "lab.quick_data", keyword_length = 4 },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "cmp_tabnine" },
        { name = "path" },
        { name = "emoji" },
        { name = "dap" },
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require "cmp_tabnine.compare",
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.locality,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
        native_menu = false,
      },
    }

    local cmd_mapping = {
      ['<C-k>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ['<C-j>'] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ['<C-n>'] = {
        c = function(fallback)
          fallback()
        end
      },
      ['<C-p>'] = {
        c = function(fallback)
          fallback()
        end
      },
    }

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(cmd_mapping),
      sources = {
        { name = 'buffer' }
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(cmd_mapping),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    cmp.setup.filetype("dap-repl", {
      sources = cmp.config.sources {
        { name = "dap" },
      },
    })
  end,
}