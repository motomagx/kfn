#!/bin/bash

# Kernel for Newbies
# The KFN Team

TITLE="Kernel for Newbies"
MAIN_TITLE="The multi-arch kernel compiler tool"
VERSION=3.0-alpha3+virt
FILE_FORMAT_VERSION=1
DEFAULT_KERNEL="6.0.0"
BASE_URL="https://cdn.kernel.org/pub/linux/kernel"
GITHUB_URL="https://raw.githubusercontent.com/motomagx/kfn/master/files/"
MAIN_DIR="$HOME/kfn"

BANNED_CHARS=( ':' ';' '@' '.' '"' "'" '?' '!' '#' '$' '%' '[' ']' '{' '}' '&' '<' '>' '=' ',' '`' )
BANNED_CHARS_PREFIX=( ${BANNED_CHARS[*]} '(' ')' )

# CFLAGS 

DEPENDENCIES[0]="alien autoconf axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g++ gcc gnupg2 gzip initramfs-tools libc6 libelf-dev libncurses libncurses5-dev  libiberty-dev libnotify-bin libssl-dev lzop make openssl pkg-config qemu tar wget"
#DEPENDENCIES[0]="alien autoconf axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g++ gcc gnupg2 gzip initramfs-tools kernel-package libc6 libelf-dev libncurses libncurses5-dev  libudev-dev libpci-dev libiberty-dev libnotify-bin libssl-dev lzop make openssl pkg-config qemu tar wget"

DEPENDENCIES[1]="dpkg-cross gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi" # ARM
DEPENDENCIES[2]="dpkg-cross gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" 	   # ARM64
DEPENDENCIES[3]="dpkg-cross gcc-multilib-i686-linux-gnu' gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" 	   # i686
DEPENDENCIES[4]="dpkg-cross gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi" 	   # powerpc

# Languages

_MENUCONFIG="menuconfig"
_XCONFIG="xconfig"
_DEFAULT="Default"
_PROJECT_PREFIX_CUSTOM="Custom"
_CUSTOM_PREFIX_ON="Enabled"
_CUSTOM_PREFIX_OFF="Disabled"
_GCC="GNU Compiler Collection"
_LLVM="Low Level Virtual Machine"
#_VMWARE_MACHINE="VMware ${_DEFAULT_VM_MACHINE[$LANGUAGE]}"
#_QEMU_MACHINE="QEMU ${_DEFAULT_VM_MACHINE[$LANGUAGE]}"
#_VIRTUALBOX_MACHINE="VirtualBox ${_DEFAULT_VM_MACHINE[$LANGUAGE]}"

MODULES=( cpu_cflags.kmod dialog_color_scheme.kmod languages.kmod qemu.kmod main.kmod )

MIN_DISK_CAPACITY_FREE=20 # Min of 20GB free in / is needed.
DEFAULT_TITLE=" $TITLE v$VERSION (under development) "

_set_language()
{
	SET_LANG=0

	while [ "$SET_LANG" == 0 ]
	do
		title

		echo -e "Selecione o idioma: Para Portugues (PT-BR), digite 0 e pressione ENTER."
		echo -e "Select language: For English (EN-US), type 1 and press ENTER."

		read LANGUAGE

		case "$LANGUAGE" in

			"0")
				SET_LANG=1 ;;
			"1")
				SET_LANG=1 ;;
			*)
				SET_LANG=0 ;;
		esac
	done

	echo "$LANGUAGE" > "$MAIN_DIR/language"
}

CROSS_CC=0

MicrosoftSystemID="Microsoft@Microsoft.com"
DOWNLOAD_DIR="$MAIN_DIR/downloads"
SOURCE_DIR="$MAIN_DIR/source"
BUILD_DIR="$MAIN_DIR/builds"
PROJECT_DIR="$MAIN_DIR/projects"
TEMP_DIR="$MAIN_DIR/temp"
LOG_DIR="$MAIN_DIR/logs"
MODULES_DIR="$MAIN_DIR/modules"
ALL_DEPENDECIES_INSTALLED=0
KFNTIME="`date +%d-%m-%y-%Hh%Mm%Ss`"

export DIALOGRC="$MAIN_DIR/dialog_color_scheme_black_and_green"

title()
{
	clear
	echo -e "\n\e[32;1m$TITLE $VERSION\n\e[m"
}


print()
{
	MODE="$1"
	TEXT="$2"

	if [ "$MODE" == "ok" ]
	then
		echo -e "\e[32;1m[ OK ]\e[m  $TEXT"
	fi

	if [ "$MODE" == "info" ]
	then
		echo -e "\e[32;1m[INFO]\e[m  $TEXT"
	fi

	if [ "$MODE" == "warn" ]
	then
		echo -e "\e[33;1m[WARN]\e[m  $TEXT"
	fi

	if [ "$MODE" == "error" ]
	then
		echo -e "\e[31;1m[ERRO]\e[m  $TEXT"
	fi

	echo "[$MODE] $TEXT" >> "$LOG_DIR/$KFNTIME.log"
}

