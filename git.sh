#!/bin/bash

set -e
set -u
cd $(dirname $0)
exclude=0
action="none"

while [ $# -gt 0 ]; do
    case $1 in
    status|push|pull|diff) action=$1; shift;;
    -x) exclude=1; shift;;
    *) echo "bad argument '$1'"; exit 1;;
    esac
done
if [ $action == "none" ]; then
    echo "Usage: $0 [-x] status|push|pull|diff"
    exit 1
fi

#for i in $( find -maxdepth 1 -type d | grep -v '^\.$' | grep -v 'examen' ); do
for i in $( find -maxdepth 1 -type d | grep -v '^\.$' ); do
    if [ $exclude -eq 1 ]; then
        if echo $i | grep ozt-dbperf >/dev/null; then
            echo ====== skipping $i =====
            continue
        fi
    fi
    echo
    echo ========== $i =============
    cd $i
    set +e
    if [ "$action" = "diff" ]; then
        git $action | cat
    else
        git $action | grep -v -e "Your branch is up to date with 'origin/master'." -e "nothing to commit, working tree clean"
    fi
    set -e
    cd ..
done
