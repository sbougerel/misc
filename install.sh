#!/bin/sh
if ! [ -f "./dot.emacs" ] || ! [ -d "./dot.emacs.d" ]
then
    >&2 echo "Are you running $0 in the right directory?"
    exit 1
fi
cp dot.emacs $HOME/.emacs
cp -a dot.emacs.d/* $HOME/.emacs.d/
