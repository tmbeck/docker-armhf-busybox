.PHONY:	build

build: rootfs.tar Dockerfile qemu-arm-static
	docker build -t moul/armhf-busybox .

rootfs.tar:
	cd rootfs && docker build -t busybox-rootfs .
	docker run --rm busybox-rootfs cat /tmp/buildroot/output/images/rootfs.tar > rootfs.tar
	docker rmi busybox-rootfs

qemu-arm-static:
	docker run -it --rm moul/qemu-user:latest cat /usr/bin/qemu-arm-static > $@
	chmod +x $@
