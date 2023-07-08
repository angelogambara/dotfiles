# Void Linux, Full Disk Encryption (Gummiboot)

## Preparations

### Wireless Connection

```
> add_network
> set_network 0 ssid "NAME"
> set_network 0  psk "PASS"
> enable_network 0
> save_config
```

### Live Image Update

`SSL_NO_VERIFY_PEER=true`

```
# xbps-install -S xbps
# xbps-install -u
```

## Installation

### Partition The Drive

`fdisk /dev/nvme0n1`

```
# cryptsetup luksFormat /dev/nvme0n1p2
# cryptsetup luksOpen   /dev/nvme0n1p2 voidvm
```

These are the reasons why I think XFS to be superior to Ext4 and its alternatives:

1. XFS protects your data from corruption because it's a modern journaling filesystem that supports checksum (CRC32.)
2. XFS supports larger limits when it comes to partition size and file size, up to 8 EiB on 64-bit systems.
3. XFS allocates your data into groups, where each group has its metadata and data part. it's faster because it's multi-threaded.
4. XFS dynamically allocates inodes for you, so you don't have to calculate anything before you format a partition.
5. XFS doesn't include extra features like snapshots, encryption, RAID or LVM functionality. It's predictable and easy to use.

If I had to name a few disadvantages that come with using XFS I would say:

1. Metadata operations are slower. This matters only when you create or delete a bunch of files at once.
2. Testdisk can't understand it out of the box, but you can still use Photorec to recover files (Although it's much slower.)

```
# mkfs.fat -n BOOT /dev/nvme0n1p1
# mkfs.xfs -L VOID /dev/nvme0n1p2
```

### Mount Everything To /mnt

```
# mount /dev/mapper/voidvm /mnt
# mount /dev/nvme0n1p1  -m /mnt/boot
```

Alternatively [`xchroot(1)`](https://man.voidlinux.org/xchroot.1) should take care of this after the bootstrap process, but I haven't tested it.

```
# for i in dev proc sys run
> do
> 	mkdir /mnt/$i
> 	mount --rbind   /$i /mnt/$i
> 	mount --make-rslave /mnt/$i
> done
```

### Bootstrap System To /mnt

Copy the wifi configuration and the xbps keys to their respective directories before you continue.

```
# for i /etc/wpa_supplicant /var/db/xbps/keys
> do
> 	mkdir -p /mnt/$i/
> 	cp /$i/* /mnt/$i/
> done
```

Select a combination of [mirror](https://docs.voidlinux.org/xbps/repositories/mirrors/index.html) and [repository](https://docs.voidlinux.org/xbps/repositories/index.html) depending on your closest region, your architecture and desired C library implementation. If you're installing from the appropriate live image, you can omit the architecture part altogether.

A simpler alternative is to use [`xvoidstrap(1)`](https://man.voidlinux.org/xvoidstrap.1) from the `xtools` package, although I haven't tested it.

```
# XBPS_REPO=https://repo-de.voidlinux.org/current
# XBPS_ARCH=x86_64 xbps-install -Sr /mnt -R $XBPS_REPO base-system cryptsetup gummiboot neovim
```

### Configure Everything Inside /mnt

I'm not sure if you have to explicitly do these steps yourself, but I'm including these anyway.

```
# chroot /mnt
# chown root:root /
# chmod 755 /
```

You can skip setting the root password and add your user to the `wheel` group directly. Generally, you'll never want to log in as root (Although there's a point to be made that if you mess up editing `/etc/sudoers` later on you'll have to fix it by booting the live image once again, so choose accordingly.)

```
# useradd -mG wheel user
# passwd user
# echo '%wheel ALL=(ALL) ALL' > /etc/sudoers
# echo "voidvm" > /etc/hostname
```

Adjust the clock to your timezone and send updates to your motherboard. The NTP deamon will take care of the rest later.

```
# ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
# hwclock --systohc
```

Set the default locale for glib systems. Just say American English, there's little point in changing this. Skip this if you chose musl instead.

```
# echo "LANG=en_US.UTF-8 " > /etc/locale.conf
# echo "en_US.UTF-8 UTF-8" > /etc/default/libc-locales
# xbps-reconfigure -f glibc-locales
```

Set the default resolver for DNS queries and prevent `dhcpcd` from overwriting it (Revert using `-i` flag.)

```
# echo 'nameserver 1.1.1.1' > /etc/resolv.conf
# chattr +i /etc/resolv.conf
```

### Instruct /mnt On How To Boot

Mind you, here I'm using `cat` simply because I can't show you `vim` on the command line, but you should definitely use that.

```
# cat > /etc/fstab << __EOF__
> /dev/mapper/void   /     xfs  defaults 0 0
> /dev/nvme0n1p1     /boot vfat defaults 0 0
> tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0
> __EOF__
```

```
# UUID=$(blkid -o value -s UUID /dev/nvme0n1p2)
# gummiboot install
# echo 'install_items+=" /etc/crypttab "' > /etc/dracut.conf.d/10-crypt.conf
# echo "voidvm  UUID=$UUID  none discard" > /etc/crypttab
# printf "rd.luks.allow-discards rd.luks.uuid=$UUID " >> /boot/loader/void-options.conf
# printf "root=/dev/mapper/voidvm quiet loglevel=3\n" >> /boot/loader/void-options.conf
# xbps-reconfigure -fa
```

## Post-Install

### Enable System Services

```
# xbps-install chrony cronie elogind polkit socklog
# for i in crond dbus dhcpcd elogind ntpd nanoklogd socklog-unix wpa_supplicant
> do
> 	ln -s /etc/sv/$i /var/service/
> done
```

### Enable Periodical TRIM

```
# echo '#!bin/sh\nfstrim /' >> /etc/cron.monthly/fstrim
# chmod 755 /etc/cron.weekly/fstrim
```
