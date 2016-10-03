" ========================================================================
" vim-plug:
"
" mkdir -p ~/.vim/autoload && curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" ========================================================================
if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug 'bling/vim-airline'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'kchmck/vim-coffee-script'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

" ========================================================================
" Settings
" ========================================================================

" :help filetype
filetype plugin indent on

" :help <keyword>
set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=~/.vim/_backup/
set directory=~/.vim/_temp/
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch

" order is important for the list/listchars settings
set list
set listchars=""
set listchars=tab:\ \
set listchars+=extends:>
set listchars+=precedes:<
set listchars+=trail:.

set nobackup
set nocompatible
set noerrorbells
set noswapfile
set nowrap
set nowritebackup
set number
set ruler
set shiftwidth=2
set smartcase
set smarttab
set splitright
set tabstop=2
set undodir=~/.vimundo/
set undofile
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.swp,*~,._*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildmenu

" ========================================================================
" Mappings
" ========================================================================

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

" map leader st to strip trailing whitespace and newlines at the end of a file
map <Leader>st :call <SID>CleanFile()<CR>

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"

" map leader n to toggle nerd tree
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" map leader t to find the current file in nerdtree
noremap <leader>t :NERDTreeToggle<CR><c-w><c-p>:NERDTreeFind<CR>

" map leader f to fzf
noremap <leader>f :FZF<cr>

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nmap <leader>fef ggVG=

" Next buffer
nmap <silent> ,. :bnext<CR>

" Previous buffer
nmap <silent> ,m :bprev<CR>

" Next tab
nmap <silent> ;' :tabnext<CR>
nmap <silent> ;l :tabprev<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif

" ========================================================================
" Colors/Fonts
" ========================================================================

syntax enable
syntax on
colorscheme Tomorrow-Night-Eighties
let g:airline_powerline_fonts=1

" ========================================================================
" Behavior
" ========================================================================

if exists("g:enable_mvim_shift_arrow")
  " mvim shift-arrow-keys
  let macvim_hig_shift_movement = 1
endif

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " treat json as javascript ?
  au BufNewFile,BufRead *.json set ft=javascript

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " remove trailing whitespace on save
  autocmd BufWritePre {*.txt,*.md,*.erb,*.rb,*.js,*.coffee,*.scss,*.haml,*.py,*.js,*.clj,*.php,*.yml} :call <SID>CleanFile()

  " close NERDTree if it's the last window open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

" ========================================================================
" NERDTree
" ========================================================================
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.DS_Store', '\.git[[dir]]']

" share a single NERDTree between buffers and tabs
 if argc() == 0
   autocmd VimEnter * NERDTree
   autocmd BufEnter * NERDTreeMirror
 end

" ========================================================================
" Functions
" ========================================================================
" Strips trailing whitespace and newlines and remembers cursor position
function! <SID>CleanFile()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let [l,c] = [line("."),col(".")]

    " Do the business:
    " %!git strip space
    silent! %s/\s\+$//e
    silent! %s#\($\n\s*\)\+\%$##

    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