_check_compatible_system()
{
	FILE="/etc/os-release"
	COMPATIBLE=0

	if [ ! -f "$FILE" ]
	then
		print error "${_OS_RELEASE_NOT_FOUND[$LANGUAGE]}"
	fi

	# Check systems
	CHECK=`cat $FILE | grep -m 1 -i debian | wc -l`
	if [ $CHECK == 1 ]
	then
		COMPATIBLE=1
	fi

	CHECK=`cat $FILE | grep -m 1 -i ubuntu | wc -l`
	if [ $CHECK == 1 ]
	then
		COMPATIBLE=1
	fi

	CHECK=`cat $FILE | grep -m 1 -i mint | wc -l`
	if [ $CHECK == 1 ]
	then
		COMPATIBLE=1
	fi

	NAME=`cat $FILE | grep -m 1 -i 'NAME='`
	NAME=${NAME//'NAME="'/}
	NAME=${NAME//'"'/}

	VERSION=`cat $FILE | grep -m 1 -i 'VERSION='`
	VERSION=${VERSION//'VERSION="'/}
	VERSION=${VERSION//'"'/}

	if [ $COMPATIBLE == 1 ]
	then
		print ok "${_COMPATIBLE_SYSTEM_FOUND[$LANGUAGE]} $NAME $VERSION"
	else
		print error "${_UNCOMPATIBLE_SYSTEM_FOUND[$LANGUAGE]} $NAME $VERSION"
	fi
}

_start()
{
	title

	if [ ! -f "$MAIN_DIR/language" ]
	then
		_set_language
	fi

	echo

	LANGUAGE=`cat $MAIN_DIR/language`

	#_dialog_scheme_files

	print info "${_SET_KFN_DIR[$LANGUAGE]} $MAIN_DIR"
	print info "${_DOWNLOADS[$LANGUAGE]} $DOWNLOAD_DIR"
	print info "${_SOURCE[$LANGUAGE]} $SOURCE_DIR"
	print info "${_BUILDS[$LANGUAGE]} $BUILD_DIR"
}

_disk_usage()
{
	DISK_USAGE=( `df / | grep dev` )
	DISK_USAGE=`echo "${DISK_USAGE[3]}/1024/1024" | bc`

	if [ $DISK_USAGE -lt $MIN_DISK_CAPACITY_FREE ]
	then
		print error "${_DISK_FREE_SPACE_P1[$LANGUAGE]} $DISK_USAGE ${_DISK_FREE_SPACE_P2[$LANGUAGE]}"
	else
		print ok "${_DISK[$LANGUAGE]} $DISK_USAGE ${_FREE_SPACE[$LANGUAGE]}"
	fi
}

_tmp_rw_check()
{
	RND_VALUE="$RANDOM"

	touch "/tmp/$RND_VALUE"

	if [ -f "/tmp/$RND_VALUE" ]
	then
		print ok "${_TMP_RW_ALLOWED[$LANGUAGE]}"
	else
		print error "${_TMP_RO_MSG[$LANGUAGE]}"  
	fi
}

_source_rw_check()
{
	RND_VALUE="$RANDOM"

	touch "/usr/src/$RND_VALUE" 2> /dev/null

	if [ -f "/usr/src/$RND_VALUE" ]
	then
		print ok "${_SRC_RO_MSG[$LANGUAGE]}"
	else
		print warn "${_SRC_RW_MSG[$LANGUAGE]}"
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
		print warn "RAM: $MEM_SIZE MB, ${_RECOMMENDED_RAM_SIZE[$LANGUAGE]}"
		#print info "PlayStation 3 Users: You can use Geforce VRAM (/dev/ps3da3) as a fast Swap partition."
	else
		print ok "RAM: $MEM_SIZE MB RAM + $SWAP_SIZE MB Swap."
	fi
}

_windows_subsystem_checker()
{
	WINDOWS_SUBSYSTEM="`cat /proc/version | grep $MicrosoftSystemID | wc -l`"

	if [ "$WINDOWS_SUBSYSTEM" != 0 ]
	then
		print error "$TITLE ${_WINDOWS_SUBSYSTEM_INCOMPATICLE_MSG[$LANGUAGE]}" 
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
		print warn "${_HYPER_V_MACHINE[$LANGUAGE]}"
		#exit
	fi

	if [ $QEMU_CHECK != 0 ]
	then
		print info "${_QEMU_MACHINE[$LANGUAGE]}"
	fi

	if [ $VMWARE_CHECK != 0 ]
	then
		print info "${_VMWARE_MACHINE[$LANGUAGE]}"
	fi

	if [ $VBOX_CHECK != 0 ]
	then
		print info "${_VIRTUALBOX_MACHINE[$LANGUAGE]}"
	fi
}

_cpu_cores()
{
	CPU_THREADS="`cat /proc/cpuinfo | grep processor | wc -l`"
	CPU_MODEL="`cat /proc/cpuinfo | grep "model name" | head -1`"
	CPU_MODEL="`echo $CPU_MODEL`"
	CPU_MODEL=${CPU_MODEL/"model name :"/}
	CPU_MODEL=${CPU_MODEL/" "/}

	print info "CPU: $CPU_MODEL"

	if [ $CPU_THREADS -lt 4 ]
	then
		print warn "${_SINGLE_CPU_MSG_P1[$LANGUAGE]} $CPU_THREADS ${_SINGLE_CPU_MSG_P2[$LANGUAGE]}"
	else
		print ok "${_CPU_MSG_P1[$LANGUAGE]} $CPU_THREADS ${_CPU_MSG_P2[$LANGUAGE]}"
	fi

	if [ "`cat /proc/cpuinfo | grep Emotion | wc -l`" != 0 ]
	then
		print error "${_LACK_OF_PS2_SUPPORT[$LANGUAGE]}"
		exit
	fi

	if [ "`cat /proc/cpuinfo | grep Cell | wc -l`" != 0 ]
	then
		print warn "${_LACK_OF_PS3_SUPPORT[$LANGUAGE]}"
	fi

	HOST_ARCH="`uname -m`"
}

_cpu_bugs()	
{
	if [ "`cat /proc/cpuinfo | grep bugs | wc -l`" != 0 ]
	then
		CPU_BUGS=`cat /proc/cpuinfo | grep bugs -m 1`
		CPU_BUGS=`echo $CPU_BUGS`
		CPU_BUGS=${CPU_BUGS/"bugs : "/"Bugs: "}

		print warn "\e[33;1m${_CPU_BUGS[$LANGUAGE]}\e[m\n\n		 \e[31;1m$CPU_BUGS\e[m\n		 ${_SEE[$LANGUAGE]}: 'cat /proc/cpuinfo | grep bugs' ${_CPU_BUGS_DETAILS[$LANGUAGE]}"
	fi
	
	}

_extract() # Usage: _extract file_url
{
	FILENAME_TAR="$1"

	if [ ! -f "$DOWNLOAD_DIR/$FILENAME_TAR" ]
	then
		dialog --title "$DEFAULT_TITLE" --msgbox "\n${_PKG_NOT_FOUND[$LANGUAGE]}\n" 9 65
	else
		mkdir -p "$PROJECT_LOCATION_FILES/kernel"

		print info "${_EXTRACTING_PACKAGES[$LANGUAGE]} $PROJECT_LOCATION_FILES"

		echo -e "\033[00;32m"
		tar -xvvf "$DOWNLOAD_DIR/$FILENAME_TAR" -C "$PROJECT_LOCATION_FILES/kernel"
		echo -e "\033[01;37m" 			

		EXTRACT_STATUS="$?"

		mv -u $PROJECT_LOCATION_FILES/kernel/*/* "$PROJECT_LOCATION_FILES/kernel"
		mv -u $PROJECT_LOCATION_FILES/kernel/*/.c* "$PROJECT_LOCATION_FILES/kernel"
		mv -u $PROJECT_LOCATION_FILES/kernel/*/.g* "$PROJECT_LOCATION_FILES/kernel"
		mv -u $PROJECT_LOCATION_FILES/kernel/*/.m* "$PROJECT_LOCATION_FILES/kernel"

		echo
		print info "${_ALL_FILES_EXTRACTED[$LANGUAGE]}"
		print ok "${_PRESS_ANY_KEY_TO_CONTINUE[$LANGUAGE]}"
		read a
	fi
}

_download()
{
	title

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

		print info "${_LOCAL_CACHE[$LANGUAGE]} $FILENAME\n"

		axel -a --insecure "$URL_SOURCE" -o "$DOWNLOAD_DIR/$FILENAME"

		DOWNLOAD_STATUS="$?"

		if [ "$DOWNLOAD_STATUS" == 0 ]
		then
			if [ -f "$DOWNLOAD_DIR/$FILENAME" ]
			then
				MD5=( `md5sum "$DOWNLOAD_DIR/$FILENAME"` )

				print info "${_DOWNLOAD_COMPLETE[$LANGUAGE]} $FILENAME: ${MD5[0]}"

				echo "${MD5[0]}" > "$DOWNLOAD_DIR/$FILENAME.md5"

				dialog --title "$DEFAULT_TITLE" --msgbox "\n${_DOWNLOAD_COMPLETE[$LANGUAGE]}: $FILENAME\nMD5: ${MD5[0]}" 8 75
			fi
		fi
	else
		MD5=( `md5sum "$DOWNLOAD_DIR/$FILENAME"` )
		dialog --title "$DEFAULT_TITLE" --msgbox "\n${_SKIP_VALID_DOWNLOAD[$LANGUAGE]}\n\n$FILENAME: $MD5" 10 70
	fi

	if [ ! -f "$DOWNLOAD_DIR/$FILENAME" ]
	then
		echo
		print error "${_ERROR_DOWNLOAD[$LANGUAGE]} $DOWNLOAD_STATUS"
		print info "${_PRESS_ANY_KEY_TO_CONTINUE[$LANGUAGE]}"
		read a
	fi
}

_check_dependencies()
{
	POSITION="$1"

	echo
	print info "${_SEARCHING_FOR_DEPENDENCIES[$LANGUAGE]}:\n"

	COUNTER_DEPENDENCIES=0
	COUNTER_MISSING=0
	MISSING_DEPENDENCIES=""
	DEPENDENCIES_TEXT=""

	DEPENDENCIES_CHECK=( ${DEPENDENCIES[$POSITION]} )

	INSTALLED_PACKAGES="`dpkg --get-selections`"

	while [ "x${DEPENDENCIES_CHECK[$COUNTER_DEPENDENCIES]}" != "x" ]
	do
		PACKAGE="${DEPENDENCIES_CHECK[$COUNTER_DEPENDENCIES]}"

		if [ "`echo $INSTALLED_PACKAGES | grep $PACKAGE | grep " install" | wc -l`" == "0" ]
		then
			#print error "$PACKAGE"
			DEPENDENCIES_TEXT="$DEPENDENCIES_TEXT \e[31;1m$PACKAGE\e[m"

			MISSING_DEPENDENCIES="$MISSING_DEPENDENCIES $PACKAGE"
			COUNTER_MISSING=$(($COUNTER_MISSING+1))
		else
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
	echo -e "${_DEPENDENCIES_NOT_INSTALLED[$LANGUAGE]}"
	echo -e "\n	\e[33;1m$MISSING_DEPENDENCIES\e[m\n"
	echo "${_ASK_INSTALL_DEPENDECIES[$LANGUAGE]}"
	echo "${_PRESS_ENTER_TO_CONTINUE_OR_CANCEL[$LANGUAGE]}"

	read a

	echo -e "${_UPDATE_APT_GET[$LANGUAGE]}\n"

	sudo apt-get update

	echo -e "\n${_INSTALL_DEPENDENCIES[$LANGUAGE]}\n"

	sudo apt-get install --no-install-recommends -y $MISSING_DEPENDENCIES
	sudo apt-get install bc dialog -y

	echo
	print info "${_PRESS_ENTER_TO_CONTINUE[$LANGUAGE]}"
	read a
}

_scan_dependencies()
{
	_check_dependencies "$1"

	while [ $ALL_DEPENDECIES_INSTALLED == 0 ]
	do
		_install_dependencies
		_check_dependencies "$1"
	done
	
	print ok "${_ALL_DEPENDENCIES_INSTALLED[$LANGUAGE]}" 
}

# Detect native CFLAGS from HOST CPU.
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

_preset_cflags_intel_64()
{
	SELECT=`dialog --stdout --title "$DEFAULT_TITLE" --menu "${_X86_64_TITLE[$LANGUAGE]}" 20 70 40 \
	"x86_64_generic" 	  	 "${_X86_64_CFLAGS[$LANGUAGE]}" \
	"x86_64_old_gen"		 "Old Intel 64 (Celeron/Pentium)" \
	"x86_64_old_gen_Core"	 "Old Intel Core 64 (Duo/Solo)" \
	"x86_64_1st_gen_Pentium"  "1st gen Celeron/Pentium Nehalem" \
	"x86_64_1st_gen_Core_r1"  "1st gen i3/i5/i7/Xeon Westmere" \
	"x86_64_1st_gen_Core_r2"  "1st gen i3/i5/i7/Xeon Nehalem" \
	"x86_64_2nd_gen_Pentium"  "2nd gen Celeron/Pentium Sandy Bridge" \
	"x86_64_2nd_gen_Core"	 "2nd gen i3/i5/i7/Xeon Sandy Bridge" \
	"x86_64_3rd_gen_Pentium"  "3rd gen Celeron/Pentium Ivy Bridge" \
	"x86_64_3rd_gen_Core"	 "3rd gen i3/i5/i7/Xeon Ivy Bridge" \
	"x86_64_4th_gen_Pentium"  "4th gen Celeron/Pentium Haswell" \
	"x86_64_4th_gen_Core"	 "4th gen i3/i5/i7/Xeon Haswell" \
	"x86_64_5th_gen_Pentium"  "5th gen Celeron/Pentium Broadwell" \
	"x86_64_5th_gen_Core"	 "5th gen i3/i5/i7/Xeon Broadwell" \
	"x86_64_6th_gen_Pentium"  "6th gen Celeron/Pentium Skylake" \
	"x86_64_6th_gen_Core"	 "6th gen i3/i5/i7/Xeon Skylake" \
	"x86_64_7th_gen_Pentium"  "7th gen Celeron/Pentium Kaby Lake" \
	"x86_64_7th_gen_Core"	 "7th gen i3/i5/i7/Xeon Kaby Lake" \
	"x86_64_8th_gen_Pentium"  "8th gen Celeron/Pentium Coffe Lake" \
	"x86_64_8th_gen_Core"	 "8th gen i3/i5/i7/Xeon Coffe Lake" \
	"x86_64_9th_gen_Pentium"  "9th gen Celeron/Pentium Cannon Lake" \
	"x86_64_9th_gen_Core"	 "9th gen i3/i5/i7/Xeon Cannon Lake" \
	"x86_64_10th_gen_Pentium" "10th gen Celeron/Pentium Ice Lake" \
	"x86_64_10th_gen_Core"	 "10th gen i3/i5/i7/Xeon Ice Lake" `

	SET_CFLAGS=${PRESET_CFLAGS[$SELECT]}
	SET_CHOST=${PRESET_CHOST[$SELECT]}
}

_preset_cflags_amd_64()
{
	TEST=`dialog --stdout --title "$DEFAULT_TITLE" --menu "${_DEFAULT_CFLAGS_TEXT[$LANGUAGE]} AMD AMD64 arch:" 20 80 40 \
	"AMD_K8_Core" "AMD K8 Sempron/Athlon/Phenom/Opteron" \
	"AMD_K10_Core" "AMD K10 Sempron II/Athlon II/Phenom II/Opteron II" \
	"AMD_Bulldozer_Core" "AMD Bulldozer" \
	"AMD_Bobcat_Core" "AMD Bobcat" \
	"AMD_Jaguar_Pluma_Core" "AMD Jaguar/Pluma/PS4/Xbox One" \
	"AMD_Zen_Core" "AMD Zen" `
}

_preset_cflags_ppc_64()
{
	TEST=`dialog --stdout --title "$DEFAULT_TITLE" --menu "${_DEFAULT_CFLAGS_TEXT[$LANGUAGE]} PowerPC 64 arch:" 15 60 40 \
	"ppc64_generic" "Generic PowerPC64 CFLAGS" \
	"ppc64_cell"	 "PlayStation 3 - Cell Broadband Engine" `
}

_select_arch()
{
	_PROJECT_VAR_ARCH_TMP="_PROJECT_VAR_ARCH"
	_PROJECT_VAR_ARCH_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "${_SELECT_TARGET_ARCH[$LANGUAGE]} $HOST_ARCH." 0 75 0 \
	"i386"	"Intel/AMD/VIA 32 bits (${_OLD_X86[$LANGUAGE]})" \
	"i686"	"Intel/AMD/VIA 32 bits (${_NEWER_X86[$LANGUAGE]})" \
	"x86_64"	"Intel/AMD/VIA 64 bits (${_ALSO_AMD64[$LANGUAGE]})" \
	"ia64"	"Intel Itanium 64 bits" \
	"arm"	"ARM 32 bits" \
	"arm64"	"ARM 64 bits" \
	"ppc"	"IBM/Motorola PowerPC 32 bits" \
	"ppc64"	"IBM/Sony PowerPC 64 bits" `

	if [ "x$_PROJECT_VAR_ARCH_TMP" != "x" ]
	then
		_PROJECT_VAR_ARCH="$_PROJECT_VAR_ARCH_TMP"
	fi

	case "$_PROJECT_VAR_ARCH_TMP" in

		"i386")
			dialog --title "$DEFAULT_TITLE" --msgbox "\n${_I386_SUPPORT_WARN[$LANGUAGE]}" 17 75 ;;
		"ia64")
			dialog --title "$DEFAULT_TITLE" --msgbox "\n${_IA64_SUPPORT_WARN[$LANGUAGE]}" 12 75 ;;
		"ppc64")
			dialog --title "$DEFAULT_TITLE" --msgbox "\n${_CELL_PS3_INFO[$LANGUAGE]}" 14 75 ;;
	esac
}

_input_text()
{
	READ_TEXT=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "$1" 0 40 "$2" )
	echo "$READ_TEXT"
}

# Save the project settings in the .kfn file:
_save_project_to_file()
{
	echo "# KFN Project file - https://github.com/motomagx/kfn" > "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "KFN_VERSION=$VERSION" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "FILE_FORMAT_VERSION=$FILE_FORMAT_VERSION" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "NAME=$_PROJECT_VAR_NAME" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "LOCATION_NAME=$LOCATION_NAME" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "TARGET_ARCH=$_PROJECT_VAR_ARCH" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "KERNEL_VERSION=$_PROJECT_VAR_KVERSION" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "CPU_THREADS=$_PROJECT_VAR_THREADS" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "SETUP_UTILITY=$_PROJECT_VAR_SETUP" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "COMPILER=$_PROJECT_VAR_COMPILER" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "CODE_OPTIMIZATION=$_PROJECT_VAR_OPTIMIZATION" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "PREFIX=$_PROJECT_VAR_PREFIX" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"
	echo "PREFIX_MODE=$_PROJECT_VAR_PREFIX_MODE" >> "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn"

	dialog --title "$DEFAULT_TITLE" --msgbox "\n$_SAVED_PROJECT $PROJECT_DIR/$_PROJECT_VAR_NAME.kfn" 7 75
}

# Save the project settings in the .kfn file:
_save_project()
{
	if [ "x$_PROJECT_VAR_NAME" != "x" ]
	then
		if [ -f "$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn" ]
		then
			dialog --title "$DEFAULT_TITLE" --yesno "\n${_OVERRIDE_FILE[$LANGUAGE]}\n\n$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn?" 9 75

			if [ "$?" == 0 ]
			then
				_save_project_to_file
			fi
		else
			_save_project_to_file
		fi
	else
		dialog --title "$DEFAULT_TITLE" --msgbox "\n${_TITLE_CANNOT_BE_EMPTY[$LANGUAGE]}" 7 50
	fi
}

# As the name says:
_detect_host_arch()
{
	SUPPORTED_HOST=1
	HOST_ARCH=`uname -m`

	case "$HOST_ARCH" in
		*)
			SUPPORTED_HOST=1 ;;
	esac
}

# Determines the number of tasks to be used when compiling the code:
_set_threads()
{
	THREAD_EXIT=0
	_PROJECT_VAR_THREADS_TMP=""

	while [ $THREAD_EXIT == 0 ]
	do
		_PROJECT_VAR_THREADS_TMP=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n${_SELECT_NUMBER_OF_THREADS[$LANGUAGE]} $CPU_THREADS threads.\n " 13 55 "${_PROJECT_VAR_THREADS[$LANGUAGE]}" )

		if [ $_PROJECT_VAR_THREADS_TMP -lt 0 ]
		then
			_PROJECT_VAR_THREADS_TMP=0
		fi

		case "x$_PROJECT_VAR_THREADS_TMP" in

			"x")
				dialog --title "$DEFAULT_TITLE" --msgbox "\n${_THREADS_CANNOT_BE_EMPTY[$LANGUAGE]}" 7 50 ;;
			"x0")
				dialog --title "$DEFAULT_TITLE" --msgbox "\n${_THREADS_CANNOT_BE_ZERO[$LANGUAGE]}" 9 60 ;;
			*)
				_PROJECT_VAR_THREADS="$_PROJECT_VAR_THREADS_TMP"
				THREAD_EXIT=1
		esac
	done
}

# Allows the user to set the project name:
_set_project_name()
{
	NAME_EXIT=0
	_PROJECT_VAR_NAME_TMP=""

	while [ $NAME_EXIT == 0 ]
	do
		_PROJECT_VAR_NAME_TMP=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n${_SET_PROJECT_NAME[$LANGUAGE]}" 10 55 "$_PROJECT_VAR_NAME" )

		COUNTER=0

		while [ "x${BANNED_CHARS[$COUNTER]}" != "x" ]
		do
			BAN_CHAR="${BANNED_CHARS[$COUNTER]}"
			_PROJECT_VAR_NAME_TMP=`echo "$_PROJECT_VAR_NAME_TMP" | tr --delete "$BAN_CHAR"`
			COUNTER=$(($COUNTER+1))
		done

		_PROJECT_VAR_NAME_TMP=$_PROJECT_VAR_NAME_TMP//'*'/}
		_PROJECT_VAR_NAME_TMP=$_PROJECT_VAR_NAME_TMP//'\'/}
		_PROJECT_VAR_NAME_TMP=$_PROJECT_VAR_NAME_TMP//'/'/}
		_PROJECT_VAR_NAME_TMP=$_PROJECT_VAR_NAME_TMP//'|'/}

		if [ "x$_PROJECT_VAR_NAME_TMP" == "x" ]
		then
			dialog --title "$DEFAULT_TITLE" --msgbox "\n${_TITLE_CANNOT_BE_EMPTY[$LANGUAGE]}" 7 50
		else
			_PROJECT_VAR_NAME="$_PROJECT_VAR_NAME_TMP"
			NAME_EXIT=1
		fi
	done
}

# Allows the user to define a custom kernel prefix:
_set_project_prefix()
{
	PREFIX_EXIT=0
	_PROJECT_VAR_PREFIX_TMP=""

	while [ $PREFIX_EXIT == 0 ]
	do
		_PROJECT_VAR_PREFIX_TMP=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n${_SET_PROJECT_PREFIX[$LANGUAGE]}\n " 15 70 "$_PROJECT_VAR_PREFIX" )

		COUNTER=0

		while [ "x${BANNED_CHARS[$COUNTER]}" != "x" ]
		do
			BAN_CHAR="${BANNED_CHARS[$COUNTER]}"
			_PROJECT_VAR_PREFIX_TMP=`echo "${PROJECT_VAR_PREFIX_TMP" | tr --delete "$BAN_CHAR"`
			COUNTER=$(($COUNTER+1))
		done

		_PROJECT_VAR_PREFIX_TMP=$_PROJECT_VAR_PREFIX_TMP//'*'/}
		_PROJECT_VAR_PREFIX_TMP=$_PROJECT_VAR_PREFIX_TMP//'\'/}
		_PROJECT_VAR_PREFIX_TMP=$_PROJECT_VAR_PREFIX_TMP//'/'/}
		_PROJECT_VAR_PREFIX_TMP=$_PROJECT_VAR_PREFIX_TMP//'|'/}

		if [ "x$_PROJECT_VAR_PREFIX_TMP" == "x" ]
		then
			dialog --title "$DEFAULT_TITLE" --msgbox "\n${_PREFIX_CANNOT_BE_EMPTY[$LANGUAGE]}" 7 50
		else
			_PROJECT_VAR_PREFIX="$_PROJECT_VAR_PREFIX_TMP"
			PREFIX_EXIT=1
		fi
	done
}

_select_config_mode()
{
	CONFIG_MODE_TMP="$_PROJECT_VAR_SETUP"
	CONFIG_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n${_SELECT_CONFIG_MODE[$LANGUAGE]}" 9 55 0 \
	"${_MENUCONFIG[$LANGUAGE]}" "${_TEXT_MODE[$LANGUAGE]}" \
	"${_XCONFIG[$LANGUAGE]}" "${_GRAFICAL_MODE[$LANGUAGE]}" `

	if [ "x$CONFIG_MODE_TMP" != "x" ]
	then
		_PROJECT_VAR_SETUP="$CONFIG_MODE_TMP"
	fi
}

_select_prefix_mode()
{
	CONFIG_PREFIX_TMP="$_PROJECT_VAR_PREFIX_MODE"
	CONFIG_PREFIX_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n${_CUSTOM_PREFIX_TXT[$LANGUAGE]}\n " 11 70 0 \
	"${_CUSTOM_PREFIX_OFF[$LANGUAGE]}" "${_CUSTOM_PREFIX_OFF_TXT[$LANGUAGE]}" \
	"${_CUSTOM_PREFIX_ON[$LANGUAGE]}" "${_CUSTOM_PREFIX_ON_TXT[$LANGUAGE]}" `

	if [ "x$CONFIG_PREFIX_TMP" != "x" ]
	then
		_PROJECT_VAR_PREFIX_MODE="$CONFIG_PREFIX_TMP"

		if [ "$CONFIG_PREFIX_TMP" == "${_CUSTOM_PREFIX_ON[$LANGUAGE]}" ]
		then
			_set_project_prefix
		fi
	fi
}

_main_menu()
{
	CONFIG_MODE_TMP="$_PROJECT_VAR_SETUP"
	CONFIG_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "${_SELECT_CONFIG_MODE[$LANGUAGE]}" 7 45 0 \
	"${_ABOUT_KFN[$LANGUAGE]}" "${_TEXT_MODE[$LANGUAGE]}" \
	"${_ABOUT_KFN[$LANGUAGE]}" "${_ABOUT_KFN_MSG[$LANGUAGE]}" `

	if [ "x$CONFIG_MODE_TMP" != "x" ]
	then
		_PROJECT_VAR_SETUP="$CONFIG_MODE_TMP"
	fi
}

_gen_location_name()
{
	COUNTER=0
	LOCATION_NAME="$_PROJECT_VAR_NAME"

	while [ "x${BANNED_CHARS[$COUNTER]}" != "x" ]
	do
		BAN_CHAR="${BANNED_CHARS[$COUNTER]}"
		LOCATION_NAME=`echo "$LOCATION_NAME" | tr --delete "$BAN_CHAR"`
		COUNTER=$(($COUNTER+1))
	done

	LOCATION_NAME=${LOCATION_NAME//'*'/}
	LOCATION_NAME=${LOCATION_NAME//'\'/}
	LOCATION_NAME=${LOCATION_NAME//'/'/}
	LOCATION_NAME=${LOCATION_NAME//'|'/}
	LOCATION_NAME=${LOCATION_NAME//' '/'_'}
}

_location_build_info()
{
	dialog --title "$DEFAULT_TITLE" --msgbox "\n${_PROJECT_LOCATION_TXT[$LANGUAGE]}\n\n$BUILD_DIR/$LOCATION_NAME/" 9 65
}

_extract_project()
{
	mkdir -p "$PROJECT_LOCATION_FILES"
	mkdir -p "$PROJECT_LOCATION_FILES/kernel"
	mkdir -p "$PROJECT_LOCATION_FILES/packages"

	CHECK_EMPTY_FOLDER="`ls -A $PROJECT_LOCATION_FILES/kernel | wc -l`"
	CONTINUE_EXTRACT=1

	if [ "$CHECK_EMPTY_FOLDER" != 0 ]
	then
		dialog --title "$DEFAULT_TITLE" --yesno "\n${_FOLDER_IS_NOT_EMPTY[$LANGUAGE]}\n\n$PROJECT_LOCATION_FILES\n\n${_CONTINUE_TO_EMPTY_DIR[$LANGUAGE]}" 12 75
		if [ "$?" == 0 ]
		then
			title

			echo -e "\033[00;31m"
			rm -rfv $PROJECT_LOCATION_FILES/
			mkdir "$PROJECT_LOCATION_FILES"
			mkdir "$PROJECT_LOCATION_FILES/kernel"
			mkdir "$PROJECT_LOCATION_FILES/packages"
			echo -e "\033[01;37m" 
		else
			CONTINUE_EXTRACT=0
		fi
	fi

	if [ $CONTINUE_EXTRACT == 1 ]
	then
		title
		_extract "linux-$_PROJECT_VAR_KVERSION"
	fi
}

_clean_files()
{
	if [ ! -d "$PROJECT_LOCATION_FILES" ]
	then
		dialog --title "$DEFAULT_TITLE" --msgbox "\n${_PROJECT_FOLDER_EMPTY_ERROR[$LANGUAGE]}" 9 70
	else
		title
		print info "${_CLEAN_MAKE_FILES[$LANGUAGE]}\n"
		ACTUAL_DIR="`pwd`"
		cd "$PROJECT_LOCATION_FILES/kernel/"
		make clean
		cd "$ACTUAL_DIR"
	fi
}

_start_build()
{
	if [ ! -f "$PROJECT_LOCATION_FILES/kernel/.config" ]
	then
		dialog --title "$DEFAULT_TITLE" --msgbox "\n${_CONFIG_NOT_FOUND[$LANGUAGE]}" 8 75
	else
		title
		print info "${_START_BUILD[$LANGUAGE]} $_PROJECT_VAR_ARCH ${CROSS_COMPILATION_INFO[$LANGUAGE]}"
		print info "${_COMPILER[$LANGUAGE]}: ${_PROJECT_VAR_COMPILER[$LANGUAGE]} ($COMPILER_NAME)"
		print info "${_KERNEL_VERSION[$LANGUAGE]}: $_PROJECT_VAR_KVERSION"
		print info "Using CPU CFLAGS: Yes"
		echo

		CPU_TASK="$(($CPU_THREADS+2))"

		DEFAULT_CA="--initrd kernel_image kernel_headers"
		DEFAULT_CA2="kernel_image kernel_headers"
		ACTUAL_DIR="`pwd`"

		cd "$PROJECT_LOCATION_FILES/kernel/"

		if [ "$_PROJECT_VAR_PREFIX_MODE" == "${_CUSTOM_PREFIX_ON[$LANGUAGE]}" ]
		then
			PROJECT_PREFIX="--append-to-version=-$_PROJECT_VAR_PREFIX"
		else
			PROJECT_PREFIX=""
		fi

		if [ "$CROSS_CC" == 0 ]
		then
			# Compile for host arch:

			export CFLAGS="$CFLAGS"
			export CXXFLAGS="$CFLAGS"

			# This line makes the magic:
			make deb-pkg -j $CPU_TASK $PROJECT_PREFIX CFLAGS="$CFLAGS"
		else

			# Compile for i686 processor:

			if [ "$_PROJECT_VAR_ARCH" == "arm64" ]
			then
				ARCH_PREFIX="ARCH=arm64"
				CROSS_COMPILE_ARCH="CROSS_COMPILE=aarch64-linux-gnu-"
			fi

			# Compile for arm processor:

			if [ "$_PROJECT_VAR_ARCH" == "arm" ]
			then
				ARCH_PREFIX="ARCH=arm"
				CROSS_COMPILE_ARCH="CROSS_COMPILE=arm-linux-gnueabihf-"
			fi

			# Compile for arm64 processor:

			if [ "$_PROJECT_VAR_ARCH" == "arm64" ]
			then
				ARCH_PREFIX="ARCH=arm64"
				CROSS_COMPILE_ARCH="CROSS_COMPILE=aarch64-linux-gnu-"
			fi

			# Compile for powerpc processor:

			if [ "$_PROJECT_VAR_ARCH" == "ppc" ]
			then
				ARCH_PREFIX="ARCH=arm64"
				CROSS_COMPILE_ARCH="CROSS_COMPILE=aarch64-linux-gnu-"
			fi

			# This line makes the magic:
			make deb-pkg -j $CPU_TASK $ARCH_PREFIX $CROSS_COMPILE_ARCH $PROJECT_PREFIX
		fi

		STATUS="$?"

		# Print error
		if [ "$STATUS" != 0 ]
		then
			echo -e "\n"

			# Very incomplete list:

			case "$STATUS" in
				"2")   print error "${_EXIT_BY_ERROR $STATUS[$LANGUAGE]}: ${_NO_SPACE_IN_DISK[$LANGUAGE]}" ;;
				"130") print error "${_EXIT_BY_ERROR $STATUS[$LANGUAGE]}: ${_CANCELLED_BY_USER[$LANGUAGE]}" ;;
				"255") print error "${_EXIT_BY_ERROR $STATUS[$LANGUAGE]}: ${_CANCELLED_BY_USER[$LANGUAGE]}" ;;
				*)     print error "${_EXIT_BY_ERROR $STATUS[$LANGUAGE]}: ${_UNKNOWN[$LANGUAGE]}" ;;
			esac

			print info "${_PRESS_ANY_KEY_TO_CONTINUE[$LANGUAGE]}"
			read a
		else
			mkdir -p "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/"

			mv $PROJECT_LOCATION_FILES/*.deb "$PROJECT_LOCATION_FILES/packages/"

			mv $PROJECT_LOCATION_FILES/packages/linux-headers* "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/linux-headers-$_PROJECT_VAR_KVERSION-$_PROJECT_VAR_ARCH.deb"

			mv $PROJECT_LOCATION_FILES/packages/linux-image* "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/linux-image-$_PROJECT_VAR_KVERSION-$_PROJECT_VAR_ARCH.deb"

			echo

			if [ ! -f "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/linux-image-$_PROJECT_VAR_KVERSION-$_PROJECT_VAR_ARCH.deb" ]
			then
				print error "${_EXIT_BY_ERROR[$LANGUAGE]} $STATUS: ${_UNKNOWN[$LANGUAGE]}"
			else
				print info "${_COMPILATION_COMPLETED_SUCESSFULLY[$LANGUAGE]} $STATUS"
			fi

			print info "${_PRESS_ANY_KEY_TO_CONTINUE[$LANGUAGE]}"
			read a
		fi

		cd "$ACTUAL_DIR"
	fi
}

_manage_config_file()
{
	if [ ! -f "$PROJECT_LOCATION_FILES/kernel/Makefile" ]
	then
		dialog --title "$DEFAULT_TITLE" --msgbox "\n${_PROJECT_FOLDER_EMPTY_ERROR[$LANGUAGE]}" 9 70
	else
		title

		ACTUAL_DIR="`pwd`"

		cd "$PROJECT_LOCATION_FILES/kernel/"

		if [ "$CROSS_CC" == 0 ]
		then
			print info "${_KERNEL_SETUP_UTILITY[$LANGUAGE]}\n"

			if [ "${_PROJECT_VAR_SETUP[$LANGUAGE]}" == "${_MENUCONFIG[$LANGUAGE]}" ]
			then
				make menuconfig
			else
				make xconfig
			fi
		else
			print info "${_KERNEL_SETUP_UTILITY[$LANGUAGE]} ($_PROJECT_VAR_ARCH)\n"

			if [ "$_PROJECT_VAR_SETUP" == "$_MENUCONFIG" ]
			then
				case "$_PROJECT_VAR_ARCH" in
					"x86_64") ARCH=arm make menuconfig ;;
					"arm") 	ARCH=arm make menuconfig ;;
					"arm64") 	ARCH=arm64 make menuconfig ;;
				esac
			else
				case "$_PROJECT_VAR_ARCH" in
					"x86_64") ARCH=arm make xconfig ;;
					"arm") 	ARCH=arm make xconfig ;;
					"arm64") 	ARCH=arm64 make xconfig ;;
				esac
			fi
		fi

		cd "$ACTUAL_DIR"

		if [ ! -f "$PROJECT_LOCATION_FILES/kernel/.config" ]
		then
			dialog --title "$DEFAULT_TITLE" --msgbox "\n${_CONFIG_NOT_FOUND[$LANGUAGE]}" 8 75
		fi
	fi
}

_gen_kernel_version()
{
	_PROJECT_VAR_KVERSION_NEW=( ${_PROJECT_VAR_KVERSION//"."/" "} )

	KERNEL_VERSION="${_PROJECT_VAR_KVERSION_NEW[0]}"
	KERNEL_SUBVERSION="${_PROJECT_VAR_KVERSION_NEW[1]}"

	if [ "${_PROJECT_VAR_KVERSION_NEW[2]}" == 0 ]
	then
		_PROJECT_VAR_KVERSION_NEW[2]=""
	fi

	if [ "x${_PROJECT_VAR_KVERSION_NEW[2]}" == "x" ]
	then
		KERNEL_REVISION=0
		KERNEL_VERSION_NUMBER="$KERNEL_VERSION.$KERNEL_SUBVERSION"
	else
		KERNEL_REVISION="${_PROJECT_VAR_KVERSION_NEW[2]}"
		KERNEL_VERSION_NUMBER="$KERNEL_VERSION.$KERNEL_SUBVERSION.$KERNEL_REVISION"
	fi
}

_download_package()
{
	if [ $KERNEL_VERSION -lt "3" ]
	then
		_download "https://cdn.kernel.org/pub/linux/kernel/v$KERNEL_VERSION.$KERNEL_SUBVERSION/linux-$KERNEL_VERSION.$KERNEL_SUBVERSION.$KERNEL_REVISION.tar.bz2" "linux-$_PROJECT_VAR_KVERSION"
	else
		_download "https://cdn.kernel.org/pub/linux/kernel/v$KERNEL_VERSION.x/linux-$KERNEL_VERSION_NUMBER.tar.xz" "linux-$_PROJECT_VAR_KVERSION"
	fi
}

_compiler_mode()
{
	COMPILER_MODE_TMP="${_COMPILER_TXT[$LANGUAGE]}"
	MODE="$1"

	if [ "$MODE" == 0 ]
	then
		COMPILER_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n${_COMPILER_TXT[$LANGUAGE]} $_PROJECT_VAR_ARCH:" 9 60 0 \
		"gcc" "$_GCC" `
	else
		COMPILER_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n${_COMPILER_TXT[$LANGUAGE]} $_PROJECT_VAR_ARCH:" 9 60 0 \
		"gcc"  "$_GCC" \
		"llvm" "$_LLVM (TODO)" `
	fi

	if [ "x$COMPILER_MODE_TMP" != "x" ]
	then
		_PROJECT_VAR_COMPILER="$COMPILER_MODE_TMP"
	fi
}

_select_compiler()
{
	# LLVM has official kernel compatibility with x86 and x86 based and limited with other architectures

	case "$_PROJECT_VAR_ARCH" in
		"i386")   _compiler_mode 1 ;;
		"i686")   _compiler_mode 1 ;;
		"x86_64") _compiler_mode 1 ;;
		*)  _compiler_mode 0 ;;
	esac
}

