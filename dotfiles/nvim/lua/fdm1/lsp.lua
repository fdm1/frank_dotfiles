--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
}

local lspkind = require("lspkind")
lspkind.init({
    mode = "symbol_text",
    preset = "codicons",
})

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
local codicons_exist = file_exists(os.getenv("HOME") .. "/Library/Fonts/codicon.ttf")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    -- TODO: complete with space doesn't do anything.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  },

  formatting = {
    format = function(entry, vim_item)
      if codicons_exist then vim_item.kind = lspkind.symbol_map[vim_item.kind] end
      local menu = source_mapping[entry.source.name]
      vim_item.menu = menu
      return vim_item
    end
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
})

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }, _config or {})
end

require("lspconfig").gopls.setup(config({
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}))
