#!/bin/bash

# Kernel for Newbies
# Powered by Bill Cypher

TITLE="Kernel for Newbies"
MAIN_TITLE="The multi-arch kernel compiler tool"
VERSION=3.0

BASE_URL="https://cdn.kernel.org/pub/linux/kernel"
DEPENDENCIES="alien axel bc bison build-essential bzip2 clang curl dialog dkms fakeroot flex g++ gcc gnupg2 gzip initramfs-tools libc6 libelf-dev libncurses libncurses5-dev libnotify-bin libssl-dev lzop make pkg-config qt5-default tar wget"

DOWNLOAD_DIR="$HOME/kfn/Downloads"
SOURCE_DIR="$HOME/kfn/Source"
BUILD_DIR="$HOME/kfn/Builds"

ALL_DEPENDECIES_INSTALLED=0
DEPENDENCIES=( $DEPENDENCIES )

title()
{
	clear
	echo -e "$TITLE $VERSION\n"
}

print()
{
    MODE="$1"
    TEXT="$2"

    if [ "$MODE" == "ok" ]
    then
        echo -e "\e[32;1m[ OK ]\e[m $TEXT"
    fi

    if [ "$MODE" == "info" ]
    then
        echo -e "\e[32;1m[INFO]\e[m $TEXT"
    fi

    if [ "$MODE" == "warn" ]
    then
        echo -e "\e[33;1m[WARN]\e[m $TEXT"
    fi

    if [ "$MODE" == "error" ]
    then
        echo -e "\e[31;1m[ERRO]\e[m $TEXT"
    fi
}

_start()
{


    print ok "Set KFN dir as: $HOME/kfn"
    print ok "     Downloads: $DOWNLOAD_DIR"
    print ok "        Source: $SOURCE_DIR"
    print ok "        Builds: $BUILD_DIR"

	mkdir -p "$DOWNLOAD_DIR"
	mkdir -p "$SOURCE_DIR"
	mkdir -p "$BUILD_DIR"

    echo -e "\e[32;1m\n ** All ready. Press ENTER to start $TITLE **\e[m"
    read a
}

_disk_usage()
{
    DISK_USAGE=( `df / | grep dev` )
    DISK_USAGE=`echo "${DISK_USAGE[3]}/1024/1024" | bc`

    if [ $DISK_USAGE -lt 15 ]
    then
        print error "Disk: Only $DISK_USAGE GB free in /home partition, when at least 15GB is needed. Proceed cautiously."
    else
        print ok "Disk: $DISK_USAGE GB free in /home partition partition."
    fi
}

_tmp_rw_check()
{
    RND_VALUE="$RANDOM"

    touch "/tmp/$RND_VALUE"

    if [ -f "/tmp/$RND_VALUE" ]
    then
        print ok "Read/Write access in /tmp is allowed."
    else
        print error "Read-only access in /tmp."  
    fi
}

_source_rw_check()
{
    RND_VALUE="$RANDOM"

    touch "/usr/src/$RND_VALUE" 2> /dev/null

    if [ -f "/usr/src/$RND_VALUE" ]
    then
        print ok "Read/Write access in /usr/src is allowed."
    else
        print warn "Read-only access in /usr/src."
    fi
}

_ram_check()
{               
    MEM_SIZE=( `cat /proc/meminfo | grep MemTotal` )
    MEM_SIZE="`echo ${MEM_SIZE[1]}/1024 | bc`"

    SWAP_SIZE=( `cat /proc/meminfo | grep SwapTotal` )
    SWAP_SIZE="`echo ${SWAP_SIZE[1]}/1024 | bc`"

    if [ $MEM_SIZE -lt 2048 ]
    then
        print warn "RAM: $MEM_SIZE MB, recommended: >= 4096 MB RAM and at least 1024 MB Swap."
        #print info "PlayStation 3 Users: You can use Geforce VRAM (/dev/ps3da3) as a fast Swap partition."
    else
        print ok "RAM: $MEM_SIZE MB RAM + $SWAP_SIZE MB Swap."
    fi
}

