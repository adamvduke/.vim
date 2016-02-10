" ========================================================================
" Much plugin, such features
" mkdir -p ~/.vim/autoload
" curl -fLo ~/.vim/autoload/plug.vim \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
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
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'kchmck/vim-coffee-script'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'roman/golden-ratio'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'skwp/vim-rspec'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

call plug#end()

filetype plugin indent on    " requiredfiletype plugin indent on
set nocompatible              " be iMproved, required
filetype off                  " required

set autoindent
set autoread
set expandtab
set hidden
set number
set shiftwidth=2
set smarttab
set tabstop=2
set wildmenu

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

noremap <leader>f :FZF<cr>

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
