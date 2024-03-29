vim.g.mapleader = " "

vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", vim.cmd.Vex)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "<leader>fa", vim.lsp.buf.format)
vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set("n", "<leader>co", 'ggVG"*y')
vim.keymap.set("n", "<leader>so", ":source $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>v", ":vnew <C-R>=escape(expand(\"%:p:h\"), '') . '/'<cr>")
vim.keymap.set("n", "<leader>s", ":split <C-R>=escape(expand(\"%:p:h\"), '') . '/'<cr>")
vim.keymap.set("n", "<leader>e", ":edit <C-R>=escape(expand(\"%:p:h\"), '') . '/'<cr>")
vim.keymap.set("n", "<leader>,", ":nohlsearch<cr>")
vim.keymap.set("n", "<leader>bu", ":ls<CR>:b<Space>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bf", ":bfirst<CR>")
vim.keymap.set("n", "<leader>bl", ":blast<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>wj", "<C-W><C-J>")
vim.keymap.set("n", "<leader>wk", "<C-W><C-K>")
vim.keymap.set("n", "<leader>wl", "<C-W><C-L>")
vim.keymap.set("n", "<leader>wh", "<C-W><C-H>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>zz")
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gH", "<cmd>diffget //3<CR>")

vim.api.nvim_exec(
	[[
function! DeleteHiddenBuffers() abort
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
nnoremap <leader>bc :call DeleteHiddenBuffers()<CR>
]],
	false
)

vim.api.nvim_exec(
	[[
command! ClearQuickfixList cexpr []

nnoremap <leader>qc :ClearQuickfixList<CR>
]],
	false
)
