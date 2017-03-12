# FreeBSD immutable NAS

## Introduction

This repository contains a packer script followed by an Ansible provisioning script for the automated creation of an immutable FreeBSD ISO image for my personal NAS. 

See also: https://github.com/yannh/openbsd_immutable_router

The image is "immutable" in the sense that the root partition is read-only, with particular mount points mounted as in-memory filesystems, allowing for non-persistent writes. Therefore the data saved on the bootable Memory card never changes, and upgrades are done by swapping the card.

Persistent, user data is saved on a ZFS pool.

Build with:

    packer build -var-file=freebsd110.json freebsd.json


This repository has been made public for educational purposes, to provide an example of a working "immutable server", and inspire people to start working on similar architectures. It can also serve as a good read on the basic configuration of FreeBSD as a NAS.

The [Boxcutter project](https://github.com/boxcutter/bsd) was of great help for the automated installation.

## Hardware (2014)

 * Lian Li PC-Q25B Mini-ITX
 * Silverstone 300W SST-ST30SF 
 * ASRock C2550D4I - Mini-ITX Mainboard
 * 1 * 8GB Unbuffered ECC RAM Crucial CT102472BD160B
 * 3 * 4TB WD RED (ZFS pool)
 * 120GB internal SSD Intel SSDSC2BB120G401 DC S3500 Series (ZFS ZIL)
 * Transcend Ultra-Speed 133x 8GB Compact Flash Card (System)
 * SD-ADA40001 Adapter SATA II to CF 
 * SATA - eSATA adapter
 * Inateck USB 3.0 Docking Station + Additional drives for backups through eSATA
 * Be Quiet! Silent Wings PWM 120+140mm
 * Additional short, 90 degrees SATA cables, null-modem serial cable for initial bios configuration
