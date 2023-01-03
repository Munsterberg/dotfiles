vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '>~' }
vim.g['neoformat_try_node_exe'] = 1

vim.cmd([[
function! TrimEndLinesMain() abort
  let save_cursor = getpos(".")
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction
]])

vim.api.nvim_exec([[ 
autocmd BufWritePre * :call TrimEndLinesMain()
]], false)
