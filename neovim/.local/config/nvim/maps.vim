" Mappings

nnoremap <SPACE> <Nop>
let mapleader = " "
imap jk <Esc>
nnoremap k gk
nnoremap j gj
nnoremap Y y$
nnoremap <leader>pp :Prettier<cr>
nnoremap <leader>bb :Black<cr>
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
" buffer stuff
nnoremap <leader>bu :ls<CR>:b<Space>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>
nnoremap - :Explore <CR>

" allows for CTRL-o to enter normal mode
" only really useful for vim test with nvim
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>

fun! RelatedFile(file)
    #This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun
autocmd BufEnter *.py call SetAppDir()
