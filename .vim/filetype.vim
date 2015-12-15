" nginx 配置文件高亮地持
au BufRead,BufNewFile *.com,*.cc,site/*.com,vhost/*.com,servers/*.com set ft=nginx
au BufRead,BufNewFile ~/nginx/conf/* set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx

" Markdown
" @see: http://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
au BufRead,BufNewFile *.md set filetype=markdown
"au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown

" JSON 语法
au BufRead,BufNewFile *.json set filetype=json

" go 语法高亮
au BufRead,BufNewFile *.go set filetype=go

" rust 语法高亮
au BufRead,BufNewFile *.rs set filetype=rust

" rust 项目toml配置文件高亮
au BufRead,BufNewFile *.toml set filetype=toml
