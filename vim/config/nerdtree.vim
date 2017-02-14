" Plugin configuration file:
"
" NERDTree
" https://github.com/scrooloose/nerdtree
"

map <C-n> :NERDTreeToggle<CR>
"close vim if NERDTree is the last open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

