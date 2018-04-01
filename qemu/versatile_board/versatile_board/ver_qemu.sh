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

	-x)
		#sudo qemu-system-x86_64 -device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:02 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -s -S -m 256 -drive file=/home/zoucao/cach/core-image-minimal-qemux86-64-20180212130532.rootfs.ext4,if=virtio,format=raw -vga vmware -show-cursor -usb -usbdevice tablet -device virtio-rng-pci -serial mon:vc -serial mon:stdio -serial null -kernel /home/zoucao/cach/linux-stable/arch/x86_64/boot/bzImage -append 'root=/dev/vda rw highres=off  console=ttyS0 mem=256M ip=192.168.7.2::192.168.7.1:255.255.255.0 vga=0 uvesafb.mode_option=640x480-32 oprofile.timer=1 uvesafb.task_timeout=-1'
		#sudo qemu-system-i386 -s -S -m 4096 -drive file=/home/zoucao/cach/core-image-minimal-qemux86-64-20180212130532.rootfs.ext4,if=virtio,format=raw -kernel /home/zoucao/cach/linux-stable/arch/x86/boot/bzImage 
		#sudo qemu-system-i386 -m 4096 -drive file=/home/zoucao/cach/core-image-minimal-qemux86-64-20180212130532.rootfs.ext4,if=virtio,format=raw -kernel /home/zoucao/cach/linux-stable/arch/x86/boot/bzImage 
 		#sudo /home/zoucao/work/yocto/yocto_prj/x86-64/tmp/work/x86_64-linux/qemu-helper-native/1.0-r1/recipe-sysroot-native/usr/bin/qemu-system-x86_64 -nographic -device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:02 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -drive file=/home/zoucao/work/yocto/yocto_prj/x86-64/tmp/deploy/images/qemux86-64/core-image-minimal-qemux86-64-20180218043354.rootfs.ext4,if=virtio,format=raw -vga vmware -show-cursor -usb -device usb-tablet -device virtio-rng-pci  -cpu core2duo -m 4096 -serial mon:vc -serial mon:stdio -serial null -kernel /home/zoucao/cach/linux-yocto/arch/x86_64/boot/bzImage -append 'root=/dev/vda rw highres=off  console=ttyS0 mem=4096M ip=192.168.7.2::192.168.7.1:255.255.255.0 vga=0 uvesafb.mode_option=640x480-32 oprofile.timer=1 uvesafb.task_timeout=-1 hugepages=100'
 		sudo /home/zoucao/work/yocto/yocto_prj/x86-64/tmp/work/x86_64-linux/qemu-helper-native/1.0-r1/recipe-sysroot-native/usr/bin/qemu-system-x86_64 -nographic -device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:02 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -drive file=/home/zoucao/work/yocto/yocto_prj/x86-64/tmp/deploy/images/qemux86-64/core-image-minimal-qemux86-64-20180218043354.rootfs.ext4,if=virtio,format=raw -device virtio-rng-pci  -cpu core2duo -m 4096 -kernel /home/zoucao/cach/linux-yocto/arch/x86_64/boot/bzImage -append 'root=/dev/vda rw highres=off  console=ttyS0 mem=4096M ip=192.168.7.2::192.168.7.1:255.255.255.0  oprofile.timer=1 uvesafb.task_timeout=-1 hugepages=100'
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
		echo "	ver_qemu.sh -x: run qume x86_64"
		;;
	esac
