#!/bin/bash

set -ex
codiumDIR=$HOME/.config/VSCodium/User
vscodeDIR=$HOME/.config/Code/User

cp -vf "$codiumDIR"/{keybindings.json,settings.json,tasks.json} vscodium/
cp -vf "$vscodeDIR"/{keybindings.json,settings.json,tasks.json} vscode/
set +x
echo Done.
