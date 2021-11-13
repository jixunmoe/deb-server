# debian repo server with aptly

## Build image

```sh
docker build -t deb-server .
```

## instruction to trust our key

```
curl https://example.com/repo.gpg \
  | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/name-prod-keyring.gpg
```

## GPG Key management

Quick instructions on how to manipulate keys.

### Key generation

```sh
# start docker
docker run --rm -it -v "$(pwd)/local:/local" deb-server bash

# generate a new key (set to 10y or inf to avoid key update; use RSA 4096)
# to use without pass-phrase, add "--pinentry-mode loopback"
gpg --full-generate-key 

# export our only key
gpg --armor --export-secret-key -o /local/.private.key
gpg --armor --export -o /local/repo.gpg
```

### Key import

Place `.deb-private.key` to deb-root.

### remove gpg passphrase

```text
$ gpg --list-key
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
/root/.gnupg/pubring.kbx
------------------------
pub   rsa4096 2021-11-12 [SC]
      AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
uid           [ultimate] First Last (Comment) <hello@example.com>
sub   rsa4096 2021-11-12 [E]

$ gpg --pinentry-mode loopback --edit-key AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

gpg> passwd
(hit enter twice)
gpg> quit
```
