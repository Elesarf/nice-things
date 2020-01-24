#! /bin/bash

sudo apt install -y vim git

git clone https://github.com/VundleVim.vim ~/.vim/bundle/Vundle.vim
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
git clone https://github.com/SirVer/utilsnips ~/.vim/bundle/utilsnips
git clone https://github.com/scrooloose/nerdtree ~/.vim/bundle/nerdtree
git clone https://github.com/xavierd/clang_complete ~/.vim/bundle/clang_complete
git clone https://github.com/szw/vim-tags ~/.vim/bundle/vim-tag


git clone https://github.com/junegunn/fzf /tmp/fzf
