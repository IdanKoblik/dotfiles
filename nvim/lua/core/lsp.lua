require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "gopls",
        "clangd",
        "pyright",
        "lua_ls",
    },
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    vim.diagnostic.config({
        virtual_text  = true,
        signs         = true,
        underline     = true,
        float         = true,
    })
end

local lspconfig = require("lspconfig")

-- Go
lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = lsp_on_attach,
    settings = {
        gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

-- C/C++
lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = lsp_on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- Python
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = lsp_on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
            },
        },
    },
})

-- Lua
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = lsp_on_attach,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

