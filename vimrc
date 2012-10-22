call pathogen#infect()
call pathogen#runtime_append_all_bundles()

set history=1000

"Git
set statusline+=[%{GitBranch()}]

"turn off needless toolbar on gvim/mvim
set guioptions-=T

set foldmethod=syntax
set foldnestmax=100
set nofoldenable        "dont fold by default

function! s:guiSetup()
  "tell the term has 256 colors
  set t_Co=256

  colorscheme railscasts2
  set guitablabel=%M%t

  if has("gui_gnome")
    set term=gnome-256color
    colorscheme railscasts
    set guifont=Monospace\ Bold\ 9
  endif

  if has("gui_mac") || has("gui_macvim")
    set guifont="Bitstream Vera Sans Mono"
  endif

  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas
    set enc=utf-8
  endif
  
  " removes scrollbar
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L

  " yanking to system wide clipboard
  set guioptions+=a
  set guioptions+=A

  " console dialogs instead of popups
  set guioptions+=c
endfunction

function! s:nonGuiSetup()
  "dont load csapprox if there is no gui support - silences an annoying warning
  "let g:CSApprox_loaded = 1

  set t_Co=256
  "set t_AB=[48;5;%dm
  "set t_AF=[38;5;%dm

  colorscheme Tomorrow-Night
endfunction

if has("gui_running")
  call s:guiSetup()
else
  call s:nonGuiSetup()
endif

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nmap _s :call <SID>StripTrailingWhitespaces()<CR>

set expandtab
set ts=2
set shiftwidth=2
set softtabstop=2
set autoindent

set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

set nowrap

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set timeoutlen=500
set ignorecase
"set incsearch
"set hlsearch

"set grepprg=grep\ -nriH\ --exclude=tmp\ --exclude=.git\ --exclude=*.swp\ --exclude=*.log\ $*\ /dev/null

" ack does not seem to work correctly with settings below. investigate
set grepprg=ack\ --ignore-dir=doc\ $*\ /dev/null

" Remapping of window navigation commands as they are used a lot
" and constant pressing <C-w> puts a lot of stress on hands

" Split vertical
map <F3> <C-w>v<C-w>k
" Split horizontal
map <F4> <C-w>s<C-w>j
" Open scratch file
map <F8> :e ~/tmp/scratch<Return>
" Close window
map <C-c> <C-w>c
" Moving between windows
map <C-S-j> <C-w>j
map <C-S-h> <C-w>h
map <C-S-k> <C-w>k
map <C-S-l> <C-w>l

" Open spec in split window on the left
map <C-s> <C-w>v:A<Return>

" Resizing windows
map <PageDown> <C-w>40<lt>
map <PageUp> <C-w>40>
map <Home> <C-w>20+
map <End> <C-w>20-

map <F5> :w<Enter>

" Wrapping selected text in #{} (ruby string interpolation)
vmap _si s}i#<ESC>l%l

" Changing " to '
map _q cs"'

" Changing old ruby hash syntax to the new one
vmap _fh :s/\v:([a-z_0-9]+)\ *\=\>\ */\1: /c<Return>

"enable copying formatted text from within vim as HTML
vmap _yh :TOhtml<CR>:sav! temp.html<CR>:bd<CR>:!open temp.html<CR><CR>:sleep 1<CR>:!rm temp.html<CR><CR>:e %<CR>

" set virtualedit=block

" Line numbers
autocmd filetype * set number

nmap <C-n> :set invnumber<CR>
nmap _e :e <C-r>%<C-f>dT/a

map ,c<Space> \cc
let mapleader=","

highlight LineNr term=bold cterm=NONE ctermfg=236 ctermbg=NONE gui=NONE guifg=#555555 guibg=NONE

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,rabl} set ft=ruby
au BufNewFile,BufRead *.json                                            set ft=javascript
au BufNewFile,BufRead *.js                                              set ft=javascript syntax=jquery
au BufRead,BufNewFile jquery.*.js                                       set ft=javascript syntax=jquery
au BufNewFile,BufRead {*.hamlbars,*.hbs,*.hamlc}                        set ft=haml
au BufNewFile,BufRead {*.handlebars}                                    set ft=html
au BufNewFile,BufRead {*.lhs,*.hs}                                      set ft=haskell syntax=haskell
au BufNewFile,BufReadPost *.coffee                                      setl shiftwidth=2 expandtab foldmethod=indent nofoldenable
au BufNewFile,BufRead *.coffee                                          set ft=coffee syntax=coffee

let g:slime_target = "tmux"

set list listchars=tab:>-,trail:·,extends:>,precedes:<

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,rabl} set list
au BufNewFile,BufRead *.json                                                 set list
au BufNewFile,BufRead *.js                                                   set list
au BufRead,BufNewFile jquery.*.js                                            set list
au BufNewFile,BufRead {*.hamlbars,*.hbs,*.hamlc}                             set list
au BufNewFile,BufRead {*.handlebars}                                         set list
au BufNewFile,BufRead {*.lhs,*.hs}                                           set list
au BufNewFile,BufReadPost *.coffee                                           set list
au BufNewFile,BufRead *.coffee                                               set list

set backupdir=/tmp
set directory=/tmp

cd ~/shutl

nmap _t} /dodwi{ $ciw}0

set clipboard=unnamed
