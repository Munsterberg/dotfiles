" auto-install vim-plug
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  silent exe '!curl -fLo ' . plug_path . ' --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')

" Declare the list of plugins.
" Color scheme plugins
Plug 'chriskempson/base16-vim'
Plug 'rktjmp/lush.nvim'

" neovim
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp', {
  \ 'branch': 'main'
  \ }
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'github/copilot.vim'

" == General editor plugins ==
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ap/vim-buftabline'
Plug 'janko/vim-test'
Plug 'wakatime/vim-wakatime'
Plug 'psf/black'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
  \ }
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'jparise/vim-graphql'

" " fuzzy file finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax

" == Linting ==
" Plug 'dense-analysis/ale'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
