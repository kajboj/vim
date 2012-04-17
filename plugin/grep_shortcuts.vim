" word under cursor
let s:wuc = "\<C-r>\<C-w>"
" register 0
let s:r0 = "\<C-r>0"

let s:locations = {
      \"a": "app", 
      \"m": "app/models", 
      \"v": "app/views", 
      \"c": "app/controllers", 
      \"h": "app/helpers", 
      \"l": "lib", 
      \"s": "spec", 
      \"f": "features", 
      \"d": "features/step_definitions", 
      \".": "."}
let s:defaultLocation = s:locations["."]

let s:types = {
      \"d": "def ", 
      \"W": "def " . s:wuc, 
      \"w": s:wuc, 
      \"r": "\<C-r>0", 
      \"R": "def " . s:r0, 
      \"e": ""}
let s:defaultType = s:types["e"]

function! GetOneChar(prompt) 
  echon a:prompt . " "
  return nr2char(getchar())
endfunction

function! PickFromDict(prompt, dict, default)
  let s:char = GetOneChar(a:prompt . " " . join(sort(keys(a:dict))))
  echon "(" . s:char . ") "
  return get(a:dict, s:char, a:default)
endfunction

function! MyGrep()
  let what = PickFromDict("What?", s:types, s:defaultType)
  let where = PickFromDict("Where?", s:locations, s:defaultLocation)
  call feedkeys(":gr \"\" " . where . "\<C-b>\<Right>\<Right>\<Right>\<Right>" . what)
endfunction 

map _g :call MyGrep()<CR>
