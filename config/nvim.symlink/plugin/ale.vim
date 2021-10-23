" Ale
" https://github.com/dense-analysis/ale

let g:ale_puppet_puppet_executable = '/opt/puppetlabs/bin/puppet'
let g:ale_puppet_puppetlint_executable = '/usr/local/bin/puppet-lint'
let g:ale_puppet_puppetlint_options = '--no-80chars-check  --no-autoloader_layout-check'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning =  '⚠'
"let g:ale_lint_on_text_changed = 'never'

" Show erros in qflist instead of loclist
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

" Open list in case of errors
let g:ale_open_list = 1
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 1

" For error navigation in (qf|loc)list see plugin/navigation.vim
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
