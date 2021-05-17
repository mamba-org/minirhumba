# Minirhumba

[![Build Status](https://travis-ci.com/mamba-org/minirhumba.svg?branch=master)](https://travis-ci.com/mamba-org/minirhumba)

This repository holds a minimal installer for [Rhumba](https://github.com/mamba-org/rhumba).
Rhumba works like CRAN but is blazingly fast ⚡.

## Download

Minirhumba installers are available here: https://github.com/mamba-org/minirhumba/releases

#### Minirhumba

Lastest installers:

- [minirhumba-0.1.1-Linux-aarch64.sh](https://github.com/mamba-org/minirhumba/releases/download/0.1.1/minirhumba-0.1.1-Linux-aarch64.sh)
- [minirhumba-0.1.1-Linux-ppc64le.sh](https://github.com/mamba-org/minirhumba/releases/download/0.1.1/minirhumba-0.1.1-Linux-ppc64le.sh)
- [minirhumba-0.1.1-Linux-x86_64.sh](https://github.com/mamba-org/minirhumba/releases/download/0.1.1/minirhumba-0.1.1-Linux-x86_64.sh)
- [minirhumba-0.1.1-MacOSX-arm64.sh](https://github.com/mamba-org/minirhumba/releases/download/0.1.1/minirhumba-0.1.1-Linux-x86_64.sh)
- [minirhumba-0.1.1-MacOSX-x86_64.sh](https://github.com/mamba-org/minirhumba/releases/download/0.1.1/minirhumba-0.1.1-MacOSX-x86_64.sh)
- [minirhumba-0.1.1-Windows-x86_64.exe](https://github.com/mamba-org/minirhumba/releases/download/0.1.1/minirhumba-0.1.1-Windows-x86_64.exe)

## Usage

To install Rhumba, choose your installer and run it with the command:

```
bash your_minirhumba_file.sh
```

Note: `Rhumba` is only available by default on the base environment, if the base environment is not active in your terminal type:

```
conda activate base
```

To start the base environment.

## Testing

Only on Linux builds, after construction on Travis, the installer is tested against a range of distribution that match the installer architecture (`$ARCH`). For example when architecture is `aarch64`, the constructed installer is tested against:

- Centos 7
- Debian Buster (10)
- Ubuntu 16.04
- Ubuntu 18.04
- Ubuntu 19.10

## License

We use a shared copyright model that enables all contributors to maintain the copyright on their contributions.

This software is licensed under the BSD-3-Clause license. [BSD 3-Clause](./LICENSE)
