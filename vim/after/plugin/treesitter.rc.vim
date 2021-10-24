if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "tsx",
    "toml",
    "scss",
    "json",
    "yaml",
    "html",
    "c",
    "css",
    "dockerfile",
    "elixir",
    "go",
    "javascript",
    "python",
    "ruby",
    "typescript",
    "toml",
    "vim"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
}
EOF