_windows_subsystem_checker()
{
	WINDOWS_SUBSYSTEM="`cat /proc/version | grep Microsoft@Microsoft.com | wc -l`"

	if [ "$WINDOWS_SUBSYSTEM" != 0 ]
	then
		print error "$TITLE is not compatible with Linux on Windows subsystem, try VirtualBox, Vmware, QEMU, Linux-KVM or dual-boot. Exiting." 
		exit
	fi
}

_vm_checker()
{
	HV_CHECK=`dmesg | grep -i hypervisor | wc -l`
	QEMU_CHECK=`dmesg | grep -i qemu | wc -l`
	VMWARE_CHECK=`dmesg | grep -i vmware | wc -l`
	VBOX_CHECK=`dmesg | grep -i virtualbox | wc -l`

	if [ $HV_CHECK != 0 ]
	then
		print info "Hyper-V is detected as virtual machine host. Performance may be reduced."
	fi

	if [ $QEMU_CHECK != 0 ]
	then
		print info "QEMU/KVM is detected as virtual machine host. Performance may be reduced."
	fi

	if [ $VMWARE_CHECK != 0 ]
	then
		print info "VMware is detected as virtual machine host. Performance may be reduced."
	fi

	if [ $VBOX_CHECK != 0 ]
	then
		print info "Virtual Box is detected as virtual machine host. Performance may be reduced."
	fi
}

_cpu_cores()
{
    CPU_THREADS="`cat /proc/cpuinfo | grep processor | wc -l`"
	CPU_MODEL="`cat /proc/cpuinfo | grep "model name" | head -1`"
	CPU_MODEL="`echo $CPU_MODEL`"
	CPU_MODEL=${CPU_MODEL/"model name :"/}
	CPU_MODEL=${CPU_MODEL/" "/}

	print ok "CPU: $CPU_MODEL"

    if [ $CPU_THREADS -lt 4 ]
    then
        print warn "CPU: Your system has only $CPU_THREADS available CPU cores.\n       Compilation of the kernel in this system can take a very long time."
    else
        print ok "CPU: A $CPU_THREADS-core/threads CPU detected."
    fi

    if [ "`cat /proc/cpuinfo | grep Emotion | wc -l`" != 0 ]
    then
        print error "PlayStation 2 systems ARE NOT SUPPORTED anymoire since KFN v2.8. Please exit."
        exit
    fi

    if [ "`cat /proc/cpuinfo | grep Cell | wc -l`" != 0 ]
    then
        print warn "PlayStation 3 systems no longer have full KFN support since v3.0."
    fi

}

_cpu_bugs()
{
    if [ "`cat /proc/cpuinfo | grep bugs | wc -l`" != 0 ]
    then
        print warn "\e[33;1mHardware/silicon-level or microcode CPU issues/bugs found.\e[m\n         See: 'cat /proc/cpuinfo | grep bugs' for details."
    fi

    if [ "`cat /proc/cpuinfo | grep meltdown | wc -l`" != 0 ]
    then
        print warn "\e[33;1mHardware/silicon-level CPU critical issue found:\e[m Meltdown."
    fi

    if [ "`cat /proc/cpuinfo | grep spectre_v1 | wc -l`" != 0 ]
    then
        print warn "\e[33;1mHardware/silicon-level CPU critical issue found:\e[m Spectre v1."
    fi

    if [ "`cat /proc/cpuinfo | grep spectre_v2 | wc -l`" != 0 ]
    then
        print warn "\e[33;1mHardware/silicon-level CPU critical issue found:\e[m Spectre v2."
    fi

    if [ "`cat /proc/cpuinfo | grep l1tf | wc -l`" != 0 ]
    then
        print warn "\e[33;1mHardware/silicon-level CPU critical issue found:\e[m Foreshadow."
    fi

    if [ "`cat /proc/cpuinfo | grep spec_store_bypass | wc -l`" != 0 ]
    then
        print warn "\e[33;1mHardware/silicon-level CPU critical issue found:\e[m Speculative Store Bypass."
    fi
}

