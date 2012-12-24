syntax on
set nocompatible
set number
set autoindent
"set smartindent
set expandtab   
set ts=4 
set shiftwidth=4
set cursorline
set nobackup
" just for encode
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8
set hlsearch
" set foldmethod
set fdm=indent
"set completeopt=longest

ab COMMENT_F /** */
ab JAVASCRIPT <script type="text/javascript" src=""></script>
ab HTMLC <html><CR><head><CR></head><CR><body><CR></body><CR></html>
"set paste

" map
map <F3> :TlistToggle<CR>

"hi CursorLine  cterm=NONE   ctermbg=gray ctermfg=NONE
"hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE

set completeopt=longest,menu

" php 函数补全
function AddPHPFuncList()
    set dictionary-=~/.vim/tools/php/functions.txt  dictionary+=~/.vim/tools/php/functions.txt 
    set complete-=k complete+=k
endfunction
au FileType php call AddPHPFuncList()

" python api 补全
function AddPythonFuncList()
    set dictionary-=~/.vim/tools/python/complete-dict dictionary+=~/.vim/tools/python/complete-dict
    set complete-=k complete+=k
endfunction
au FileType python call AddPythonFuncList()

" css 属性补全
function AddCssAttrList()
    set dictionary-=~/.vim/tools/css/css.attr dictionary+=~/.vim/tools/css/css.attr
    set complete-=k complete+=k
endfunction
au FileType css call AddCssAttrList()

"colorscheme darkblue 

filetype on
filetype plugin on
filetype indent on

" 记住上次编辑的位置
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif

" 自定义文件模版
autocmd BufNewFile *.c 0r ~/.vim/template/cconfig.c
autocmd BufNewFile *.php 0r ~/.vim/template/phpconfig.php
autocmd BufNewFile *.sh 0r ~/.vim/template/shconfig.sh

" 高亮自定义
hi Comment ctermfg = blue

" 状态栏
"set laststatus=2      " 总是显示状态栏
"highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
"" 获取当前路径，将$HOME转化为~
"function! CurDir()
"    let curdir = substitute(getcwd(), $HOME, "~", "g")
"    return curdir
"endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\@\%{hostname()}
