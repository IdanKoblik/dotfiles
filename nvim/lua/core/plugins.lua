-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 100,
  },

  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
  },

  -- matcher
  "wurli/visimatch.nvim",

  -- File Explorer
  "nvim-tree/nvim-tree.lua",

  -- Terminal
  "akinsho/toggleterm.nvim",

  -- Telescope
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },

  -- LSP & Autocompletion
  {
    "stevanmilic/nvim-lspimport",
    config = function()
      vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true, desc = "LSP Import missing symbol" })
    end,
  },


  { "neovim/nvim-lspconfig" },        
  { "hrsh7th/nvim-cmp" },            
  { "hrsh7th/cmp-nvim-lsp" },            
  { "L3MON4D3/LuaSnip" },            
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Status line
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }
})
