#!/bin/bash

set -x
linkName="$1"
[[ ! $linkName ]] && echo "Error - must provide a link name to reverse." && exit 1

oldLink=$linkName
oldTarget=$(basename $(readlink $oldLink) )
newLink=$oldTarget
newTarget=$oldLink

set -e
oldddLinkName=$oldLink.olddddddddddddddddd
mv "$oldLink" "$oldddLinkName"
mv "$oldTarget" "$oldLink"
ln -s "$newTarget" "$newLink"
rm -f "$oldddLinkName"
set +x
echo
echo Done:
ls -l -d --color "$oldLink" "$oldTarget"
