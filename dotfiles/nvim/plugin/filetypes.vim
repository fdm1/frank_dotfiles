au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

au BufRead,BufNewFile Podfile,*.podspec setfiletype ruby
autocmd FileType ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

au BufRead,BufNewFile .*vim* setfiletype vim

autocmd BufEnter *.tsx set filetype=typescript

autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us

autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell