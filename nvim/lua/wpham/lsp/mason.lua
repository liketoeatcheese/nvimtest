local servers = {
  --[[ "sumneko_lua", ]]
  "lua_ls",
  -- "cssls",
  -- "html",
  -- "tsserver",
  "pyright",
  -- "bashls",
  "jsonls",
  -- "golang",
  "gopls",
  -- "golang"
  "jdtls",
  -- "Bash"
  "bashls",
  -- "JavaScript"
  "quick_lint_js",
  -- "VIM"
  "vimls",
  -- "YAML"
  --[[ "yamlls", ]]
  --TypeScript
  "tsserver",
  --latex
  "ltex",
  --Rust
  "rust_analyzer"
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

--[[ require'lspconfig'.java_language_server.setup{} ]]

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("wpham.lsp.handlers").on_attach,
    capabilities = require("wpham.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "wpham.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }, -- By default, lua-language-server sends anonymized data to its developers. Stop it using the following.
      telemetry = {
        enable = false,
      },
    },
  },
})

require("lspconfig").ltex.setup({
  settings = {
    filetype = {"markdown"}
  },
})

require("lspconfig").yamlls.setup({
  on_attach = require("wpham.lsp.handlers").on_attach,
  capabilities = require("wpham.lsp.handlers").capabilities,
  settings = {
    yaml = {
      --[[ format = { ]]
      --[[   enable = true ]]
      --[[ }, ]]
      schemas = {
        --[[ ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*", ]]
        --[[ ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*", ]]
        kubernetes = "/*.yaml",
      },
    },
  },
})
