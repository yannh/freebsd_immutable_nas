#!/usr/bin/make -f

.PHONY: clean build

clean:
	rm -rf output-qemu

build: clean
	packer build -var-file=freebsd120.json --on-error=ask freebsd.json
