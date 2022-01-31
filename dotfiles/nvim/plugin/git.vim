nmap <silent> <LocalLeader>gw :Ggrep <cword><CR>
nmap <silent> <LocalLeader>ng :GitGutterToggle<CR>
nmap <silent> <LocalLeader>o "zy<C-G> 0vt:"ay:Gbrowse <C-R>=ChooseRepo()<CR><CR>

" disable git gutter by default
let g:gitgutter_enabled = 0