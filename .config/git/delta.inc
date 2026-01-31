# vim: ft=gitconfig

[core]
	pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
	# Use n and N to move between diff sections.
    navigate = true

    # The custom base 16 theme from bat.
    syntax-theme = "Catppuccin Macchiato"

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
