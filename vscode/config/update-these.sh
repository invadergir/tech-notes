#!/bin/bash

set -ex
DIR=$HOME/.config/VSCodium/User
cp -vf "$DIR"/{keybindings.json,settings.json} .
set +x
echo Done.
