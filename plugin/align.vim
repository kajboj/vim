"function! AlignVertically()
  "let sep = getreg('*')
  "echo s:MaxColumn(sep)
"endfunction

"function! s:MaxColumn(sep)
  "let s:max    = 0
  "let s:lnum   = line('.')
  "let s:column = s:Column(a:sep)

  "while s:column != -1
    "let s:lnum = s:lnum + 1
    "let s:column = s:Column(a:sep)
  "endwhile

  "return s:col
"endfunction

"function! s:Column(sep, lnum)
  "let s:line = getline(a:lnum) 
  "return match(s:line, a:sep)
"endfunction

"call AlignVertically()

