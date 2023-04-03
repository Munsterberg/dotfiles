-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  view = {
    side = "right"
  },
})

vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tr", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })
