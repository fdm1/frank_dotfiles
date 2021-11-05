call plug#begin('~/.config/nvim/plugged')
  Plug 'chaoren/vim-wordmotion', {'commit': '23fc891'}
  Plug 'ctrlpvim/ctrlp.vim', {'tag': '1.79'}
  Plug 'farmergreg/vim-lastplace', {'tag': 'v3.1.0'}
  Plug 'janko-m/vim-test', {'commit': '7e5e118'}
  Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.6'}
  Plug 'jtratner/vim-flavored-markdown', {'commit': '4a70aa2'}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'kassio/neoterm', {'commit': '372401281a45eb1389de523440ed38df2c059515'}
  Plug 'majutsushi/tagbar', {'commit': 'bef1fa4'}
  Plug 'mileszs/ack.vim', {'tag': '1.0.9'}
  Plug 'michaeljsmith/vim-indent-object', {'tag': '1.1.2'}
  Plug 'yuezk/vim-js', {'tag': 'v1.0.1'}
  Plug 'posva/vim-vue', {'commit': 'e306929'}
  Plug 'scrooloose/nerdtree', {'tag': '5.0.0'}
  Plug 'tommcdo/vim-exchange', {'commit': '05d82b8'}
  Plug 'tomtom/tcomment_vim', {'tag': '3.08'}
  Plug 'tpope/vim-endwise', {'commit': '0067ced'}
  Plug 'tpope/vim-fugitive', {'tag': 'v3.0'}
  Plug 'tpope/vim-rhubarb', {'commit': '75ad917e4978b4620c3b0eff1722880d2d53a9f4'}
  Plug 'tpope/vim-surround', {'tag': 'v2.1'}
  Plug 'tpope/vim-projectionist', { 'tag': 'v1.3' }
  Plug 'vim-airline/vim-airline', {'tag': 'v0.8'}
  Plug 'vim-airline/vim-airline-themes', {'commit': '13bad30'}
  Plug 'vim-scripts/argtextobj.vim', {'tag': '1.1.1'}
  Plug 'w0rp/ale', {'commit': 'e4faf82'}
  Plug 'maxmellon/vim-jsx-pretty', {'tag': 'v3.0.0'}
  Plug 'airblade/vim-gitgutter', { 'commit': 'c2651ae' }
  Plug 'morhetz/gruvbox'
  Plug 'jeffkreeftmeijer/vim-dim'
  if !empty(glob("$HOME/.config/nvim/nvim_plugins.vim"))
    source $HOME/.config/nvim/nvim_plugins.vim
  endif
call plug#end()

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

autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
autocmd QuickFixCmdPost *grep* cwindow

" trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

function! ClearTerminalTransform(cmd) abort
  return 'clear;'.a:cmd
endfunction

colorscheme Tomorrow-Night

imap <C-L> <SPACE>=><SPACE>

nmap <silent> <LocalLeader>ff :CtrlP<CR>
nmap <silent> <LocalLeader>gw :Ggrep <cword><CR>
nmap <silent> <LocalLeader>na :ALEToggle<CR>
nmap <silent> <LocalLeader>nf :NERDTreeFind<CR>
nmap <silent> <LocalLeader>ng :GitGutterToggle<CR>
nmap <silent> <LocalLeader>nh :nohls<CR>
nmap <silent> <LocalLeader>nt :NERDTreeToggle<CR>
nmap <silent> <LocalLeader>n<SPACE> :highlight clear ExtraWhitespace<CR>
nmap <silent> <LocalLeader><SPACE> :highlight ExtraWhitespace ctermbg=red guibg=red<CR>
nmap <silent> <LocalLeader>rb :wa <bar> :TestFile -strategy=neoterm<CR>
nmap <silent> <LocalLeader>rf :wa <bar> :TestNearest -strategy=neoterm<CR>
nmap <silent> <LocalLeader>rl :wa <bar> :TestLast -strategy=neoterm<CR>
nmap <silent> <LocalLeader>tt :TagbarToggle<CR>
nmap <silent> <LocalLeader>tf :TagbarOpen fj<CR>
nmap <silent> <LocalLeader>tc :TagbarClose<CR>
nmap <silent> <LocalLeader>p :Files<CR>
nmap <silent> <LocalLeader>bi :T bi<CR>
nmap <silent> <LocalLeader>bf :exec 'T '.getline('.')<CR>
nmap <silent> <LocalLeader>bl :T !!<CR>
nmap <silent> <LocalLeader>uf :T untilfail !!<CR>
vmap <silent> <LocalLeader>bf y:T <C-R>"<CR>
nmap <silent> <LocalLeader>ss :T ss<CR>
vmap <silent> <LocalLeader>ss y:T ss <C-R>"<CR>
nnoremap <LocalLeader>* :keepjumps normal! #*<CR>
nnoremap <LocalLeader># :keepjumps normal! *#<CR>
nmap <silent> <LocalLeader>o "zy<C-G> 0vt:"ay:Gbrowse <C-R>=ChooseRepo()<CR><CR>


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
let g:test#custom_transformations = {'clear': function('ClearTerminalTransform')}
let g:test#transformation = 'clear'

" Allows Ctrl-P to find hidden files like .env
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 40000

" Allows javascript tests to run
let test#javascript#mocha#executable = 'yarn test:single'
let test#javascript#jest#executable = 'yarn test:single'

" File and folder CtrlP exclusions. See https://github.com/kien/ctrlp.vim
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules$\|Pods$\|build$\|public/packs$',
  \ }

let g:wordmotion_prefix = '<LocalLeader>'
let g:wordmotion_mappings = {
\ 'b' : '<LocalLeader>bb',
\ }

" Sort tags in order of appearance by default
let g:tagbar_sort = 0

" ###### ALE ######

" when to lint
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

" how to lint
let g:ale_linters = {'ruby': ['rubocop'], 'javascript': ['eslint']}

" add sign column emoticons
let g:ale_sign_error = 'e'
let g:ale_sign_warning = 'w'

" message format
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" always show the sign column
let g:ale_sign_column_always = 1
let g:ale_set_higlights = 1

" what to fix and how
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'ruby': ['rubocop']
\}

" fix on file save
let g:ale_fix_on_save = 1
" use bundler to allow rubocop to access project gems for linting
let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'

" reset sign column background colors
highlight link ALEError SignColumn
highlight link ALEWarning SignColumn
highlight link ALEErrorSign SignColumn
highlight link ALEWarningSign SignColumn

" faster fzf fuzzy find respecting gitignore
let $FZF_DEFAULT_COMMAND = '((git ls-tree -r --name-only HEAD; git ls-files -o --exclude-standard) || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

" disable git gutter by default
let g:gitgutter_enabled = 0

" ignore certain filetypes in NERDTree
let NERDTreeIgnore=['\.tfplan$']

" ###### PERSONAL CONFIG ######

if filereadable(expand("~/.my_nvimrc"))
  source $HOME/.my_nvimrc
endif
