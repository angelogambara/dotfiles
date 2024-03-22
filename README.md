# Void Linux, Full Disk Encryption (Gummiboot)

## Preparations

### Wireless connection

```
> add_network
> set_network 0 ssid "NAME"
> set_network 0  psk "PASS"
> enable_network 0
> save_config
```

### Live image update

`SSL_NO_VERIFY_PEER=true`

```
# xbps-install -S xbps
# xbps-install -u
```

## Installation

### Partitioning the disk

`fdisk /dev/nvme0n1`

```
# cryptsetup luksFormat /dev/nvme0n1p2
# cryptsetup luksOpen   /dev/nvme0n1p2 voidvm
```

Pros of XFS over any other filesystem:

1. Larger Partition Size and File Size: up to 8 EiB on 64-bit systems or up to 16TiB on 32-bit systems.
2. Dynamically Allocated Inodes: never run out of inodes.
3. Allocation Groups: big performance gains, allowing for parallel I/O operations.
4. Metadata Journaling: recover pointers to data, in case of corruption.
5. The Unix Philosophy: doesn't include any of the following: snapshots, encryption, RAID or LVM.

Cons of XFS over true and tested Ext4:

1. Lacking Shrinking Tool: you can only grow a partition, which is very inconvenient.
2. Lacking Testdisk Support: you can only recover using Photorec, which is very slow.

```
# mkfs.fat -n BOOT /dev/nvme0n1p1
# mkfs.xfs -L VOID /dev/nvme0n1p2
```

### Mounting to /mnt

```
# mount /dev/mapper/voidvm /mnt
# mount /dev/nvme0n1p1  -m /mnt/boot
```

```
# for i in dev proc sys run
> do
> 	mkdir /mnt/$i
> 	mount --rbind   /$i /mnt/$i
> 	mount --make-rslave /mnt/$i
> done
```

### System bootstrap

Copy the wifi configuration and the xbps keys to their respective directories before you continue.

```
# for i /etc/wpa_supplicant /var/db/xbps/keys
> do
> 	mkdir -p /mnt/$i/
> 	cp /$i/* /mnt/$i/
> done
```

Select a combination of [mirror](https://docs.voidlinux.org/xbps/repositories/mirrors/index.html) and [repository](https://docs.voidlinux.org/xbps/repositories/index.html) based on your location, supported architecture and desired C library implementation.

```
# XBPS_REPO=https://repo-fastly.voidlinux.org/current
# XBPS_ARCH=x86_64 xbps-install -Sr /mnt -R $XBPS_REPO \
> 	base-system cryptsetup gummiboot neovim
```

### System configuration

```
# usermod -aG root wheel
# passwd root
# useradd -mG wheel user
# passwd user
# echo '%wheel ALL=(ALL) ALL' > /etc/sudoers
```

```
# ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
# hwclock --systohc
# echo "voidvm" > /etc/hostname
```

```
# echo 'nameserver 1.1.1.1' > /etc/resolv.conf
# chattr +i /etc/resolv.conf
```

```
# echo " LANG=en_US.UTF-8" > /etc/locale.conf
# echo "en_US.UTF-8 UTF-8" > /etc/default/libc-locales
# xbps-reconfigure -f glibc-locales
```

### Gummiboot configuration

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

### Enable system services

```
# xbps-install chrony cronie elogind polkit socklog
# for i in crond dbus dhcpcd elogind ntpd nanoklogd socklog-unix wpa_supplicant
> do
> 	ln -s /etc/sv/$i /var/service/
> done
```

### Enable periodical TRIM

```
# echo '#!bin/sh\nfstrim /' >> /etc/cron.monthly/fstrim
# chmod 755 /etc/cron.monthly/fstrim
```
