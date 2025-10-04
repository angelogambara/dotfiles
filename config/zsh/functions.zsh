# ==============================
# Functions
# ==============================

# export krita documents
kra2png() {
  krita "$1" --export --export-filename "${1%.kra}".png
}

kra2png_for() {
  for  k in "$@"; do
    kra2png "$k"
  done
}
