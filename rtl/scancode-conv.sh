#!/bin/sh

input="mega65-scancode-hex.txt"
target="mega65_c16_keymatrix.v"
tmp=$(mktemp)

while IFS=" " read -r key val; do
    sed "s/^.*key_${key}<=pressed;$/${val}: key_${key}<=pressed;/" "$target" > "$tmp"
    mv "$tmp" "$target"
done < "$input"
