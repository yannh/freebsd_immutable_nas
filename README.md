# FreeBSD immutable NAS

This repository contains a packer script followed by an Ansible provisioning script for the automated creation of an immutable FreeBSD ISO image for my personal NAS. 

See also: https://github.com/yannh/openbsd_immutable_router

Build with:

    packer build -var-file=freebsd110.json freebsd.json

This repository has been made public for educational purposes, to provide an example of a working "immutable server", and inspire people to start working on similar architectures. It can also serve as a good read on the basic configuration of FreeBSD as a NAS.

The [Boxcutter project](https://github.com/boxcutter/bsd) was of great help for the automated installation.
