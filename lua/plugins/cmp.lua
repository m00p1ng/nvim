local border = function(hl)
  return {
    { "┌", hl },
    { "─", hl },
    { "┐", hl },
    { "│", hl },
    { "┘", hl },
    { "─", hl },
    { "└", hl },
    { "│", hl },
  }
end

---@diagnostic disable: missing-fields
return {
  "hrsh7th/nvim-cmp", -- The completion plugin
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "rcarriga/cmp-dap",

    "L3MON4D3/LuaSnip", --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  },
  config = function()
    local cmp = require "cmp"
    local cmp_dap = require "cmp_dap"
    local luasnip = require "luasnip"
    local compare = require "cmp.config.compare"
    require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip/loaders/from_lua").load {
      paths = vim.fn.stdpath "config" .. "/snippets/",
    }

    local icons = require "utils.icons"

    local kind_icons = icons.kind

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      enabled = function()
        return vim.bo.buftype ~= "prompt" or cmp_dap.is_dap_buffer()
      end,
      window = {
        completion = {
          border = border "PmenuBorder",
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
          scrollbar = false,
        },
        documentation = {
          border = border "CmpDocBorder",
          winhighlight = "Normal:CmpDoc",
        },
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
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
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
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
          vim_item.kind = kind_icons[vim_item.kind] or ""

          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = icons.misc.Stars
            local detail = (entry.completion_item.data or {}).detail
            if detail and detail:find ".*%%.*" then
              vim_item.kind = vim_item.kind .. " " .. detail
            end

            if (entry.completion_item.data or {}).multiline then
              vim_item.kind = vim_item.kind .. " " .. "[ML]"
            end

            vim_item.kind_hl_group = "CmpItemKindTabnine"
          end

          if entry.source.name == "lab.quick_data" then
            vim_item.kind = icons.misc.CircuitBoard
            vim_item.kind_hl_group = "CmpItemKindConstant"
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
            dap = "",
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "cmp_tabnine" },
        { name = "path" },
        { name = "dap" },
        { name = "lab.quick_data", keyword_length = 4 },
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
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
    }

    local cmd_mapping = {
      ["<C-k>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ["<C-j>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ["<Up>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ["<Down>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ["<C-n>"] = {
        c = function(fallback)
          fallback()
        end,
      },
      ["<C-p>"] = {
        c = function(fallback)
          fallback()
        end,
      },
    }

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(cmd_mapping),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(cmd_mapping),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    cmp.setup.filetype("dap-repl", {
      sources = cmp.config.sources {
        { name = "dap" },
      },
    })

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("fix_luasnaip", { clear = true }),
      callback = function()
        if luasnip.expand_or_jumpable() then
          luasnip.unlink_current()
        end
      end,
    })
  end,
}
