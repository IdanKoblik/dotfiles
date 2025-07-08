local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Common setup function
local function setup(server)
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end

-- Install these manually via pacman, go install, npm, etc.
local servers = {
  "clangd",                   -- C/C++
  "gopls",                    -- Go
  "pyright",                  -- Python
  "jdtls",                    -- Java
  "kotlin_language_server",   -- Kotlin
  "ts_ls",                 -- JavaScript/TypeScript
}

for _, server in ipairs(servers) do
  setup(server)
end

