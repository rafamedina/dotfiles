#!/usr/bin/env bash
#
# Git
#
# http://git-scm.com/
# Distributed version control system 
#
set -e

echo "Git"

# check for git
if test $(which git)
then
    echo "Setting git configs"

    # Git settings
    git config --global user.name "Rafael Medina"
    git config --global user.email rafaelmedina789@gmail.com
    git config --global color.ui true
    git config --global core.editor "vim"
    git config --global mergetool.keepBackup false

    echo -e "Done\n"
else
    echo "Git not installed"
fi
