let s:reg = '*'

let s:prefixes = {
      \"fast_specs.*_spec.rb" : "rspec -Ifast_specs",
      \"fast_specs.*feature"  : "rspec -Ifast_specs",
      \"spec.*_spec.rb"       : "be rspec",
      \"spec.*feature"        : "be rspec"}
      \"features.*feature"    : "be cucumber"}

function! s:Prefix()
  let s:filename = expand("%")
  for s:p in keys(s:prefixes)
    if s:filename =~ s:p
      return get(s:prefixes, s:p) . " "
    endif
  endfor
  return ""
endfunction

function! YankWithPrefix()
  call setreg(s:reg, s:Prefix() . expand("%"))
endfunction

function! YankWithPrefixAndLineNumber()
  call setreg(s:reg, s:Prefix() . expand("%") . ":" . line("."))
endfunction

map _ys :call YankWithPrefix()<CR>
map _yS :call YankWithPrefixAndLineNumber()<CR>
