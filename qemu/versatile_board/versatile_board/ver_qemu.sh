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
		qemu-system-arm -M vexpress-a15 -nographic -kernel ~/github/u-boot-qemu/u-boot.bin 
		;;
	-gdb)
		gnome-terminal -x bash -c "qemu-system-arm -nographic -gdb tcp::1234 -S -M vexpress-a15 -kernel  ~/cach/versatile_board_out/arch/arm/boot/zImage -dtb ~/cach/versatile_board_out/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb  -initrd initramfs2  -serial stdio --append \"console=ttyAMA0 root=/dev/ram rdinit=/sbin/init\""
		sleep 2
		arm-linux-gnueabihf-gdb 
		;;

	-gdb-uboot)
		#gnome-terminal -x bash -c "qemu-system-arm -nographic -S -s -M vexpress-a15 -kernel ~/github/u-boot-qemu/u-boot"
		gnome-terminal -x bash -c "qemu-system-arm -M vexpress-a9  -m 128M -serial stdio -kernel ~/github/u-boot-qemu/u-boot -display none -S -s"
		#sleep 2
		arm-linux-gnueabihf-gdb ~/github/u-boot-qemu/u-boot
		;;
	*)
		echo "need your input as follow: "
		echo "	ver_qemu.sh -r: run the qemu"
		echo "	ver_qemu.sh -b: make linux zImage"
		echo "	ver_qemu.sh -c: make defconfig for ver"
		;;
	esac
