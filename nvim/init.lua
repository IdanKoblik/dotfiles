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

require('luatab').setup{}

require("lsp_lines").setup()
    vim.diagnostic.config({
      virtual_text = false,
})

require("presence").setup({
    auto_update         = true,                       
    neovim_image_text   = "The One True Text Editor", 
    main_image          = "neovim",                   
    client_id           = "429212281914785793",       
    log_level           = nil,                        
    debounce_timeout    = 10,                         
    enable_line_number  = false,                      
    blacklist           = {},                         
    blacklist_repos     = {},                         
    buttons             = true,                       
    file_assets         = {},                         
    show_time           = true,                       

    editing_text        = "Editing %s",               
    file_explorer_text  = "Browsing %s",              
    git_commit_text     = "Committing changes",       
    plugin_manager_text = "Managing plugins",         
    reading_text        = "Reading %s",               
    workspace_text      = "Working on %s",            
    line_number_text    = "Line %s out of %s",        
})
