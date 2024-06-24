% MUTTSETUP(1) automutt 1.0 | General Commands Manual

## NAME

**muttsetup** – **mutt** config manager inspired by **mw**

## SYNOPSIS

**muttsetup** \[**-a** | **-d** | **-y** *address*\] \[**-nu** *name*\] \[**-sip** *host*\]

## DESCRIPTION

**muttsetup** is a simple POSIX shell script that manages multiple email accounts for **mutt**.
You can easily add accounts, delete accounts and sync them manually or setup a cronjob.

The options are as follows:

| Option           | Description                           |
| :--------------- | :------------------------------------ |
| **-a** *address* | Create an account with email address. |
| **-d** *address* | Delete an account with email address. |
| **-y** *address* | Update mailbox and send notification. |
| **-n** *name*    | (create) Set your account realname.   |
| **-u** *name*    | (create) Set your account username.   |
| **-s** *host*    | (create) Set your SMTP domain name.   |
| **-i** *host*    | (create) Set your IMAP domain name.   |
| **-p** *host*    | (create) Set your POP3 domain name.   |

**muttsetup** doesn't ship with sophisticated shortcuts and macros out of the box.
If you seek a specific type of workflow with your emails, please don't open an issue.

**muttsetup** purposely misses basic sanity checks, so that users who don't
read the manual know they are wasting their time.

NOTE: Specify either SMTP, IMAP or POP3. The others will be assigned automatically.

## INSTALL

```
git clone https://github.com/thatfatblackcat/automutt
cd automutt && sudo make install
```

List of required dependencies:

| Program | Description            |
| :------ | :--------------------- |
| *mutt*  | (MUA) Displays mails   |
| *gpg2*  | (PGP) Encrypts mails   |
| *isync* | (IMAP) Retrieves mails |
| *mpop*  | (POP3) Retrieves mails |
| *msmtp* | (SMTP) Sends mails     |

List of optional dependencies:

| Program | Description               |
| :------ | :------------------------ |
| *bash*  | (script) Makes read quiet |
| *curl*  | (script) Downloads gpg.rc |

## KEYBINDS

| Key | Description        |
| :-- | :----------------- |
| *h* | (browse) Left      |
| *j* | (browse) Down      |
| *k* | (browse) Up        |
| *l* | (browse) Right     |
| *m* | (send) Compose     |
| *r* | (send) Reply       |
| *b* | (send) Bounce      |
| *f* | (send) Forward     |
| *d* | (archive) Delete   |
| *s* | (archive) Save     |
| *t* | (archive) Tag      |
| *u* | (archive) Undelete |

## PRIVACY

ECC Curve25519 is supported by Nitrokey, Yubikey, Proton Mail and GnuPG on practically all OS as of June 2022.
As the GnuPG FAQ states, “Every minute we spend arguing on defaults, is one minute the shift to ECC is delayed.”

Expiry date doesn't provide extra security, especially on primary keys, which are usually the ones we publish.
The best way to protect against someone impersonating you is to preemptively print out a revocation certificate.

Web Key Directory is a service offered by your email provider that facilitates public key discovery via HTTPS.
It enables automatic retrieval of keys, eliminating the need to import a user's key from an arbitrary keyserver.

**muttsetup** recommends the following email practices:

* Force your mails to be displayed using plain/text instead of HTML to protect against web beacons.
* Don't store your mails into big tech's inboxes, and never give them your phone number for 2FA purposes.
* Separate your identities using anonymous email aliases, but not from 3rd party aliasing services.

## ENVIRONMENT

| Files and Directories  | Description                             |
| :--------------------- | :-------------------------------------- |
| $XDG_CONFIG_HOME/isync | Where **isync** stores its config files |
| $XDG_CONFIG_HOME/mpop  | Where **mpop** stores its config files  |
| $XDG_CONFIG_HOME/msmtp | Where **msmtp** stores its config files |
| $XDG_CONFIG_HOME/mutt  | Where **mutt** stores its config files  |

## AUTHORS

Written by thatfatblackcat (TFBC), hugely inspired by Luke Smith's work.

## SEE ALSO

gpg(1), mbsync(1), msmtp(1), mpop(1), mutt(1)
