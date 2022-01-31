call plug#begin('$HOME/.config/nvim/plugged')
  if !empty(glob("$HOME/.config/nvim/nvim_plugins.vim"))
    source $HOME/.config/nvim/nvim_plugins.vim
  endif
call plug#end()

lua require("fdm1")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

set dir=/tmp//
set hidden
set ignorecase
set mouse=
set number
set ruler
set showmatch
set smartcase
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set undofile
set clipboard=unnamed

" disable modelines to stop arbitrary code execution vulnerability
set modelines=0
set nomodeline

autocmd QuickFixCmdPost *grep* cwindow

" trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
imap <C-L> <SPACE>=><SPACE>

nnoremap <LocalLeader>* :keepjumps normal! #*<CR>
nnoremap <LocalLeader># :keepjumps normal! *#<CR>


" remove whitespace
nnoremap <LocalLeader>W :%s/\s\+$//<cr>:let @/=''<CR>

let g:exchange_no_mappings=1
nmap <silent> cx <Plug>(Exchange)
xmap <silent> X <Plug>(Exchange)
nmap <silent> cxc <Plug>(ExchangeClear)
nmap <silent> cxx <Plug>(ExchangeLine)

nmap <silent> [q :cprevious<CR>
nmap <silent> ]q :cnext<CR>
nmap <silent> [Q :cfirst<CR>
nmap <silent> ]Q :clast<CR>

" easy exit for vim/fzf stuck in terminal mode
tnoremap <Esc> <C-\><C-n>:q!<CR>

let g:neoterm_default_mod = 'rightbelow'
let g:neoterm_size = '20'

function! ClearTerminalTransform(cmd) abort
  return 'clear;'.a:cmd
endfunction

let g:test#custom_transformations = {'clear': function('ClearTerminalTransform')}
let g:test#transformation = 'clear'

" Allows javascript tests to run
let test#javascript#mocha#executable = 'yarn test:single'
let test#javascript#jest#executable = 'yarn test:single'

map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>
map <silent> <leader>rn :set rnu!<CR>

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Enable hybrid relative numbers by default
set rnu

" ###### PERSONAL CONFIG ######

if filereadable(expand("~/.my_nvimrc"))
  source $HOME/.my_nvimrc
endif
