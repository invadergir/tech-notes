#!/bin/bash

set -ex
DIR=$HOME/.config/VSCodium/User
cp -vf "$DIR"/{keybindings.json,settings.json,tasks.json} .
set +x
echo Done.
