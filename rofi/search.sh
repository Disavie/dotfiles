#!/bin/sh
# Search engine: google or duckduckgo
engine="duckduckgo"
input="$1"
[ -z "$input" ] && exit 0

# Explicit URL
case "$input" in
    http://*|https://*)
        exec xdg-open "$input"
        ;;
    www.*|*.com)
        exec xdg-open "https://$input"
        ;;
esac

# Bare domain
case "$input" in
    *.*)
        case "$input" in
            *" "*) ;;
            *)
                exec xdg-open "https://$input"
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
exec xdg-open "$url"
