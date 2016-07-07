syntax on

" 解决 vim 无法使用退格键删除
set nocompatible
set backspace=indent,eol,start

set number
set autoindent
"set smartindent
set expandtab
set ts=4
set shiftwidth=4
" 高亮当前行
set cursorline
"hi cursorline   cterm=NONE ctermbg=lightgray ctermfg=NONE
hi cursorline   cterm=NONE ctermbg=234 ctermfg=NONE
" 保存文件时不要生成备份文件
set nobackup
" just for encode
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8
" 高亮搜索词
set hlsearch
set incsearch
" set foldmethod
set fdm=indent
"set completeopt=longest

" 设置粘贴模式
"set paste

" 显示当前行,总行数
set ruler
set rulerformat=%25(%5l,%-6(%c%V%)\ %5*%L\ %P%)%*


" map tags list
map <F3> :TlistToggle<CR>

"hi CursorLine  cterm=NONE   ctermbg=gray ctermfg=NONE
"hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE

" 自动补全菜单控制
set completeopt=longest,menu

" 打开文件时检测文件类型,自动匹配
filetype on
filetype plugin on
filetype indent on

" 和 neocomplcache_omni 不冲突,可以共存
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

" js 函数自动补全
function AddJsFuncList()
    set dictionary-=~/.vim/tools/js/javascript.dict dictionary+=~/.vim/tools/js/javascript.dict
    set complete-=k complete+=k
endfunction
autocmd FileType javascript call AddJsFuncList()

" sql 关键词补全
function AddSqlKeyword()
    set dictionary-=~/.vim/tools/sql.dict dictionary+=~/.vim/tools/sql.dict
    set complete-=k complete+=k
endfunction
autocmd FileType sql call AddSqlKeyword()

"colorscheme darkblue

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
hi Comment ctermfg=blue

" 状态栏
"set laststatus=2      " 总是显示状态栏
"highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

"" 获取当前路径，将$HOME转化为~
"function! CurDir()
"    let curdir = substitute(getcwd(), $HOME, "~", "g")
"    return curdir
"endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\@\%{hostname()}

" 设置自动补全弹出层背景色为粉红
highlight Pmenu ctermbg=magenta

" 实现 show print margin 的方法
"set colorcolumn=80
"hi ColorColumn ctermbg=lightgrey guibg=lightgrey

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"仅检测PHP语法
autocmd FileType php map <F2> :!~/php/bin/php -l %<cr>

" 友好注释助手
let g:DoxygenToolkit_paramTag_pre="@param: "
let g:DoxygenToolkit_returnTag   ="@return: "
let g:DoxygenToolkit_authorName="hy0kle@gmail.com"
let g:DoxygenToolkit_licenseTag="\<enter>Copyright (C) Technology LimitedCompany"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

"自定义快捷键
vmap <C-S-P>    dO#endif<Esc>PO#if 0<Esc>
" 函数注释
map <F4> <Esc>:Dox<cr>
" 文件版权声明
map <F5> <Esc>:DoxAuthor<cr>
" Copyright
map <F6> <Esc>:DoxLic<cr>

" vim tabs conf
map <F7> :tabp <CR>
map <F8> :tabn <CR>
" 改变浏览的启动目录
set browsedir=current

" 分割窗口时保持相等的宽/高
set equalalways

" The NERD tree : A tree explorer plugin for navigating the filesystem
map <F9> :NERDTreeToggle<CR>
imap <F9> <ESC>:NERDTreeToggle<CR>
"启动Vim时自动打开nerdtree
"autocmd VimEnter * NERDTree
let NERDTreeIgnore=['^cscope', '^tags$']

" 通过C-X,C-U打开匹配列表
"let g:SuerTabDefaultCompletionType = '<C-X><C-U>'
