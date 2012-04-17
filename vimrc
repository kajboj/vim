set history=1000

"Git
set statusline+=[%{GitBranch()}]

"turn off needless toolbar on gvim/mvim
set guioptions-=T

set foldmethod=indent   "fold based on indent
set foldnestmax=100
set nofoldenable        "dont fold by default

if has("gui_running")
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
else
  "dont load csapprox if there is no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1

  "set railscasts colorscheme when running vim in gnome terminal
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
    colorscheme railscasts2
  else
    colorscheme default
  endif

endif







set expandtab
set ts=2
set shiftwidth=2

set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

set nowrap

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

colorscheme kai

"set foldmethod=syntax

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

autocmd filetype * set list
autocmd filetype * set listchars=eol:$,tab:>-,trail:·,extends:>,precedes:<

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Line numbers
autocmd filetype * set number

nmap <C-n> :set invnumber<CR>

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=#555555 guibg=NONE


cd /Users/kajboj/shutl
