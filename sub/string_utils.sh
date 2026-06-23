#!/usr/bin/env bash

# String conversion utilities
#
# A few design notes:
#
# `:` -> `-` rather than `_`, because a hyphen reads more naturally in a
# filename where a colon was used as a separator, e.g.,
# "Title: Subtitle" -> "Title-_Subtitle".  It is possible to swap it to
# `_` if it is preferred for uniformity.
#
# `/` -> `-` for the same readability reason; it often appears in version
# strings like `2024/03`.
#
# The minor-word list (a, an, the, and, but, or, nor, for, so, yet, at, by,
# in, of, on, to, up, as) follows standard English title-case rules---first
# and last words are always capitalised regardless.
#
# Both functions are pure `sed` + `awk`, with no external dependencies, so
# they work identically on macOS and Linux.

# Converts a string to a safe filename for macOS and Linux.
#
# Replacements:
#   - Colon (:)                     -> hyphen  (forbidden in macOS/APFS)
#   - Slash (/)                     -> hyphen  (forbidden in both as path separator)
#   - Backslash (\)                 -> hyphen
#   - Shell/glob special chars      -> underscore  (* ? " < > | ; & $ ! ` { } [ ] ( ))
#   - Whitespace                    -> underscore
#   - Leading dots/hyphens stripped (hidden files / broken paths)
to_filename() {
    local input="$1"
    echo "$input" \
        | sed 's|[:/\\]|-|g' \
        | sed 's|[*?"<>|;&$!`{}()\[\]]|_|g' \
        | sed 's|[[:space:]]|_|g' \
        | sed 's|^[.\-]*||'
}

# Converts a string to a properly title-cased document title.
#
# - Underscores and hyphens are replaced with spaces
# - Every word is capitalised, except minor words (articles, short prepositions,
#   conjunctions) when they appear in the middle of the title
to_title() {
    local input="$1"
    echo "$input" \
        | sed 's/[_-]/ /g' \
        | awk '{
            split("a an the and but or nor for so yet at by in of on to up as", _s)
            delete _small
            for (i in _s) _small[_s[i]] = 1

            n = split($0, words, " ")
            result = ""
            for (i = 1; i <= n; i++) {
                w = tolower(words[i])
                if (w == "") continue
                if (i == 1 || i == n || !(w in _small))
                    w = toupper(substr(w, 1, 1)) substr(w, 2)
                result = (result == "") ? w : result " " w
            }
            print result
        }'
}

# Replace characters which are not allowed in unix filesystems to
# filesystem-friendly characters in a string
sanitize() {
  local input="$1"
  local result

  result="$input"

  # Convert to lowercase
  result=$(echo "$result" | tr '[:upper:]' '[:lower:]')

  # Replace spaces with dashes
  result="${result// /-}"

  # Replace common problematic characters with dashes
  result="${result//[\/\\:*?\"<>|]/-}"

  # Remove characters that are not alphanumeric, dash, dot, or underscore
  result="${result//[^a-zA-Z0-9._-]/}"

  # Collapse multiple consecutive dashes into one
  result=$(echo "$result" | sed 's/-\{2,\}/-/g')

  # Strip leading and trailing dashes/dots
  result=$(echo "$result" | sed 's/^[-.]*//;s/[-.]*$//')

  echo "$result"
}
