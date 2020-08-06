#!/usr/bin/env bash
#
# prelude 
#
#
set -e

echo "Prelude"

# check for vim
if test $(which emacs)
then

    # downloading 
    wget --no-check-certificate https://github.com/bbatsov/prelude/raw/master/utils/installer.sh -O - | sh

    echo "Creating links"
    # vimrc file
    ln -sfn ~/.dotfiles/configs/prelude/custom.el ~/.emacs.d/personal/custom.el
    ln -sfn ~/.dotfiles/configs/prelude/prelude-modules.el ~/.emacs.d/personal/prelude-modules.el
    ln -sfn ~/.dotfiles/configs/prelude/+binding.el ~/.emacs.d/personal/+binding.el

else
    echo "spacemacs not installed"
fi
