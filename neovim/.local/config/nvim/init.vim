" syntax on "required for polyglot
filetype plugin on                  " required
let g:python3_host_prog = '/Users/munsterberg/.pyenv/versions/neovim3/bin/python'
set clipboard=unnamed

set encoding=utf-8
let g:netrw_localrmdir='rm -rf' " allow netrw rmdir to delete directories containing files
" let python_highlight_all=1
set re=0
set termguicolors
set guicursor=n-v-c-sm:block,i-ci-ve:block
set hidden
set confirm
set background=dark
set backspace=2
set ruler
set linebreak
set guifont=Inconsolata\ for\ Powerline:h15
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
set relativenumber
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
set signcolumn=number
set colorcolumn=+1
set foldmethod=syntax
set foldlevel=99
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt+=noselect  " force user to make selection
set completeopt-=longest   " don't insert the longest common text
set completeopt-=preview
set belloff+=ctrlg  " if vim beeps during completion
set fillchars=eob:\ , " ole trusty tilde's gone
set laststatus=2 " always show statusline

" JavaScript
autocmd BufNewFile,BufRead *.es6 setf javascript
" TypeScript
autocmd BufNewFile,BufRead *.tsx setf typescriptreact
" Treat prisma as graphql
au BufNewFile,BufRead *.prisma setfiletype graphql
" C formatting
autocmd BufNewFile,BufRead *.c,*.h  setlocal ts=4 sw=4 sts=4 ai fileformat=unix
" Go formatting
autocmd BufNewFile,BufRead *.go setlocal ts=4 sw=4 sts=4 ai noet fileformat=unix
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)
" Elixir formatting
autocmd BufWritePost *.exs,*.ex silent :!mix format %
" Markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
" SCSS
autocmd FileType scss setl iskeyword+=@-@
" Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
" YAML
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" imports
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    set guifont=Inconsolata\ for\ Powerline:h2
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim

"" == python/black ==
let g:black_fast = 0
let g:black_linelength = 88
let g:black_skip_string_normalization = 0

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

let g:netrw_banner = 0

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

set tags=tags

lua << EOF
function goimports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end
EOF

lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
