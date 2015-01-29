FROM       scratch
MAINTAINER Manfred Touron <m@42.am> (@moul)

ADD ./rootfs.tar /
ADD ./opkg.conf         /etc/opkg.conf
ADD ./opkg-install      /usr/bin/opkg-install
ADD ./functions.sh      /lib/functions.sh
RUN opkg-cl install http://downloads.openwrt.org/snapshots/trunk/mvebu/packages/base/libgcc_4.8-linaro-1_mvebu.ipk
RUN opkg-cl install http://downloads.openwrt.org/snapshots/trunk/mvebu/packages/base/libc_0.9.33.2-1_mvebu.ipk

CMD ["/bin/sh"]
