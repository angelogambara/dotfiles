# ==============================
# Key Bindings
# ==============================

typeset -g -A key     # create global associative array
local name tag widget # set a few local variables

# associate each key with the appropriate zle widget
for name tag widget in \
  Insert    kich1  overwrite-mode \
  Delete    kdch1     delete-char \
  Home      khome  beginning-of-line \
  End       kend         end-of-line \
  PageUp    kpp    beginning-of-buffer-or-history \
  PageDown  knp          end-of-buffer-or-history \
  Up        kcuu1    history-substring-search-up \
  Down      kcud1  history-substring-search-down \
  Left      kcub1  backward-char \
  Right     kcuf1   forward-char \
  Control-Left  kLFT5 backward-word \
  Control-Right kRIT5  forward-word \
  Shift-Tab kcbt   reverse-menu-complete
do
  key[$name]=${terminfo[$tag]}
  [[ -n ${key[$name]} ]] && bindkey -- "${key[$name]}" "$widget"
done

# force terminal in "application mode" when zle is active
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  zle_application_mode_start() { echoti smkx }
  zle_application_mode_stop() { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
