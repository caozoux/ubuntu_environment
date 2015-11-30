#make -C ~/github/linux-stable/ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=~/cach/versatile_board_out vexpress_defconfig
#make -C ~/github/linux-stable/ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=~/cach/versatile_board_out -j12
qemu-system-arm -M vexpress-a15 -nographic -kernel  ~/cach/versatile_board_out/arch/arm/boot/zImage -dtb ~/cach/versatile_board_out/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb  -initrd initramfs2  -serial stdio --append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init"
#qemu-system-arm -M vexpress-a15 -kernel  ~/cach/versatile_board_out/arch/arm/boot/zImage -dtb ~/cach/versatile_board_out/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb  -serial stdio --append "console=ttyAMA0"

exit
qemu-system-arm  -nographic -M vexpress-a15 -kernel  ~/cach/versatile_board_out/arch/arm/boot/zImage -dtb ~/cach/versatile_board_out/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dtb  -initrd initramfs2  --append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init"

dd if=/dev/zero of=rootfs.img bs=1M count=20
#格式化磁盘
mkfs.ext3 rootfs.img
#创建rootfs目录,用来挂载rootfs.img
mkdir rootfs
#挂载rootfs.img
sudo mount -o loop rootfs.img rootfs
#将busybox生成的_install目录下的内容全部copy到rootfs目录下.
#这其实就是所谓的根文件系统
cp -rv ./busybox/_install/* ./rootfs
#创建系统启动必要的设备文件 
cd rootfs
sudo mknod rootfs/dev/console c 5 1
sudo mknod rootfs/dev/ram b 1 0
#将linux编译生成的bzImage拷贝过来
cd ..
cp ./linux-stable/arch/x86/boot/bzImage

#启动qemu,同时装载刚才生成的根文件系统及内核文件
qemu -hda ./rootfs.img -kernel ./bzImage -append "root=/dev/sda"


#u-boot
#make vexpress_ca9x4_defconfig
#qemu-system-arm -M vexpress-a9  -m 128M -serial stdio -kernel u-boot -display none
