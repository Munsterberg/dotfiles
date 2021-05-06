syntax on "required for polyglot
filetype plugin on                  " required
let g:python_host_prog = '/Users/munsterberg/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/munsterberg/.pyenv/versions/neovim3/bin/python'
set clipboard=unnamed

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" neovim
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'kabouzeid/nvim-lspinstall'

" Declare the list of plugins.
" Color scheme plugins
Plug 'chriskempson/base16-vim'

" == General editor plugins ==
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ap/vim-buftabline'
Plug 'janko/vim-test'
Plug 'wakatime/vim-wakatime'
Plug 'ludovicchabant/vim-gutentags'

" fuzzy file finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" == Syntax ==
" Plug 'pangloss/vim-javascript'
" Plug 'herringtondarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'

" == Linting ==
Plug 'dense-analysis/ale'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" === Plugin settings ===
" == w0rp/ale ==
let g:ale_sign_error = '●'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0

" == nvim-telescope/telescope.nvim ==
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
}
EOF

"" Status line
set laststatus=2                                      " always show statusline
set statusline=                                       " clear statusline
set statusline+=%l                                    " current line number
set statusline+=/%L                                   " total lines
set statusline+=(%p%%)                                " percentage through the file
set statusline+=%4c                                   " cursor column
set statusline+=\|%-4{strwidth(getline('.'))}         " line length
" set statusline+=%{LinterStatus()}                     " ALE status
set statusline+=%=                                    " left/right separator
set statusline+=%{&buftype!='terminal'?expand('%:p:h:t').'\\'.expand('%:t'):expand('%')}  " dir\filename.ext
set statusline+=%m                                    " modified flag
set statusline+=%r                                    " read only flag
set statusline+=%=                                    " left/right separator
set statusline+=\ [%{strlen(&ft)?(&ft\ .\ \',\'):''}  " filetype
set statusline+=%{strlen(&fenc)?(&fenc\ .\ \',\'):''} " file encoding
set statusline+=%{&ff}]                               " line endings
set statusline+=%<                                    " start to truncate here

" === Keybindings ===
nnoremap <SPACE> <Nop>
let mapleader = " "
imap jk <Esc>
nnoremap k gk
nnoremap j gj
" copy entire file to clipboard
nnoremap <leader>co ggVG"*y
nnoremap <leader>vr :tabe $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>
" Edit/split/create a file in the same dir as the current
nnoremap <leader>e :e <C-R>=escape(expand("%:p:h"), '') . '/'<cr>
nnoremap <leader>s :split <C-R>=escape(expand("%:p:h"), '') . '/'<cr>
nnoremap <leader>v :vnew <C-R>=escape(expand("%:p:h"), '') . '/'<cr>
" Replace word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>
" Move lines up and down
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv
" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" turn off search highlight
" open vertical explorer
nnoremap <leader>, :nohlsearch<CR>
nnoremap <leader>pv :Vex<CR>
" Ripgrep quickfix
nnoremap <leader>rg :Rg<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" allows for CTRL-o to enter normal mode
" only really useful for vim test with nvim
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"

" ctags
command! MakeTags !ctags -R deps --exclude=test .

" listen to me vim
command! Q q

" Golint
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

" == COLOR SCHEME ==
let base16colorspace=256
colorscheme base16-horizon-dark

" == GENERAL SETTINGS ==
" SETTINGS
if has("gui_running")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set guifont=Inconsolata\ for\ Powerline:h15
  endif
endif
let g:netrw_localrmdir='rm -rf' " allow netrw rmdir to delete directories containing files
let python_highlight_all=1
set re=0
set termguicolors
set guicursor=n-v-c-sm:block,i-ci-ve:block
set hidden
set encoding=utf-8
set background=dark
set backspace=2
set ruler
set linebreak
set guifont=Inconsolata\ for\ Powerline:h20
set tabstop=2 " set tab to 2
set noerrorbells
set ttyfast
set gdefault
set splitright " open split on right not left
set splitbelow " open split below not above
set noswapfile
set wildmenu
set wildmode=longest:full,full
set softtabstop=2 " set editor tab to 2
set shiftwidth=2 " for indent options on text i.e. >>
set smarttab
set expandtab " set tabs to spaces
set number " show line numbers
set numberwidth=5
set showcmd " show command at bottom
set cursorline " highlight current line
set lazyredraw " redraw less often
set showmatch " highlight match
set incsearch " search as characters are entered
set hlsearch " hightlight matches
set scrolloff=5
set list listchars=tab:»\ ,trail:·,extends:>,precedes:<
set textwidth=100
set formatoptions=qrn1
set wrapmargin=0
set noswapfile
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
set colorcolumn=+1
set foldmethod=syntax
set foldlevel=99
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt+=noselect  " force user to make selection
set completeopt-=longest   " don't insert the longest common text
set completeopt-=preview

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:netrw_banner = 0
nnoremap - :Explore <CR>

function! s:check_back_space() abort
let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! <SID>StripTrailingWhitespaces() abort
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

function! TrimEndLinesMain() abort
  let save_cursor = getpos(".")
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction

function! DeleteHiddenBuffers() abort
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
nnoremap <leader>bc :call DeleteHiddenBuffers()<CR>

autocmd Filetype help nmap <buffer>q :q<cr>
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :call TrimEndLinesMain()
" C formatting
autocmd BufNewFile,BufRead *.c  setlocal ts=4 sw=4 sts=4 ai fileformat=unix
" tsx and jsx highlighting
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
" Go formatting
autocmd BufNewFile,BufRead *.go setlocal ts=4 sw=4 sts=4 ai noet fileformat=unix

set tags=tags

" disable diagnostics for now?
lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

" LANGUAGE SERVERS
lua << EOF
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{on_attach=require'completion'.on_attach}
end
EOF
