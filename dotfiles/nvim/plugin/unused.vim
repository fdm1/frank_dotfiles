" A place to keep stuff I had, but am removing

" nmap <silent> <LocalLeader>ff :CtrlP<CR>
" nmap <silent> <LocalLeader>na :ALEToggle<CR>

" nmap <silent> <LocalLeader>rb :wa <bar> :TestFile -strategy=neoterm<CR>
" nmap <silent> <LocalLeader>rf :wa <bar> :TestNearest -strategy=neoterm<CR>
" nmap <silent> <LocalLeader>rl :wa <bar> :TestLast -strategy=neoterm<CR>
" nmap <silent> <LocalLeader>tt :TagbarToggle<CR>
" nmap <silent> <LocalLeader>tf :TagbarOpen fj<CR>
" nmap <silent> <LocalLeader>tc :TagbarClose<CR>
" nmap <silent> <LocalLeader>p :Files<CR>

" File and folder CtrlP exclusions. See https://github.com/kien/ctrlp.vim
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$\|node_modules$\|Pods$\|build$\|public/packs$',
"   \ }

" let g:wordmotion_prefix = '<LocalLeader>'
" let g:wordmotion_mappings = {
" \ 'b' : '<LocalLeader>bb',
" \ }

" Sort tags in order of appearance by default
" let g:tagbar_sort = 0

" ###### ALE ######

" when to lint
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_filetype_changed = 1

" how to lint
" let g:ale_linters = {'ruby': ['rubocop'], 'javascript': ['eslint']}

" add sign column emoticons
" let g:ale_sign_error = 'e'
" let g:ale_sign_warning = 'w'

" message format
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" always show the sign column
" let g:ale_sign_column_always = 1
" let g:ale_set_higlights = 1

" what to fix and how
" let g:ale_fixers = {
" \  'javascript': ['eslint'],
" \  'ruby': ['rubocop']
" \}

" fix on file save
" let g:ale_fix_on_save = 1
" use bundler to allow rubocop to access project gems for linting
" let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'

" reset sign column background colors
" highlight link ALEError SignColumn
" highlight link ALEWarning SignColumn
" highlight link ALEErrorSign SignColumn
" highlight link ALEWarningSign SignColumn

" faster fzf fuzzy find respecting gitignore
" let $FZF_DEFAULT_COMMAND = '((git ls-tree -r --name-only HEAD; git ls-files -o --exclude-standard) || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

" tmux-ify test runners
" nmap <silent> <LocalLeader>rb :wa <bar> :TestFile -strategy=vimux<CR>
" nmap <silent> <LocalLeader>rf :wa <bar> :TestNearest -strategy=vimux<CR>
" nmap <silent> <LocalLeader>rl :wa <bar> :TestLast -strategy=vimux<CR>

" format python files with black if its installed in a local pipenv
" if filereadable('Pipfile.lock')
"   let black = system('grep \"black\" Pipfile.lock -q')
"   if v:shell_error == 0
"     let g:ale_fixers['python'] = ['black']
"     let g:ale_python_black_auto_pipenv = 1
"   endif
" end


" You Complete Me
" let g:ycm_key_list_select_completion=[]
" let g:ycm_key_list_previous_completion=[]
" let g:ycm_max_diagnostics_to_display=0
" " DEBUG STUFFS
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
" let g:ycm_warning_symbol = '.'
" let g:ycm_error_symbol = '..'
" let g:ycm_server_use_vim_stdout = 1

" Autocompletion
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" map <silent> <leader>ff :Files<CR>

" map <silent> <LocalLeader>ag :Ag<CR>

" nmap <silent> <LocalLeader>bi :T bi<CR>
" nmap <silent> <LocalLeader>bf :exec 'T '.getline('.')<CR>
" nmap <silent> <LocalLeader>bl :T !!<CR>
" nmap <silent> <LocalLeader>uf :T untilfail !!<CR>
" vmap <silent> <LocalLeader>bf y:T <C-R>"<CR>
" nmap <silent> <LocalLeader>ss :T ss<CR>
" vmap <silent> <LocalLeader>ss y:T ss <C-R>"<CR>

" Allows Ctrl-P to find hidden files like .env
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_max_files = 40000
