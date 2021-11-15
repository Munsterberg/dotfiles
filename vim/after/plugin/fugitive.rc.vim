if !exists('*fugitive#statusline')
  set statusline=%F\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}[L%l/%L,C%03v]
  set statusline+=%=
  set statusline+=%{fugitive#statusline()}
endif

nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gbc :Git checkout -b<space>
nnoremap <leader>gb :Git branch<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gmt :Git mergetool<CR>
