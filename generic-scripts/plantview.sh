#!/bin/bash

set -u # no uninitialized var usage.
ARGS_ARRAY=("${@}")
NUM_ARGS=${#ARGS_ARRAY[@]}
THISDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))
THISPROG=$(basename $(readlink -e ${BASH_SOURCE[0]}))

usageText="
SYNTAX:  $THISPROG  [options]  inputFile

Generate a PNG from plantuml and then view it.

EXAMPLES:  

    $THISPROG  my-diagram.txt
"

Syntax()
{
    set +x
    echo "$usageText"
    exit 101
}

err()
{
    set +x
    set +u
    >&2 echo
    >&2 echo "ERROR - $1"
    >&2 echo
    >&2 echo "Type '$THISPROG -h' for help."
    >&2 echo
    local CODE="$2"
    [ -z "$CODE" ] && CODE=1
    exit $CODE
}

# Parse the arguments.
inputFile=""
for (( ix = 0; ix < ${NUM_ARGS}; ix++ )); do
    arg="${ARGS_ARRAY[${ix}]}"
    if [[ $arg = "-h" || $arg = "--help" ]]; then
        Syntax
#     elif [[ $arg = "-f" || $arg = "--force" ]]; then
#         force=true
#     elif [[ $arg = "-d" || $arg = "--destination-dir" ]]; then
#         ((++ix))
#         nextarg="${ARGS_ARRAY[${ix}]}"
#         [[ -n "$nextarg" && "${nextarg:0:1}" != "-" ]] || err "expected an argument after $arg."
#         destDir="$nextarg"
    else # a regular param
        if [[ -z $inputFile ]]; then
            inputFile=$arg
        else
            err "unexpected argument:  $arg"
        fi
    fi
done

# Validate args:
[[ $inputFile ]] || err "The inputFile was not specified."

# Go 
outFile=${inputFile%%.txt}.png
[[ $outFile = $inputFile ]] && err "We expected a TXT file."

set -x
plantuml $inputFile || err "couldn't render input file: $inputFile"
exo-open $outFile &


