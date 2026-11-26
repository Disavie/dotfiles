#!/bin/sh
engine="duckduckgo"
input="$1"

[ -z "$input" ] && exit 0

# Explicit URL
case "$input" in
    http://*|https://*)
        xdg-open "$input" >/dev/null 2>&1 &
        exit 0
        ;;
    www.*|*.com)
        xdg-open "https://$input" >/dev/null 2>&1 &
        exit 0
        ;;
esac

# Bare domain
case "$input" in
    *.*)
        case "$input" in
            *" "*) ;;
            *)
                xdg-open "https://$input" >/dev/null 2>&1 &
                exit 0
                ;;
        esac
        ;;
esac

# Encode search query
query=$(python3 -c 'import sys, urllib.parse; print(urllib.parse.quote_plus(sys.argv[1]))' "$input")

# Search engine
case "$engine" in
    google)
        url="https://www.google.com/search?q=$query"
        ;;
    duckduckgo)
        url="https://duckduckgo.com/?q=$query"
        ;;
    *)
        exit 1
        ;;
esac

xdg-open "$url" >/dev/null 2>&1 &
exit 0

