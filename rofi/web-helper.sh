#!/bin/sh

input="$1"

[ -z "$input" ] && exit 0

# Explicit URL
# Explicit URL or .com domain
case "$input" in
    http://*|https://*)
        exec xdg-open "$input"
        ;;
    www.*|*.com)
        exec xdg-open "https://$input"
        ;;
esac
# Bare domain, such as example.com
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

# If the first word is an executable, run it normally
first_word=${input%% *}
if command -v "$first_word" >/dev/null 2>&1; then
    exec sh -c "$input"
fi

# Otherwise, search Google
query=$(python3 -c 'import sys, urllib.parse; print(urllib.parse.quote_plus(sys.argv[1]))' "$input")
exec xdg-open "https://www.google.com/search?q=$query"
