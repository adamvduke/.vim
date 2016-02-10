# Installation

```bash
cd ~/
git clone https://github.com/adamvduke/.vim.git ~/.vim
mkdir -p ~/.vim/autoload && curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Start vim

```vim
:PlugInstall
:so ~/.vim/vimrc
```

Download and install a powerline font: https://github.com/powerline/fonts
