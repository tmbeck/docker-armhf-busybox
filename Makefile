NAME =	armhf-busybox

.PHONY:	build qemu

all:	build

build: rootfs.tar Dockerfile qemu-arm-static
	docker build -t $(NAME) .
	docker tag -f $(NAME) moul/$(NAME)

qemu:	vmlinuz initrd.gz
	qemu-system-arm -M versatilepb -cpu cortex-a8 -kernel ./vmlinuz -initrd ./initrd.gz -m 256

rootfs.tar:
	cd rootfs && docker build -t busybox-rootfs .
	docker run --rm busybox-rootfs cat /tmp/buildroot/output/images/rootfs.tar > rootfs.tar
	docker rmi busybox-rootfs

qemu-arm-static:
	docker run -it --rm moul/qemu-user:latest cat /usr/bin/qemu-arm-static > $@
	chmod +x $@

initrd.tar:
	-docker rm $(NAME)-export || true
	docker run --name $(NAME)-export --entrypoint /dontexists $(NAME):latest 2>/dev/null || true
	docker export $(NAME)-export > $@.tmp
	docker rm $(NAME)-export
	mv $@.tmp $@

initrd: initrd.tar
	-rm -rf $@ && mkdir $@
	tar -C $@ -xf $<

initrd.gz: initrd
	cd initrd && find . -print0 | cpio --null -ov --format=newc | gzip -9 > $(PWD)/$@

vmlinuz:
	wget http://ports.ubuntu.com/ubuntu-ports/dists/lucid/main/installer-armel/current/images/versatile/netboot/vmlinuz
