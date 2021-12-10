#! /bin/bash
#即将安装的内核版本
new_kernel=5.15.7-kissyouhunter
#安装完新内核删除老内核版本
old_kernel=5.10.84-kissyouhunter
#内核源码
kernel_code=linux-5.15.y
#各文件路径变量
root_path=/root
boot_path=/boot
dtb_path=/boot/dtb/amlogic
new_dtb_path=/arch/arm64/boot/dts/amlogic
modules_path=/usr/lib/modules
cd ${root_path}
#解压 Armbian 源码包
unzip ${kernel_code}.zip
rm -f ${kernel_code}.zip
tar zxvf ${kernel_code}.tar.gz
mv ${kernel_code} ${new_kernel}
#安装内核模块
cd ${new_kernel}
make modules_install && make install
cd ${boot_path} && cp -r vmlinuz-${new_kernel} zImage && cp -r uInitrd uInitrd-${new_kernel}
cd ${dtb_path} && rm -f *
cp ${root_path}/${new_kernel}/${new_dtb_path}/*.dtb ${dtb_path}
#cp ${root_path}/${new_kernel}/${new_dtb_path}/meson-gxl-s905d-phicomm-n1-thresh.dtb ${dtb_path}
#打包boot模块
cd ${boot_path} && tar zcvf boot-${new_kernel}.tar.gz *-${new_kernel} && cp -r boot-${new_kernel}.tar.gz ${root_path}
#打包dtb文件
cd ${dtb_path} && tar zcvf dtb-amlogic-${new_kernel}.tar.gz *.dtb && cp -r dtb-amlogic-${new_kernel}.tar.gz ${root_path}
#打包modules模块
cd ${modules_path} && tar zcvf modules-${new_kernel}.tar.gz ${new_kernel} && cp -r modules-${new_kernel}.tar.gz ${root_path}
#删除多余内核文件
rm -r ${boot_path}/*-${old_kernel} && rm -r ${modules_path}/${old_kernel}
#删除打文件
rm -r ${boot_path}/boot-${new_kernel}.tar.gz
rm -r ${dtb_path}/dtb-amlogic-${new_kernel}.tar.gz
rm -r ${modules_path}/modules-${new_kernel}.tar.gz
rm -rf ${root_path}/${new_kernel}
rm -f ${kernel_code}.tar.gz
