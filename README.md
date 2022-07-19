Kernel for Newbies is a simple Linux Kernel customization and compilation wizard, written in Shell, allowing for cross-platform compilation, supporting multiple compilers (GCC and LLVM).

The New KFN is being rewritten from scratch, to make the latest technologies compatible and to support the latest Debian-like distributions, such as Ubuntu and Mint, and with current development to make platforms based on RedHat and OpenSUSE compatible.

The program supports 2 languages (Portuguese and English) that can be defined during installation or first use.

KFN supports compilations for the host architecture natively (any architecture) and cross-build* for ARM, ARM64, PowerPC and x86_32.

*Cross-build compatibility is still partial, and soon, new updates will complement the missing architectures.


Installation:

$ wget https://raw.githubusercontent.com/motomagx/kfn/master/kfn.sh<br>
$ chmod + x kfn.sh<br>
$ ./kfn.sh<br>


Requirements:

-System based on Debian (Ubuntu, Mint, etc.) or a compatible distribution, from 2018 onwards.<br>
-Processor with 4 cores or more is recommended (Intel Core i3/i5/i7/i9/Xeon, AMD Ryzen 3/5/7, ARM Cortex A9 +)<br>
-At least 40GB of free HD space (average size of a normal Kernel build, including temporary ones)<br>
-2GB of RAM (recommended: 4GB or more)<br>
-Requires internet connection with access to your distribution repositories + free access to Kernel.org and Github<br>
 

Dependencies:

In order for the build to take place perfectly, we recommend that the following packages be installed, however, KFN can install for you after installation:

alien autoconf axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g ++ gcc gnupg2 gzip initramfs-tools kernel-package libc6 libelf-dev libncurses libncurses5-dev libudev-dev libpci-dev libiberty-dev -dev lzop make openssl pkg-config qemu tar wget
