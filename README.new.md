# Full Disk Encryption - Void Linux Handbook

# Connettività

NB: Se stai facendo un dual-boot con Windows 10 già installato e la tua scheda WiFi non ti viene riconosciuta, riavvia Windows 10 una volta e il problema dovrebbe risolversi da solo.

Esegui il comando `ip link` e controlla se il kernel riconosce la tua scheda WiFi. Se tutto va bene ti verrà mostrato il nome di un'interfaccia WiFi: la mia è riconosciuta come `wlp2s0`. Configura il servizio `wpa_supplicant` come segue:

```
# wpa_cli -i wlp2s0 add_network
# wpa_cli -i wlp2s0 set_network 0 ssid <input>
# wpa_cli -i wlp2s0 set_network 0  psk <input>
# wpa_cli -i wlp2s0 enable_network 0
```

Se riscontri problemi fai riferimento alla sezione #troubleshooting.

## Crittografia LVM on LUKS

Crittografa la seconda partizione appena creata con una passphrase, quindi decifrala e dagli un identificativo.

```
# cryptsetup luksFormat /dev/nvme0n1p2
Enter passphrase: Veify passphrase:
# cryptsetup luksOpen /dev/nvme0n1p2 voidvm
Enter passphrase:
```

Inizializza un volume fisico e un gruppo per gestire le partizioni logiche che andrai a creare sotto la partizione decifrata.

```
# pvcreate /dev/mapper/voidvm
  Physical volume "/dev/mapper/voidvm" successfully created
# vgcreate voidvm  /dev/mapper/voidvm
  Volume group "voidvm" successfully created
```

Crea i volumi logici contenenti dati sensibili/autentici e assegnagli delle etichette.

```
# lvcreate --name swap -L  8G voidvm
  Logical volume "swap" created.
# lvcreate --name root -L 40G voidvm
  Logical volume "root" created.
# lvcreate --name home -l 100%FREE voidvm
  Logical volume "home" created.
```

## File system e montaggio

Decidi un file system per organizzare lo spazio sui vari volumi logici.

```
# mkswap    -L SWAP /dev/voidvm/swap
# mkfs.ext4 -L ROOT /dev/voidvm/root
# mkfs.ext4 -L HOME /dev/voidvm/home
# mkfs.vfat -n UEFI /dev/nvme0n1p1
```

Poi montali nel seguente ordine: prima la radice poi il resto. Adesso siamo pronti per installare il sistema.

```
# mkdir -p /mnt/boot/efi
# mount /dev/voidvm/root /mnt
# mount /dev/voidvm/home /mnt
# mount /dev/nvme0n1p1 /mnt/boot/efi
```

## Installazione del sistema

Copia le chiavi RSA della distribuzione dal mezzo d'installazione: ti serviranno per verificare i pacchetti da installare nel prossimo passaggio. Già che ci sei copia anche la configurazione del WiFi (`db=/etc/wpa_supplicant`).

```
# db=/var/db/xbps/keys 
# mkdir -p /mnt/$db
# cp $db/* /mnt/$db
```

Installa i pacchetti essenziali, tra cui il sistema di base. Ti consiglio vivamente di leggere il manuale di XBPS e la documentazione online per familiarizzare con la distribuzione.

