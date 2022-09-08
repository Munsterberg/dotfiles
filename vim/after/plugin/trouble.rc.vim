lua << EOF
  require("trouble").setup {
    -- keybinds
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
      {silent = true, noremap = true}
    ),
    vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
      {silent = true, noremap = true}
    ),
    vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
      {silent = true, noremap = true}
    ),
    vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
      {silent = true, noremap = true}
    ),
    vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
      {silent = true, noremap = true}
    ),
    vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
      {silent = true, noremap = true}
    ),

    mode = "document_diagnostics",
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    auto_fold = false,
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = false,
  }
EOF
