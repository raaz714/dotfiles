#!/bin/sh

case "$1" in
    # *.pdf) pdftotext "$1" -;;
    *) batcat --paging=never --style=numbers --terminal-width $(($2-5)) -f "$1" || true;;
    #*) highlight -O ansi "$1" || true;;
esac
