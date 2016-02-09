set nocompatible              " be iMproved, required
filetype off                  " required

set autoindent
set autoread
set cursorline
set expandtab
set hidden
set number
set shiftwidth=2
set smarttab
set tabstop=2
set wildmenu

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-rails'
Plugin 'skwp/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'roman/golden-ratio'

call vundle#end()            " required
filetype plugin indent on    " requiredfiletype plugin indent on

colorscheme Tomorrow-Night-Eighties

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

" map leader n to toggle nerd tree
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" map leader t to find the current file in nerdtree
noremap <leader>t :NERDTreeToggle<CR><c-w><c-p>:NERDTreeFind<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

let g:airline_powerline_fonts=1
let g:nerdtree_tabs_open_on_console_startup=1

" share a single NERDTree between buffers and tabs
 if argc() == 0
   autocmd VimEnter * NERDTree
   autocmd BufEnter * NERDTreeMirror
 end

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
