syntax on "required for polyglot
filetype plugin on                  " required
let g:python_host_prog = '/Users/munsterberg/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/munsterberg/.pyenv/versions/neovim3/bin/python'
set clipboard=unnamed

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" need neovim 0.5
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" Autocomplete plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" == Syntax ==
Plug 'pangloss/vim-javascript'
Plug 'herringtondarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'jparise/vim-graphql'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" == Linting ==
Plug 'dense-analysis/ale'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" === Plugin settings ===
" language server
let g:LanguageClient_serverCommands = {
\ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
\ }

" prettier
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue Prettier

" == w0rp/ale ==
let g:ale_sign_error = '●'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\  'ruby': ['standardrb', 'rubocop'],
\}
let g:ale_fixers = {
\  'ruby': ['standardrb'],
\}

" typescript syntax disable indenting for CoC to handle
let g:typescript_indent_disable = 1

"" == python/black ==
" let g:black_fast = 0
" let g:black_linelength = 88
" let g:black_skip_string_normalization = 0
" let g:black_virtualenv = '/usr/local/bin/'

"" == junegunn/fzf.vim ==
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :GFiles<cr>
nnoremap <leader>af :FZF<cr>
augroup fzf
autocmd!
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

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
set statusline+=%{coc#status()}                       " coc statusline
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
nnoremap <leader>pp :Prettier<cr>
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
nnoremap <leader>, :nohlsearch<CR>
" open vertical explorer
nnoremap <leader>pv :Vex<CR>
" Ripgrep quickfix
nnoremap <leader>rg :RG<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
" fugitive
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gbc :Git checkout -b<space>
nnoremap <leader>gb :Git branch<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gmt :Git mergetool<CR>

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
set belloff+=ctrlg  " if vim beeps during completion

"-----------------"
"coc.nvim settings"
"-----------------"

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-json',
  \ 'coc-clangd'
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm."
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "k"


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" SNIPPETS
nnoremap <leader>html :-1read $HOME/.vim/snippets/.skeleton.html<CR>7ji
nnoremap <leader>crc :-1read $HOME/.vim/snippets/.crc.js<CR>4jwwli
nnoremap <leader>fsc :-1read $HOME/.vim/snippets/.fsc.js<CR>3jf(li

let g:netrw_banner = 0
nnoremap - :Explore <CR>

" FUNCTIONS

" function! LinterStatus() abort
"    let l:counts = ale#statusline#Count(bufnr(''))
"    let l:all_errors = l:counts.error + l:counts.style_error
"    let l:all_non_errors = l:counts.total - l:all_errors
"    return l:counts.total == 0 ? '' : printf(
"    \ 'W:%d E:%d',
"    \ l:all_non_errors,
"    \ l:all_errors
"    \)
" endfunction

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

function! s:show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

command! -nargs=* Zet call ZettelEdit(<f-args>)

" CocPrettier command
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

function! ZettelEdit(...)
  " build the file name
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '-'
  endif
  let l:fname = expand('~/wiki/') . strftime("%F-%H%M") . l:sep . join(a:000, '-') . '.md'

  " edit the new file
  exec "e " . l:fname

  " enter the title and timestamp (using ultisnips) in the new file
  if len(a:000) > 0
    exec "normal ggO\<c-r>=strftime('%Y-%m-%d %H:%M')\<cr> " . join(a:000) . "\<cr>\<esc>G"
  else
    exec "normal ggO\<c-r>=strftime('%Y-%m-%d %H:%M')\<cr>\<cr>\<esc>G"
  endif
endfunction

autocmd Filetype help nmap <buffer>q :q<cr>
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :call TrimEndLinesMain()
" Python black formatting
" autocmd BufWritePre *.py execute ':Black'
" C formatting
autocmd BufNewFile,BufRead *.c,*.h  setlocal ts=4 sw=4 sts=4 ai fileformat=unix
" tsx and jsx highlighting
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
" Go formatting
autocmd BufNewFile,BufRead *.go setlocal ts=4 sw=4 sts=4 ai noet fileformat=unix
" Elixir formatting
autocmd BufWritePost *.exs,*.ex silent :!mix format %
" SCSS
autocmd FileType scss setl iskeyword+=@-@

set tags=tags
