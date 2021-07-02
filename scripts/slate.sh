#/usr/bin/env bash
#
# Slate 
#
#
set -e

echo "Slate"

# downloading 
echo "Downloading"
cd /Applications && curl http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz | tar -xz

echo "Creating links"
# slate file
ln -sfn ~/.dotfiles/configs/slaterc ~/.slate

echo "Done"
