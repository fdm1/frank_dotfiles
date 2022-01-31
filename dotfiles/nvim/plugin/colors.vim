" fixes glitch? in colors when using vim with tmux
set background=dark
set t_Co=256
set termguicolors
colorscheme Tomorrow-Night

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

nmap <silent> <LocalLeader>nh :nohls<CR>
nmap <silent> <LocalLeader>n<SPACE> :highlight clear ExtraWhitespace<CR>
nmap <silent> <LocalLeader><SPACE> :highlight ExtraWhitespace ctermbg=red guibg=red<CR>