```
# xbps-install -Sr /mnt -R https://repo-fastly.voidlinux.org/current \
>   base-system cryptsetup grub-x86_64-efi lvm2
[*] Updating repository `https://repo-fastly.voidlinux.org/current/x86_64-repodata' ...
```

## Configurazione del sistema

La seguente configurazione rende immutabile il vostro DNS resolver (spesso sovrascritto da dhcpcd).

```
[xchroot /mnt] # echo nameserver 1.1.1.1 > /etc/resolv.conf
[xchroot /mnt] # chattr +i /etc/resolv.conf
```

Dai un nome al tuo PC, sincronizza l'orologio hardware con quello di sistema, e configura il fuso orario.

```
[xchroot /mnt] # echo "voidvm" > /etc/hostname
[xchroot /mnt] # hwclock --systohc
[xchroot /mnt] # ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime
```

Se hai scelto la versione `glibc` di Void devi specificare una lingua per il sistema.

```
[xchroot /mnt] # echo  LANG=en_US.UTF-8 > /etc/locale.conf
[xchroot /mnt] # echo en_US.UTF-8 UTF-8 > /etc/default/libc-locales
[xchroot /mnt] # xbps-reconfigure -f glibc-locales
```

Se anche tu possiedi un NVMe, puoi attivare la pulizia automatica con la seguente configurazione.

```
[xchroot /mnt] # printf '#!/bin/sh\nfstrim /' > /etc/cron.monthly/fstrim
[xchroot /mnt] # chmod 755 /etc/cron.monthly/fstrim
```

## Configurazione del bootloader

<!-- TODO: Descrivere il seguente passaggio (Richiede VIM). -->

```
# <file system>    <dir> <type>  <options>             <dump>  <pass>
tmpfs              /tmp  tmpfs   defaults,nosuid,nodev 0       0
/dev/voidvm/swap   swap  swap    defaults              0       0
/dev/voidvm/root   /     ext4    defaults              0       0
/dev/voidvm/home   /home ext4    defaults              0       0
/dev/nvme0n1p1 /boot/efi vfat    defaults,nosuid,nodev,noexec,fmask=0177,dmask=0077 0       0
```

Analogamente il file `/etc/crypttab` contiene le mappature per decifrare le partizioni crittografate. Sostituisci `discard` con `none` se non usi un NVMe.

```
uuid=$(blkid -o value -s UUID /dev/nvme0n1p2)
echo voidvm UUID=$uuid none discard > /etc/crypttab
```

```
install_items+=" /etc/crypttab "
```

Aggiungi i seguenti parametri del kernel alla configurazione del boot loader. Come al solito, rimuovi `rd.luks.allow-discards` se non usi un NVMe.

```
sed "s/#CMDLINE=\"\"/CMDLINE=\"rd.luks.allow-discards rd.luks.name=$uuid=voidvm quiet loglevel=3\"" > /etc/default/systemd-boot
```

```
bootctl install
```

## Troubleshooting

Fai una prova `ping voidlinux.org` fanne una altra `ping archlinux.org` controlla il DNS.

```
# ping voidlinux.org
ping: voidlinux.org: Name or service not known
# ping archlinux.org
ping: archlinux.org: Name or service not known

# ping 1.1.1.1
# cat /etc/resolv.conf
nameserver 1.1.1.1

# ping 192.168.1.1
# ip route
default via 192.168.1.1 dev wlp2s0 proto dhcp src 192.168.1.11 metric 3003
```

Assicurati che l'interfaccia sia attiva: se è così troverai scritto **state up**.

```
# ip link  set wlp2s0 up
# ip link show wlp2s0
3: wlp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DORMANT group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
```

Assicurati che il segnale WiFi non venga bloccato dal sistema operativo o da un interruttore fisico.

```
# rfkill unblock all
# rfkill list
0: hci0: Bluetooth
	Soft blocked: no
	Hard blocked: no
1: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no
```

Se hai un firewall installato come `ufw` oppure un DNS resolver come `unbound` sai cosa fare.

In più controlla che tutti i servizi rilevanti, es. `dhcpcd`, siano attivi. In genere, dovrebbero funzionare out-of-the-box.


### Esempio Pratico

AAA

```
# grep interface /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=/run/wpa_supplicant
ctrl_interface_group=wheel
# chown -R root:wheel /run/wpa_supplicant
# sv restart wpa_supplicant
```

<!--
```
[xchroot /mnt] # xbps-install chrony cronie elogind polkit socklog
[xchroot /mnt] # ln -s /etc/sv/crond /etc/sv/dhcpcd \
>                      /etc/sv/elogind /etc/sv/ntpd \
>                      /etc/sv/nanoklogd /etc/sv/socklog-unix \
>                      /etc/sv/wpa_supplicant /var/service/
```
òàé
-->
