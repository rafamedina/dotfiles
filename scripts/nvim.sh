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
    ln -sfn ~/.dotfiles/configs/vim/init.vim ~/.config/nvim/init.vim

    echo "Downloading Plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Finished"
else
    echo "NeoVim not installed"
fi
