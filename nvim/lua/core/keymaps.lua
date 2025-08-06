local keymap = vim.keymap
local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

vim.g.mapleader = " "

-- lens
vim.keymap.set(
  "",
  "<Leader>ll",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)

-- markdown
vim.keymap.set("n", "<leader>me", ":RednerMarkdown enable<CR>", opts)
vim.keymap.set("n", "<leader>md", ":RenderMarkdown disable<CR>", opts)

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)

-- git
vim.keymap.set("n", "<leader>ga", function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({ prompt = "Files to git add (" .. cwd .. "): " }, function(files)
    if not files or files == "" then return end
    vim.fn.jobstart({ "git", "add", files }, {
      cwd = cwd,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✔ Git add successful", vim.log.levels.INFO)
        else
          vim.notify("✘ Git add failed", vim.log.levels.ERROR)
        end
      end,
    })
  end)
end, { noremap = true, silent = true, desc = "Git add" })

vim.keymap.set("n", "<leader>gm", function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({ prompt = "Commit message: " }, function(message)
    if not message or message == "" then return end
    vim.fn.jobstart({ "git", "commit", "-m", message }, {
      cwd = cwd,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✔ Git commit successful", vim.log.levels.INFO)
        else
          vim.notify("✘ Git commit failed", vim.log.levels.ERROR)
        end
      end,
    })
  end)
end, { noremap = true, silent = true, desc = "Git commit" })

vim.keymap.set("n", "<leader>gp", function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({ prompt = "Branch to push to: " }, function(branch)
    if not branch or branch == "" then return end
    vim.fn.jobstart({ "git", "push", "origin", branch }, {
      cwd = cwd,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✔ Git push to '" .. branch .. "' successful", vim.log.levels.INFO)
        else
          vim.notify("✘ Git push to '" .. branch .. "' failed", vim.log.levels.ERROR)
        end
      end,
    })
  end)
end, { noremap = true, silent = true, desc = "Git push to branch" })
-- files
vim.keymap.set("n", "<leader>nf", function()
  local cwd = vim.fn.getcwd()
  vim.ui.input({ prompt = "New file in " .. cwd .. ": " }, function(input)
    if input and input ~= "" then
      local path = cwd .. "/" .. input
      local dir = vim.fn.fnamemodify(path, ":h")  
      vim.fn.mkdir(dir, "p")  
      vim.cmd("edit " .. vim.fn.fnameescape(path))
    end
  end)
end, { noremap = true, silent = true, desc = "Create new file in current directory (with folder support)" })


-- replace
vim.keymap.set("n", "<leader>r", function()
  local current_word = vim.fn.expand("<cword>")
  vim.ui.input({ prompt = "Replace '" .. current_word .. "' with: " }, function(input)
    if input and input ~= "" then
      vim.cmd("%s/\\<" .. current_word .. "\\>/" .. input .. "/g")
    end
  end)
end, { noremap = true, silent = true, desc = "Replace word under cursor" })

-- config
vim.keymap.set("n", "<leader>vc", function()
  vim.cmd("edit $MYVIMRC")
end, { noremap = true, silent = true, desc = "Open Neovim config" })

vim.keymap.set("n", "<leader>vp", function()
  vim.cmd("edit ~/.config/nvim/lua/core/plugins.lua")
end, { noremap = true, silent = true, desc = "Open Neovim plugins" })

vim.keymap.set("n", "<leader>vk", function()
  vim.cmd("edit ~/.config/nvim/lua/core/keymaps.lua")
end, { noremap = true, silent = true, desc = "Open Neovim keymap" })

-- Save / Quit / Force quit
keymap.set("n", "<leader>w", ":w<CR>", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
keymap.set("n", "<leader>x", ":q!<CR>", opts)

-- Inside 
vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "<leader>b", "<C-o>", { desc = "Go back to previous location" })

-- Goto
vim.keymap.set("n", "<leader>g", function()
  local line = tonumber(vim.fn.input("Go to line: "))
  if line then vim.cmd(tostring(line)) end
end, { desc = "Go to specific line" }, opts)

-- Move between windows using Ctrl + h/j/k/l
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Telescope keybinds
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- File exploer
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Go packages 
vim.keymap.set("n", "<leader>gi", function()
  vim.ui.input({ prompt = "Go package to install: " }, function(pkg)
    if not pkg or pkg == "" then return end
    local cwd = vim.fn.getcwd()
    vim.fn.jobstart({ "go", "get", pkg }, {
      cwd = cwd,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("✔ Go package '" .. pkg .. "' installed successfully", vim.log.levels.INFO)
        else
          vim.notify("✘ Failed to install Go package '" .. pkg .. "'", vim.log.levels.ERROR)
        end
      end,
    })
  end)
end, { noremap = true, silent = true, desc = "Go install package" })

