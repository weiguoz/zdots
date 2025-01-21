#!/usr/bin/env bash

for i in {0..255} ; do
    printf "\x1b[38;5;%smcolour%s\n" "$i" "$i"
done
unset i

echo "\033[38;2;255;0;0mtrue color supported if red\033[0m"
