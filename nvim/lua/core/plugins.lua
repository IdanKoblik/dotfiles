local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   {
      "webhooked/kanso.nvim",
      lazy = false,
      priority = 1000,
   },

   -- Whichkey
   "folke/which-key.nvim",

   -- File exploer
   "nvim-tree/nvim-tree.lua",

   -- Telescope
   { "nvim-telescope/telescope.nvim", dependencies = { 'nvim-lua/plenary.nvim' } },

   -- Discord
   {"jiriks74/presence.nvim", event = "UIEnter",},

   -- LSP
   {
     "williamboman/mason.nvim",
     lazy = false,
   },
   {
     "williamboman/mason-lspconfig.nvim",
     lazy = false,
   },
   {
     "neovim/nvim-lspconfig",
     lazy = false,
   },
   {
     "hrsh7th/nvim-cmp",
     dependencies = {
       "hrsh7th/cmp-nvim-lsp",
       "hrsh7th/cmp-buffer",
       "hrsh7th/cmp-path",
       "hrsh7th/cmp-cmdline",
       "L3MON4D3/LuaSnip",
       "saadparwaiz1/cmp_luasnip",
     },
     lazy = false,
   },

   -- cmdline
   {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = { "MunifTanjim/nui.nvim" },
      opts = {
        presets = {
          command_palette = true,
          long_message_to_split = true,
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
          },
        },
      },
      keys = {
        { "<leader>;", mode = { "n", "v" }, desc = "Floating Command Palette" },
      },
   },

   -- Git
   "lewis6991/gitsigns.nvim",
   {
     'SuperBo/fugit2.nvim',
     build = false,
     opts = {
       width = 100,
     },
     dependencies = {
       'MunifTanjim/nui.nvim',
       'nvim-tree/nvim-web-devicons',
       'nvim-lua/plenary.nvim',
     },
     cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
   },

   -- Harpoon
   { "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" }},

   -- Status line
   {"tjdevries/express_line.nvim", dependencies = { 'nvim-lua/plenary.nvim' }},
})
