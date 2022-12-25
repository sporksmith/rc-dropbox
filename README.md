# Recovery code drop box

This is a few simple shell scripts that implement an encrypted drop box. I made
this primarily as a way to securely store account recovery codes, though it
could be useful for other high value, rarely-accessed, secrets. Basically the
idea is to:

* Generate an asymmetric key pair and store it in this directory.
* Protect the private key with a cryptographically strong passphrase. This
  should be stored somewhere safe - e.g. written down and physically locked
  away.
* Add secrets by encrypting under the keypair. You don't need the passphrase
  for this operation, so can do it from anywhere, including a machine that you
  may not fully trust.
* If you need to access one of the secrets, you'll need to enter the
  passphrase.

Personally, the way this fits into my overall account security management:

* I store my passwords in a [keepassxc][keepassxc] database. This is sync'd to
  my devices using [syncthing][syncthing] and backed up off-site.
* High-value accounts are protected with [2fa][2fa]. I use [yubikeys][yubico],
  but there are a lot of options here.
* Recovery codes for accounts protected with 2fa are stored in this drop box,
  which is also syncd across my devices and backed up off-site.

[keepassxc]: https://keepassxc.org/
[syncthing]: https://syncthing.net/
[2fa]: https://en.wikipedia.org/wiki/Multi-factor_authentication
[yubico]: https://www.yubico.com/products/

If my house burns down with all of my 2fa devices inside of it, I should be
able to regain access to accounts with recovery codes in this vault, which
again is backed up off-site.

Since the passphrase for accessing the vault is rarely needed, including to
*add things* to the vault, I can keep it securely offline. Even an attacker who
has compromised one of my devices and stolen my unencrypted password database
out of memory probably won't have an opportunity to steal the vault passphrase.

The scripts are thin wrappers around the
[age](https://github.com/FiloSottile/age) encryption tool. They are intended to
be run from the current directory.

## Initialization

Running `init.sh` will create a keypair. You will be prompted for a passphrase
to encrypt the secrety key.

```bash
$ ./init.sh
```

This will generate the private key `key.age`, and the public key `key.age.pub`.

To add recovery codes for google.com:

```
./add.sh google.com
<paste recovery codes>
^D
```

will generate `google.com.age`.

To decrypt:

```
./decrypt.sh google.com.age
```
