" Ale
" https://github.com/dense-analysis/ale

let g:ale_puppet_puppet_executable = '/opt/puppetlabs/bin/puppet'
let g:ale_puppet_puppetlint_executable = '/usr/local/bin/puppet-lint'
let g:ale_puppet_puppetlint_options = '--no-80chars-check  --no-autoloader_layout-check'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
"let g:ale_lint_on_text_changed = 'never'
