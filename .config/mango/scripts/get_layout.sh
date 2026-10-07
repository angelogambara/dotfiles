#!/bin/sh

# Single jq call handles filtering, layout extraction, and conditional formatting
output="$(mmsg get all-tags | jq -r '
  [.all_tags[0].tags[] | select(.is_active == true)] as $active
  | ($active[0].layout // empty) as $layout
  | if $layout == "M" then
      "[\($active | map(.client_count) | add // 0)]"
    else
      $layout
    fi
')"

# Modify separator directly if needed
echo "$output | $(mmsg get focused-client | jq -r '.title')"

# ==============================================================================
# EXPLANATION: How Does the Command Work?
# ==============================================================================
#
# Let's first take look at the unoptimized version: 
#   1. We want the active tag(s), and from there extract the layout. The
#   command is like this:
#
#   active_tags="$(mmsg get all-tags | jq '
#     .all_tags[0].tags[]
#     | select(.is_active == true)')"
#
#   echo "$active_tags" | jq -r '.[0].layout'
#
#  2. If the layout is the monocle one, we want to display the number of
#  clients stacked. To achieve that, we call jq again:
#
#  case "$layout" in
#  # Monocle
#  'M')
#    # Double quotes mean "print" and parenthesis restore the interpreter
#    echo "$active_tags" | jq -r '"[\(.client_count)]"'
#  ;;
#  # Tiled
#  'T')
#    # Classic tiled symbol
#    echo '[]='
#  ;;
#  # Reversed Tile
#  'RT')
#    # Classic reversed tiled symbol
#    echo '=[]'
#  ;;
#  esac
