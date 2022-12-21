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
    "cpp",
    "css",
    "dockerfile",
    "elixir",
    "go",
    "javascript",
    "python",
    "ruby",
    "rust",
    "typescript",
    "toml",
    "vim",
    "lua"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = false,
  },
}
EOF
