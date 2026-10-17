# DOTFILES

## ToC

Coming soon...

## Tree View

```txt
dotfiles
├── .config
│   ├── alacritty               Delete
│   ├── bat                     Add                     Theme-dependent
│   ├── borg                    Add
│   ├── dunst                   Add                     Theme-dependent
│   ├── dwl                     Add
│   ├── fontconfig              Add
│   ├── gallery-dl              Exclude
│   ├── git                     Add
│   ├── gtk-3.0                 Add
│   ├── kritadisplayrc          Add - personal
│   ├── kritarc                 Add - personal
│   ├── kritashortcutsrc        Add - personal
│   ├── mimeapps.list           Add
│   ├── mpv                     Add
│   ├── mutt                    Add wip
│   ├── newsboat                Add
│   ├── npm                     Add
│   ├── nvim                    Add separately
│   ├── picom.conf              Add
│   ├── sxiv                    Add wip
│   ├── systemd                 Add
│   ├── Thunar                  Add
│   ├── X11                     Add
│   ├── xdg-desktop-portal      Add
│   ├── yt-dlp                  Add
│   ├── zathura                 Add                     Theme-dependent
│   └── zsh                     Add separately
├── .gitignore
├── .gitmodules
├── .local
│   └── bin
├── .ssh
│   └── config
├── etc
│   ├── conf                    archlinux
│   ├── conf.d                  voidlinux               diff adopt
│   ├── cron.hourly             voidlinux
│   ├── cron.weekly             voidlinux
│   ├── default                 shared/split            diff/skip
│   ├── dracut.conf.d           voidlinux
│   ├── fail2ban                shared                  diff
│   ├── grub.d                  shared                  diff/skip
│   ├── makepkg.conf.d          archlinux
│   ├── modprobe.d              shared/split            diff
│   ├── pam.d                   shared/split            diff
│   ├── pkglist_arch.txt        archlinux exclusive
│   ├── pkglist_void.txt        voidlinux exclusive
│   ├── rc.local                voidlinux
│   ├── security                shared                  diff
│   ├── ssh                     shared                  diff
│   ├── sudoers.d               shared/split            diff
│   ├── sysctl.d                shared/split            diff
│   ├── systemd                 archlinux               diff/skip
│   ├── xbps.d                  voidlinux exclusive
│   ├── xdg                     archlinux               diff adopt
│   ├── zsh                     shared
│   └── zzz.d                   voidlinux
├── LICENSE
├── README.md
└── var
    └── service                 voidlinux               diff/skip
```

(Generated with `eza -T -L 2 --all --git-ignore`.)

## Installation

### DOTFILES

```bash
git clone --recurse-submodules https://codeberg.org/angelogambaradev/dotfiles
git checkout x11
```

```bash
stow .
```

### ETC

```bash
git clone --recurse-submodules https://codeberg.org/angelogambaradev/unix-configs
git checkout archlinux
```

```bash
stow --adopt etc/conf.d etc/xdg
stow .
```

## Fork

```bash
git clone --recurse-submodules https://codeberg.org/angelogambaradev/dotfiles
git remote update origin \<URL\>
```

## Contribute

```bash
git clone --recurse-submodules https://codeberg.org/angelogambaradev/dotfiles
git remote rename origin upstream
git remote add origin \<URL\>
git checkout -b feature/archlinux-feature archlinux
git push origin feature/archlinux-feature
```
