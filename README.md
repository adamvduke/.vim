# Installation

```bash
cd ~/
git clone https://github.com/adamvduke/.vim.git ~/.vim
mkdir -p ~/.vim/autoload && curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/autoload ~/.config/nvim/autoload
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
```

Start vim

```vim
:PlugInstall
:so ~/.vim/vimrc
```

Download and install a powerline font: https://github.com/powerline/fonts
