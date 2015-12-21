#!/bin/bash
case $1 in
	-r)
		qemu-system-arm -M vexpress-a15 -nographic -kernel  ~/cach/versatile_board_out/arch/arm/boot/zImage -dtb ~/cach/versatile_board_out/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb  -initrd initramfs2  --append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init"
		;;
	-b)
		make -C ~/github/linux-stable/ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=~/cach/versatile_board_out -j12 || exit
		;;
	-c)
		make -C ~/github/linux-stable/ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=~/cach/versatile_board_out vexpress_defconfig
		;;
	-t)
		qemu-system-arm -M vexpress-a15 -nographic -kernel ~/github/u-boot/u-boot.bin 
		;;
	*)
		echo "need your input as follow: "
		echo "	ver_qemu.sh -r: run the qemu"
		echo "	ver_qemu.sh -b: make linux zImage"
		echo "	ver_qemu.sh -c: make defconfig for ver"
		;;
	esac
