require("core.options")
require("core.plugins")

require("nvim-tree").setup()
require("lualine").setup()

 require("toggleterm").setup({
    size = 15,
    open_mapping = [[<C-\>]],
    direction = "horizontal",  
    close_on_exit = true,
    start_in_insert = true,
    persist_mode = false,
})

require("core.colorscheme")
require("core.lsp")
require("core.completion")
require("core.keymaps")