_extract() # Usage: _extract file_url
{
    FILENAME_TAR="$1"

    if [ -d "$SOURCE_DIR/$FILENAME_TAR" ]
    then
        print info "Deleting folder $SOURCE_DIR/$FILENAME_TAR..."
        rm -rf "$SOURCE_DIR/$FILENAME_TAR"
    fi

    mkdir -p "$SOURCE_DIR/$FILENAME_TAR"

    print info "Extracting package: $DOWNLOAD_DIR/$FILENAME_TAR"
    print info "Output folder: $SOURCE_DIR/$FILENAME_TAR"

    tar -xf "$DOWNLOAD_DIR/$FILENAME_TAR" -C "$SOURCE_DIR/$FILENAME_TAR"

    mv $SOURCE_DIR/$FILENAME_TAR/*/* "$SOURCE_DIR/$FILENAME_TAR"
}

_download() # Usage: _download http://site.com/file output_file_name
{
    URL_SOURCE="$1"
    FILENAME="$2"
    NAME=( ${URL_SOURCE//'/'/' '} )

    if [ ! -f "$DOWNLOAD_DIR/$FILENAME.md5" ]
    then
        if [ -f "$DOWNLOAD_DIR/$FILENAME" ]
        then
            rm "$DOWNLOAD_DIR/$FILENAME"
        fi

        if [ -f "$DOWNLOAD_DIR/$FILENAME.st" ]
        then
            rm "$DOWNLOAD_DIR/$FILENAME.st"
        fi

        axel -a --insecure "$URL_SOURCE" -o "$DOWNLOAD_DIR/$FILENAME"

        DOWNLOAD_STATUS="$?"

        if [ "$DOWNLOAD_STATUS" == 0 ]
        then
            if [ -f "$DOWNLOAD_DIR/$FILENAME" ]
            then
                MD5=( `md5sum "$DOWNLOAD_DIR/$FILENAME"` )

                print info "Download complete: $FILENAME: ${MD5[0]}"

                echo "${MD5[0]}" > "$DOWNLOAD_DIR/$FILENAME.md5"
            fi
        fi
    else
        print info "Skipping pre-downloaded and MD5 valided file: $FILENAME"
    fi

    if [ ! -f "$DOWNLOAD_DIR/$FILENAME" ]
    then
        print error "Error while downloading file. Status: $DOWNLOAD_STATUS.\nPress any key to continue.\n"
		read a
    fi
}

_check_dependencies()
{
	title

	echo -e "Searching for dependencies:\n"

	COUNTER_DEPENDENCIES=0
	COUNTER_MISSING=0
	MISSING_DEPENDENCIES=""
	DEPENDENCIES_TEXT=""

	INSTALLED_PACKAGES="`dpkg --get-selections`"

	while [ "x${DEPENDENCIES[$COUNTER_DEPENDENCIES]}" != "x" ]
	do
		PACKAGE="${DEPENDENCIES[$COUNTER_DEPENDENCIES]}"

		if [ "`echo $INSTALLED_PACKAGES | grep $PACKAGE | wc -l`" == "0" ]
		then
			#print error "$PACKAGE"
        	DEPENDENCIES_TEXT="$DEPENDENCIES_TEXT \e[31;1m$PACKAGE\e[m"

			MISSING_DEPENDENCIES="$MISSING_DEPENDENCIES $PACKAGE"
			COUNTER_MISSING=$(($COUNTER_MISSING+1))
		else
			#print ok "$PACKAGE"
        	DEPENDENCIES_TEXT="$DEPENDENCIES_TEXT \e[32;1m$PACKAGE\e[m"
		fi

		COUNTER_DEPENDENCIES=$(($COUNTER_DEPENDENCIES+1))
	done

	MISSING_DEPENDENCIES="${MISSING_DEPENDENCIES/' '/}"
	DEPENDENCIES_TEXT="`echo $DEPENDENCIES_TEXT`"

	echo -e "$DEPENDENCIES_TEXT\n"

	if [ $COUNTER_MISSING != 0 ]
	then
		ALL_DEPENDECIES_INSTALLED=0
	else
		ALL_DEPENDECIES_INSTALLED=1
	fi
}

_install_dependencies()
{
	
	echo -e "The following required dependencies are not installed:"
	echo -e "\n	\e[33;1m$MISSING_DEPENDENCIES\e[m \n"
	echo "Do you want to install the missing dependencies?"
	echo "Press ENTER to continue, Control + C to cancel."

	read a

	echo -e "OK, let's first update the apt-get package list. Enter the password, if prompted:\n"

	sudo apt-get update

	echo -e "\nNow, I'll try to install the dependencies. Please enter your password, if requested:\n"

	sudo apt-get install --no-install-recommends -y $MISSING_DEPENDENCIES

	echo -e "\nPress ENTER to continue."
	read a
}

_scan_dependencies()
{
	while [ $ALL_DEPENDECIES_INSTALLED == 0 ]
	do
		_install_dependencies
		_check_dependencies
	done
	
	print ok "All dependencies are currently installed." 
}

_detect_cflags()
{
	NATIVE=(`cc -march=native -E -v - </dev/null 2>&1 | grep " -march="`)

	COUNTER=0
	FOUND=0

	while [ "$FOUND" == 0 ]
	do
		if [ `echo "${NATIVE[$COUNTER]}" | grep 'march' | wc -l` == "1" ]
		then
			CFLAGS="${NATIVE[$COUNTER]}"
			FOUND=1
		else
			COUNTER=$(($COUNTER+1))
		fi
	done

	COUNTER=$(($COUNTER+1))
	FOUND=0

	while [ "x${NATIVE[$COUNTER]}" != "x" ]
	do
    	CFLAGS="$CFLAGS ${NATIVE[$COUNTER]}"
		COUNTER=$(($COUNTER+1))
	done
}

PROJECT_NAME="New project"
PROJECT_ARCH_TARGET="AMD64"
PROJECT_CONFIG_FILE="Create new file"
PROJECT_THREAD="Auto"

#dialog --stdout --title " $TITLE v$VERSION " --menu "$MAIN_TITLE" 30 60 0   "New project" "Creates a blank project" "Open project" "Select a .kfn file" 

#dialog --stdout --title " $TITLE v$VERSION " --menu "CFLAGS are arguments used to apply optimizations in the build to use the maximum performance of your processor. CFLAGS settings are not critical, however, use custom CFLAGS only if you know what you are doing. Otherwise, use Automatic to detect the CFLAGS of your processor." 13 60 20 "Automatic" "Detect CFLAGS" "Use custom CFLAGS" "AMD64"

#dialog --stdout --title " $TITLE v$VERSION " --menu "Edit project: $PROJECT_NAME" 20 50 20 "Project name" "New project" "Architecture" "AMD64" "Kernel config file" "Create new file" "Compiling: CPU Cores" "Auto (4 threads)" "CFLAGS/Optimizations" "Automatic" "Generate Kernel" "Yes" "Generate Initrd" "Yes"

_windows_subsystem_checker

_check_dependencies

_scan_dependencies

_cpu_cores

_cpu_bugs

_ram_check

_disk_usage

_tmp_rw_check

_source_rw_check

_detect_cflags

_vm_checker

_start

#dialog --stdout --title " $TITLE v$VERSION " --menu "$MAIN_TITLE" 20 50 0   "Arch" "AMD64" "Compiler" "GCC" "Threads" "Auto (4 threads)" "CFLAGS/Optimizations" "Automatic" 

_download "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.17.1.tar.xz" "linux-4.17.9876957"
_extract "linux-4.17.9876957"







