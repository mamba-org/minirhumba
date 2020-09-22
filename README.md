# Minirhumba

[![Build Status](https://travis-ci.com/mamba-org/minirhumba.svg?branch=master)](https://travis-ci.com/mamba-org/minirhumba)

This repository holds a minimal installer for minirhumba.
Minirhumba comes from [rhumba](https://github.com/mamba-org/rhumba), which are R bindings for micromamba. Rhumba works like CRAN but is blazingly fast ⚡.

## Download

Minirhumba installers are available here: https://github.com/mamba-org/minirhumba/releases

#### Minirhumba

Lastest installers:

- [linux-x86_64](https://github.com/mamba-org/minirhumba/releases/download/0.0.1/minirhumba-0.0.1-Linux-x86_64.sh)
- [osx-x86_64](https://github.com/mamba-org/minirhumba/releases/download/0.0.1/minirhumba-0.0.1-MacOSX-x86_64.sh)

## Testing

Only on Linux builds, after construction on Travis, the installer is tested against a range of distribution that match the installer architecture (`$ARCH`). For example when architecture is `aarch64`, the constructed installer is tested against:

- Centos 7
- Debian Buster (10)
- Ubuntu 16.04
- Ubuntu 18.04
- Ubuntu 19.10

## Usage

`bash your_minirhumba_file.sh`

## Release

To release a new version of Minirhumba:

- Make a new release of rhumba
- Tag a new version
- Run `.travis.yml`

To keep in mind: we're depending on a hard coded version of Miniconda and this may cause problems in the future. It's important to keep it somewhat updated.

## License

[BSD 3-Clause](./LICENSE)
