#!/usr/bin/env bash
#
# Nixos 
#
# Nix Operative System 
#
set -e

echo "Nixos"

    
echo "Creating links"
# Nix files
ln -sfn ~/.dotfiles/nixos/configs /etc/nixos/configs
ln -sfn ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix

echo -e "Done\n"
