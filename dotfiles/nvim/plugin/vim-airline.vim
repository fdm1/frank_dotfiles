" Configuring the statusline
"
" https://github.com/vim-airline/vim-airline/commit/ca44fd467c1e94d05b9aca58c37697dbdb7fce44
let g:statusBarBranchLimit = 20
let g:airline#extensions#branch#format = 'TruncateBranchName'
function! TruncateBranchName(name)
  let statusBarBranchLimit = g:statusBarBranchLimit
  if len(a:name) > statusBarBranchLimit
    return a:name[0:statusBarBranchLimit-3] . '...'
  else
    return a:name
  endif
endfunction
