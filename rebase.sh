#!/bin/sh
if ! [ -f "./dot.emacs" ] || ! [ -d "./dot.emacs.d" ]
then
    >&2 echo "Are you running $0 in the right directory?"
    exit 1
fi
cp $HOME/.emacs dot.emacs
rm -rf dot.emacs.d/*
cp -a $HOME/.emacs.d/* dot.emacs.d/*
rm -f dot.emacs.d/.emacs.desktop
rm -f dot.emacs.d/.emacs.desktop.lock
