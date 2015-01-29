build: rootfs.tar Dockerfile
	docker build -t armhf-busybox .

tag:
	docker tag armhf-busybox moul/armhf-busybox

rootfs.tar:
	cd rootfs && docker build -t busybox-rootfs .
	docker run --rm busybox-rootfs cat /tmp/buildroot/output/images/rootfs.tar > rootfs.tar
	docker rmi busybox-rootfs
