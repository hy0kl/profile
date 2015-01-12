" nginx 配置文件高亮地持
au BufRead,BufNewFile ~/nginx/conf/* set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile *.cc,*.com set ft=nginx

" Markdown
" @see: http://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
au BufRead,BufNewFile *.md set filetype=markdown
"au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown

" JSON 语法
au BufRead,BufNewFile *.json set filetype=json
