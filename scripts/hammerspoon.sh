#/usr/bin/env bash
#
# Hammerspoon
#
#

set -e

echo "Hammerspoon"

os=`uname`
    if [[ $os == "Darwin" ]]; then

    # downloading 
    echo "Installing"
    
    brew install hammerspoon --cask

    echo "Creating links"
    # slate file
    ln -s ~/.dotfiles/configs/hammerspoon ~/.hammerspoon

    echo "Done"
else
    echo -e "OS not Supported\n"
fi
