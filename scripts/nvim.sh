#!/usr/bin/env bash
#
# vim
#
# http://www.vim.org/
# vim editor
#
set -e

echo "NVim"

# check for vim
if test $(which nvim)
then
    echo "Creating links"
    # vimrc file
    ln -sfn ~/.dotfiles/configs/vim/vimrc ~/.config/nvim/init.vim

    # gvimrc file
    ln -sfn ~/.dotfiles/configs/vim/gvimrc ~/.gvimrc
   
    # colors
    ln -sfn ~/.dotfiles/configs/vim/colors ~/.vim 
    echo -e "Done\n"
else
    echo "NeoVim not installed"
fi