_check_compiler()
{
	# LLVM has official kernel compatibility with x86 and x86 based and limited with other architectures

	case "$_PROJECT_VAR_ARCH" in
		"ia64")   _PROJECT_VAR_COMPILER="gcc" ;;
		"arm")    _PROJECT_VAR_COMPILER="gcc" ;;
		"arm64")  _PROJECT_VAR_COMPILER="gcc" ;;
		"ppc")    _PROJECT_VAR_COMPILER="gcc" ;;
		"ppc64")  _PROJECT_VAR_COMPILER="gcc" ;;
	esac
}

_exit()
{	
	echo -e "\n"
	print info "${_SEE_YOU_SOON[$LANGUAGE]}\n"
	exit
}

_get_kernel_version()
{

	_SELECT_KERNEL_VERSION="Selecione a versao do Kernel a ser compilada.\nVoce pode verificar a versao mais recente em Kernel.org."

	_PROJECT_VAR_KVERSION=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n${_SELECT_KERNEL_VERSION[$LANGUAGE]}\n " 13 60 "$_PROJECT_VAR_KVERSION" )

	_gen_kernel_version
}


_main_setup()
{
	MODE=$1

	if [ $MODE == "new" ]
	then
		_PROJECT_VAR_ARCH="`uname -m`"
		_PROJECT_VAR_NAME="$_NEW_PROJECT"
		_PROJECT_VAR_PREFIX="custom"
		_PROJECT_VAR_COMPILER="gcc"
		_PROJECT_VAR_PREFIX_MODE="$_CUSTOM_PREFIX_OFF"
		_PROJECT_VAR_KVERSION="$DEFAULT_KERNEL"
		_PROJECT_VAR_THREADS="$CPU_THREADS"
		_PROJECT_VAR_SETUP="$_MENUCONFIG"
		_PROJECT_VAR_OPTIMIZATION="$_DEFAULT"
	fi

	SETUP_EXIT=0

	while [ $SETUP_EXIT == 0 ]
	do
		_gen_kernel_version
		_gen_location_name
		_check_compiler

		if [ "$_PROJECT_VAR_PREFIX_MODE" == "${_CUSTOM_PREFIX_ON[$LANGUAGE]}" ]
		then
			PREFIX_OUTPUT=" ("'"'"Linux $_PROJECT_VAR_KVERSION-$_PROJECT_VAR_PREFIX"'"'")"
		else
			PREFIX_OUTPUT=""
		fi

		if [ "$_PROJECT_VAR_COMPILER" == "gcc" ]
		then
			COMPILER_NAME="$_GCC"
		else
			COMPILER_NAME="$_LLVM"
		fi

		PROJECT_LOCATION_FILES="$BUILD_DIR/$LOCATION_NAME"

		if [ "`uname -m`" != "$_PROJECT_VAR_ARCH" ]
		then
			CROSS_COMPILATION_INFO=" $_CROSS_COMPILATION_INFO"
			CROSS_CC=1
		else
			CROSS_COMPILATION_INFO=""
			CROSS_CC=0
		fi

		export CFLAGS="$CFLAGS"
		export CXXFLAGS="$CFLAGS"

		SELECT_SETUP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_PROJECT_TITLE $_PROJECT_VAR_NAME" 26 0 40 \
		"${_PROJECT_NAME[$LANGUAGE]}" "$_PROJECT_VAR_NAME" \
		"${_PROJECT_KERNEL[$LANGUAGE]}" "$_PROJECT_VAR_KVERSION" \
		"${_PROJECT_ARCH[$LANGUAGE]}" "$_PROJECT_VAR_ARCH$CROSS_COMPILATION_INFO" \
		"${_PROJECT_OPTM[$LANGUAGE]}" "$_PROJECT_VAR_OPTIMIZATION" \
		"${_COMPILER[$LANGUAGE]}" "$_PROJECT_VAR_COMPILER ($COMPILER_NAME)" \
		"${_PROJECT_PREFIX[$LANGUAGE]}" "$_PROJECT_VAR_PREFIX_MODE$PREFIX_OUTPUT" \
		"${_PROJECT_THREADS[$LANGUAGE]}" "$_PROJECT_VAR_THREADS ${_THREADS[$LANGUAGE]}" \
		"${_PROJECT_CONFIGURATION[$LANGUAGE]}" "$_PROJECT_VAR_SETUP" \
		"" "" \
		"${_PROJECT_LOCATION_BUILD[$LANGUAGE]}" "$BUILD_DIR/$LOCATION_NAME[$LANGUAGE]}/" \
		"${_PROJECT_SAVE[$LANGUAGE]}" "${_PROJECT_SAVE_CHANGES[$LANGUAGE]}" \
		"" "" \
		"${_DOWNLOAD_KERNEL_FILES[$LANGUAGE]}" "${_DOWNLOAD_KERNEL_FILES_TXT[$LANGUAGE]}" \
		"${_EXTRACT_KERNEL_FILES[$LANGUAGE]}" "${_CREATE_LOCAL_FILES[$LANGUAGE]}" \
		"${_CLEAN_TEMPORARY_FILES[$LANGUAGE]}" "${_CLEAN_TEMPORARY_FILES_TXT[$LANGUAGE]}" \
		"${_GENERATE_CONFIG_FILE[$LANGUAGE]}" "${_GENERATE_CONFIG_FILE_TXT[$LANGUAGE]}" \
		"${_PROJECT_START_BUILD[$LANGUAGE]}" "${_PROJECT_START_BUILD_TXT[$LANGUAGE]}" \
		"" "" \
		"6. Sair" "Cancela as alteracoes e sai do KFN." `

		case "$SELECT_SETUP" in

			"${_PROJECT_KERNEL[$LANGUAGE]}")
				_get_kernel_version ;;

			"${_DOWNLOAD_KERNEL_FILES[$LANGUAGE]}")
				_download_package ;;

			"${_PROJECT_START_BUILD[$LANGUAGE]}")
				_start_build ;;

			"${_CLEAN_TEMPORARY_FILES[$LANGUAGE]}")
				_clean_files ;;

			"${_EXTRACT_KERNEL_FILES[$LANGUAGE]}")
				_extract_project ;;

			"${_PROJECT_PREFIX[$LANGUAGE]}")
				_select_prefix_mode ;;

			"${_PROJECT_NAME[$LANGUAGE]}")
				_set_project_name ;;

			"${_PROJECT_THREADS[$LANGUAGE]}")
				_set_threads ;;

			"${_PROJECT_ARCH[$LANGUAGE]}")
				_select_arch ;;

			"${_PROJECT_SAVE[$LANGUAGE]}")
				_save_project ;;

			"${_COMPILER[$LANGUAGE]}")
				_select_compiler ;;

			"${_PROJECT_CONFIGURATION[$LANGUAGE]}")
				_select_config_mode ;;

			"${_GENERATE_CONFIG_FILE[$LANGUAGE]}")
				_manage_config_file ;;

			"${_PROJECT_LOCATION_BUILD[$LANGUAGE]}")
				_location_build_info ;;

			"6. Sair")
				_exit ;;

		esac
	done
}

_run()
{
	_start

	_scan_dependencies 0

	#_windows_subsystem_checker

	echo

	_check_compatible_system

	print info "System: `uname` `uname -r` (`dpkg --print-architecture`/`getconf LONG_BIT` bits)"

	_cpu_cores

	_ram_check

	_disk_usage

	_tmp_rw_check

	_source_rw_check

	_detect_cflags

	_vm_checker

	_cpu_bugs

	echo -e "\e[32;1m\n ${_ALL_READY[$LANGUAGE]}\e[m"
	read a

	_main_setup new
}



