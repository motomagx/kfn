#!/bin/bash

# Kernel for Newbies
# The KFN Team

TITLE="Kernel for Newbies"
MAIN_TITLE="The multi-arch kernel compiler tool"
VERSION=3.0-alpha1
FILE_FORMAT_VERSION=1
DEFAULT_KERNEL="4.20.3"
BASE_URL="https://cdn.kernel.org/pub/linux/kernel"

BANNED_CHARS=( ':' ';' '@' '.' '"' "'" '?' '!' '#' '$' '%' '[' ']' '{' '}' '&' '<' '>' '=' ',' '`' )
BANNED_CHARS_PREFIX=( ${BANNED_CHARS[*]} '(' ')' )

PRESET_CHOST[PowerPC64_Cell]="powerpc-unknown-linux-gnu"

PRESET_CHOST[x86_64_atom]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_atom]="-march=nehalem -O2 -pipe"

PRESET_CHOST[x86_64_old_gen_Core]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_old_gen_Core]="-march=core2 -O2 -pipe"
PRESET_CHOST[x86_64_old_gen_Pentium]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_old_gen_Pentium]="-march=core2 -O2 -pipe"

PRESET_CHOST[x86_64_1st_gen_Core_r1]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_1st_gen_Core_r1]="-march=westmere -O2 -pipe"
PRESET_CHOST[x86_64_1st_gen_Pentium_r1]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_1st_gen_Pentium_r1]="-march=westmere -O2 -pipe"

PRESET_CHOST[x86_64_1st_gen_Core_r2]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_1st_gen_Core_r2]="-march=nehalem -O2 -pipe"
PRESET_CHOST[x86_64_1st_gen_Pentium_r2]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_1st_gen_Pentium_r2]="-march=nehalem -O2 -pipe"

PRESET_CHOST[x86_64_2nd_gen_Core]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_2nd_gen_Core]="-march=sandybridge -O2 -pipe"
PRESET_CHOST[x86_64_2nd_gen_Pentium]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_2nd_gen_Pentium]="-march=sandybridge -mno-avx -mno-aes -mno-rdrnd -O2 -pipe"

PRESET_CHOST[x86_64_3rd_gen_Core]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_3rd_gen_Core]="-march=ivybridge -O2 -pipe"
PRESET_CHOST[x86_64_3rd_gen_Pentium]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_3rd_gen_Pentium]="-march=ivybridge -mno-avx -mno-aes -mno-rdrnd -O2 -pipe"

PRESET_CHOST[x86_64_4th_gen_Core]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_4th_gen_Core]="-march=haswell -O2 -pipe"
PRESET_CHOST[x86_64_4th_gen_Pentium]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_4th_gen_Pentium]="-march=haswell -O2 -pipe"

PRESET_CHOST[x86_64_6th_gen_Core]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_6th_gen_Core]="-march=skylake -O2 -pipe"
PRESET_CHOST[x86_64_6th_gen_Pentium]="x86_64_pc-linux-gnu"
PRESET_CFLAGS[x86_64_6th_gen_Pentium]="-march=native"

DEPENDENCIES[0]="alien axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g++ gcc gnupg2 gzip initramfs-tools kernel-package libc6 libelf-dev libncurses libncurses5-dev libnotify-bin libssl-dev lzop make pkg-config qt5-default tar wget"
DEPENDENCIES[1]="dpkg-cross gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi" # ARM
DEPENDENCIES[2]="dpkg-cross gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" 	   # ARM64
DEPENDENCIES[3]="dpkg-cross gcc-multilib-i686-linux-gnu' gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" 	   # i686
DEPENDENCIES[4]="dpkg-cross gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi" 	   # powerpc

MIN_DISK_CAPACITY_FREE=20 # Min of 15GB free in / is needed.
DEFAULT_TITLE=" $TITLE v$VERSION (under development) "

_set_language()
{
	SET_LANG=0

	while [ "$SET_LANG" == 0 ]
	do
		title

		echo -e "Para Portugues (PT-BR), digite 1 e pressione ENTER."
		echo -e "For English (EN-US), type 2 and press ENTER."

		read SELECT_LANGUAGE

		case "$SELECT_LANGUAGE" in

			"1")
				SET_LANG=1 ;;
			"2")
				SET_LANG=1 ;;
			*)
				SET_LANG=0 ;;
		esac
	done

	echo "$SELECT_LANGUAGE" > "$HOME/kfn/language"
}

_load_language()
{
	if [ "$SELECT_LANGUAGE" == "1" ]
	then
		_COMPILER="Compilador"
		_COMPILER_TXT="Compiladores disponívels para"
		_LOCAL_CACHE="Não há cache do pacote do Kernel criado. Realizando download do pacote"
		_ALL_FILES_EXTRACTED="Todos os arquivos foram extraídos com sucesso."
		_UNKNOWN_ERROR="Saindo devido ao erro desconhecido:"
		_EXIT_BY_ERROR="Saindo pelo erro"
		_RECOMMENDED_RAM_SIZE="Recomendado: >= 4096 MB de RAM e pelo menos 1024 MB de Swap."
		_SEARCHING_FOR_DEPENDENCIES="Procurando por dependências"
		_CPU_BUGS="Bugs ou problemas no CPU a nível Hardware ou estrutural encontrados:"
		_SINGLE_CPU_MSG_P1="CPU: Seu processador possui apenas"
		_SINGLE_CPU_MSG_P2="núcleos disponíveis.\n	   Compilar o Kernel neste sistema pode levar um tempo muito longo."
		_SEE="Veja"
		_CANCELLED_BY_USER="Cancelado pelo usuário."
		_UNKNOWN="Desconhecido."
		_ALL_READY="** Tudo pronto. Pressione ENTER para iniciar o $TITLE **"
		_ALSO_AMD64="também AMD64"
		_NEWER_X86="novos processadores x86"
		_OLD_X86="antigos processadores x86"
		_DEFAULT_CFLAGS_TEXT="Select safe/preset CFLAGS optimization for"
		_WINDOWS_SUBSYSTEM_INCOMPATIBLE_MSG="não é compativel com Linux on Windows Subsystem, experimente utilizar num sistema sendo executado no VirtualBox, Vmware, QEMU/KVM ou dual-boot."
		_ERROR_DOWNLOAD="Ocorreu um erro enquanto o arquivo era baixado. Status:"
		_PRESS_ANY_KEY_TO_CONTINUE="Pressione ENTER para continuar."
		_TMP_RW_ALLOWED="Leitura e escrita em /tmp é aceito."
		_DEFAULT_VM_MACHINE="é detectado como maquina virtual hospedeira. Desempenho pode ser reduzido."
		_SKIP_VALID_DOWNLOAD="Não é necessario download pois já existe um pacote do Kernel baixado e validado por MD5."
		_PRESS_ENTER_TO_CONTINUE="$_PRESS_ANY_KEY_TO_CONTINUE"
		_LACK_OF_PS2_SUPPORT="Sistema Sony PlayStation 2 não é mais suportado desde o KFN v2.8. Saindo..."
		_LACK_OF_PS3_SUPPORT="Sistema PlayStation 3 systems não é totalmente compativel desde KFN v3.0."
		_CPU_BUGS_MSG="$_CPU_BUGS"
		_X86_64_CFLAGS="CFLAGS x86_64 genericas"
		_X86_64_TITLE="$_DEFAULT_CFLAGS_TEXT Arquitetura Intel x86_64:"
		_SELECT_TARGET_ARCH="Selecione a arquitetura alvo.\nSe você deseja compilar para esta mesma máquina, selecione:"
		_SAVED_PROJECT="Projeto salvo como:"
		_SELECT_NUMBER_OF_THREADS="Selecione o número de núcleos a serem usados para compilar o código (1 to 1024).\n\nValor recomendado para este sistema:"
		_CLEAN_MAKE_FILES="Removendo arquivos pré compilados. Isso pode levar alguns minutos."
		_OVERRIDE_FILE="Você deseja sobrescrever o seguinte arquivo:"
		_KERNEL_SETUP_UTILITY="Compilando arquivos do Utilitário de Configuração do Kernel, por favor, aguarde."
		_TITLE_CANNOT_BE_EMPTY="Nome do projeto não pode estar vazio."
		_PREFIX_CANNOT_BE_EMPTY="Prefixo não pode ficar vazio."
		_CONFIG_NOT_FOUND="Arquivo de configuração do Kernel não localizado.\nTenha certeza de que ele foi salvo com o seguinte nome: .config"
		_THREADS_CANNOT_BE_EMPTY="Valor de tarefas não pode ficar fazio."
		_THREADS_CANNOT_BE_ZERO="Valor de tarefas não pode ser '0' ou negativo, precisa ser pelo menos '1', a menos que voce esteja na Matrix e Morpheus autorizou você a utilizar esse valor."
		_START_BUILD="Iniciando compilação do Kernel para:"
		_SET_PROJECT_NAME="Digite o nome do projeto:"
		_CROSS_COMPILATION_INFO="(modo de compilação-cruzada)"
		_SET_PROJECT_PREFIX="Selecione o profixo a ser utilizado.\n\nNote que poderá ser utilizado somente letras (A-Z, a-z), números (0-9), traço, ponto e underline são recomendados.\n\nEspaço e caracteres especiais não são permitidos."
		_PROJECT_LOCATION_BUILD="Estrutura local do projeto"
		_FOLDER_IS_NOT_EMPTY="O seguinte diretório não está vazio:"
		_CONTINUE_TO_EMPTY_DIR="Para extrair e continuar, é necessário apagar os arquivos. Você deseja remover o conteúdo deste diretório?"
		_SRC_RO_MSG="Acesso de leitura e escrita em /usr/src foi permitido."
		_TMP_RO_MSG="Acesso de somente leitura em /tmp."
		_SRC_RW_MSG="Acesso de somente leitura em /usr/src. Talvez será necessário acesso Root."
		_EXTRACTING_PACKAGES="Extraindo pacote, diretório de saida:"
		_DISK_FREE_SPACE_P1="Disco: Apenas"
		_DISK_FREE_SPACE_P2="GB estão livre na partição da pasta /home, onde pelo menos 20GB é necessario. Proceda com cuidado."
		_DISK="Disco:"
		_FREE_SPACE="GB livres na partição do diretorio /home."
		_CPU_MSG_P1="CPU: Um processador de"
		_CPU_MSG_P2="núcleos detectado."
		_CPU_BUGS_DETAILS="para detalhes."
		_DOWNLOAD_COMPLETE="Download concluído"
		_DEPENDENCIES_NOT_INSTALLED="As seguintes dependências não estão instaladas:"
		_ASK_INSTALL_DEPENDECIES="Você deseja instalar as dependências em falta?"
		_PRESS_ENTER_TO_CONTINUE_OR_CANCEL="Pressione ENTER para continuar, Control + C para cancelar."
		_UPDATE_APT_GET="OK, vamos então atualizar a lista de pacotes do apt-get. Digite a senha, se for solicitada:"
		_INSTALL_DEPENDENCIES="Agora, vamos instalar as depedências que estão em falta. Digite a senha, se for solicitada:"
		_ALL_DEPENDENCIES_INSTALLED="Todas as dependências estão instaladas."
		_PROJECT_TITLE="Projeto: "
		_PROJECT_NAME="Nome do projeto"
		_PROJECT_ARCH="Arquitetura"
		_PROJECT_SAVE="Salvar projeto"
		_PROJECT_KERNEL="Versão do Kernel"
		_PROJECT_OPTM="Otimização da arquitetura"
		_PROJECT_THREADS="Tarefas paralelas de compilação"
		_PROJECT_CONFIGURATION="Utilitário de Configuração do Kernel"
		_NEW_PROJECT="Novo projeto"
		_THREADS="processos simultâneos"
		_PROJECT_SAVE_CHANGES="Salvar alterações no arquivo do projeto."
		_GENERATE_CONFIG_FILE_TXT="Customizar arquivo .config"
		_CREATE_LOCAL_FILES="Criar estrutura local para gerenciar arquivos"
		_DOWNLOAD_KERNEL_FILES="1. Download pacote do Kernel"
		_DOWNLOAD_KERNEL_FILES_TXT="Fazer download do pacote do Kernel"
		_EXTRACT_KERNEL_FILES="2. Extrair arquivos do Kernel"
		_CLEAN_TEMPORARY_FILES="3. Limpar arquivos temporários"
		_GENERATE_CONFIG_FILE="4. Configurar o Kernel"
		_CLEAN_TEMPORARY_FILES_TXT="Remover arquivos pré-compilados"
		_PROJECT_START_BUILD="5. Iniciar compilação"
		_PROJECT_START_BUILD_TXT=""
		_PROJECT_FOLDER_EMPTY_ERROR="Não há pasta de trabalho do projeto existente.\nVocê precisa selecionar '$_EXTRACT_KERNEL_FILES' para continuar."
		_NO_SPACE_IN_DISK="Sem espaço livre em disco ou erro desconhecido."
		_PROJECT_PREFIX="Prefixo do projeto"
		_PKG_NOT_FOUND="O pacote do Kernel selecionado não foi encontrado.\n\nSelecione '$_DOWNLOAD_KERNEL_FILES' antes de continuar."
		_PROJECT_PREFIX_CUSTOM="Sem prefixo customizado"
		_CUSTOM_PREFIX_ON_TXT="Definir prefixo customizado do Kernel"
		_CUSTOM_PREFIX_OFF_TXT="não utilizar prefixo personalizado"
		_CUSTOM_PREFIX_TXT="Escolha o prefixo a ser utilizado com a versão do Kernel.\nExamplo: Kernel 3.8.10-prefixo_customizado_aqui."
		_SELECT_CONFIG_MODE="Selecione o Utilitário de Configuração do Kernel:"
		_TEXT_MODE="Modo de texto"
		_GRAFICAL_MODE="Modo grafico"
		_KERNEL_VERSION="Versão do Kernel"
		_COMPILATION_COMPLETED_SUCESSFULLY="Compilação concluída com sucesso. Status da saída:"
		_PROJECT_LOCATION_TXT="Local de trabalho do projeto:"
		_CELL_PS3_INFO="**NOTA** A implementação da compatibilidade do processador Cell Broadband Engine do PlayStation 3 disponibiliza a capacidade de compilação e otimização em qualquer plataforma, entretanto, o KFN não oferece recursos exclusivos desta plataforma, como compatibilidade com RSX e reprodução de discos Bluray, a menos que o Kernel e o arquivo de configurações .config disponibilizem os módulos e compatibilidade para isto. Sistemas PS3 com Firmware 3.21 ou versões superiores e modelos FAT (NOR), Slim e Super Slim somente suportarão Linux usando OtherOS++."
		_I386_SUPPORT_WARN="**NOTE** Official support for the i386 architecture has been removed since Kernel 3.8, but you can choose the i686 architecture that still continues to be officially supported as the x86 architecture by the newer versions.\n\nYou may have problems trying to compile Kernel 3.8 code or newer versions for i386 architecture. If your processor was manufactured in 2000 (such as Pentium 4 or Athlon64) or later, you can choose the i686 architecture compatible with most new x86 processors.\n\nSee: https://bit.ly/2EMx6jY"
		_IA64_SUPPORT_WARN="**NOTE** IA64 (Itanium) is not an architecture compatible with x86 or x86_64/AMD64 code.\n\nYou will not be able to run IA64 compiled code on an x86_64/AMD64 processor machine, or vice versa, in this case you will need an IA64 (Itanium) based processor."
		_FREE_SPACE_ERROR="You only have free GB on disk in the root partition, and you need at least GB. Failure to do so will cause problems in the compilation, impossibility of installing the new kernel and may compromise the operation of the system due to lack of space. Make sure you have at least a free GB for the compilation to take place successfully."
	fi

	if [ "$SELECT_LANGUAGE" == "2" ]
	then
		_COMPILER="Compiler"
		_COMPILER_TXT="Compilers available for"
		_LOCAL_CACHE="There is no cache of the Kernel package created. Downloading the package"
		_ALL_FILES_EXTRACTED="All files have been extracted successfully."
		_UNKNOWN_ERROR="Exit by unknown error:"
		_EXIT_BY_ERROR="Exit by error"
		_RECOMMENDED_RAM_SIZE="recommended: >= 4096 MB RAM and at least 1024 MB Swap."
		_SEARCHING_FOR_DEPENDENCIES="Searching for dependencies"
		_CPU_BUGS="Hardware/silicon-level or microcode CPU issues/bugs found."
		_SINGLE_CPU_MSG_P1="CPU: Your system has only"
		_SINGLE_CPU_MSG_P2="available CPU cores.\n	   Compiling the kernel on this system can take a very long time."
		_SEE="See"
		_CANCELLED_BY_USER="Cancelled by user."
		_UNKNOWN="Unknown."
		_ALL_READY="** All ready. Press ENTER to start $TITLE **"
		_ALSO_AMD64="also AMD64"
		_NEWER_X86="newer x86 processors"
		_OLD_X86="old x86 processors"
		_DEFAULT_CFLAGS_TEXT="Select safe/preset CFLAGS optimization for"
		_WINDOWS_SUBSYSTEM_INCOMPATIBLE_MSG="is not compatible with Linux on Windows subsystem, try VirtualBox, Vmware, QEMU, Linux-KVM or dual-boot. Exiting."
		_ERROR_DOWNLOAD="Error while downloading file. Status:"
		_PRESS_ANY_KEY_TO_CONTINUE="Press ENTER to continue."
		_TMP_RW_ALLOWED="Read/Write access in /tmp is allowed."
		_DEFAULT_VM_MACHINE="is detected as virtual machine host. Performance may be reduced."
		_SKIP_VALID_DOWNLOAD="It is not necessary to download since there is already a Kernel package downloaded and validated by MD5."
		_PRESS_ENTER_TO_CONTINUE="$_PRESS_ANY_KEY_TO_CONTINUE"
		_LACK_OF_PS2_SUPPORT="Sony PlayStation 2 systems ARE NOT SUPPORTED anymore since KFN v2.8. Please exit."
		_LACK_OF_PS3_SUPPORT="Sony PlayStation 3 systems no longer have full KFN oficial support since v3.0."
		_CPU_BUGS_MSG="Hardware/silicon-level CPU critical issue found:"
		_X86_64_CFLAGS="Generic x86_64 CFLAGS"
		_X86_64_TITLE="$_DEFAULT_CFLAGS_TEXT Intel x86_64 arch:"
		_SELECT_TARGET_ARCH="Select the target architecture.\nIf you want to compile for this same computer, select:"
		_SAVED_PROJECT="Project saved as:"
		_SELECT_NUMBER_OF_THREADS="Set the number of threads to use when compiling the code (1 to 1024).\n\nRecommended value for this system:"
		_CLEAN_MAKE_FILES="Removing precompiled files. This may take some time."
		_OVERRIDE_FILE="Do you want to overwrite the current file:"
		_KERNEL_SETUP_UTILITY="Compiling files for Kernel Setup Utility, please wait."
		_TITLE_CANNOT_BE_EMPTY="Project name cannot be empty."
		_PREFIX_CANNOT_BE_EMPTY="Prefix cannot be empty."
		_CONFIG_NOT_FOUND="Kernel configuration file not found.\nMake sure it has been saved as .config name."
		_THREADS_CANNOT_BE_EMPTY="Threads value cannot be empty."
		_THREADS="threads"
		_THREADS_CANNOT_BE_ZERO="Threads value cannot be '0' or negative, must be at least '1', unless you are in the Matrix and Morpheus authorize you to use this value."
		_START_BUILD="Started kernel compilation for:"
		_SET_PROJECT_NAME="Type the project name:"
		_CROSS_COMPILATION_INFO="(cross-compile mode)"
		_SET_PROJECT_PREFIX="Choose the name of the prefix to be used.\n\nNote that only letters (A-Z, a-z), numbers (0-9), stroke, point, and underline are recommended.\n\nSpace and special characters are not allowed."
		_PROJECT_LOCATION_BUILD="Local project structure"
		_FOLDER_IS_NOT_EMPTY="The following directory is not empty:"
		_CONTINUE_TO_EMPTY_DIR="To extract and continue, you must delete the files. Do you want to remove the contents of the directory?"
		_SRC_RO_MSG="Read/Write access in /usr/src is allowed."
		_TMP_RO_MSG="Read-only access in /tmp."
		_SRC_RW_MSG="Read-only access in /usr/src."
		_EXTRACTING_PACKAGES="Extracting package, output directory:"
		_DISK_FREE_SPACE_P1="Disk: Only"
		_DISK_FREE_SPACE_P2="GB free in /home partition, when at least 20GB is needed. Proceed cautiously."
		_DISK="Disk:"
		_FREE_SPACE="GB free in /home partition partition."
		_CPU_MSG_P1="CPU: A"
		_CPU_MSG_P2="-core/threads CPU detected."
		_CPU_BUGS_DETAILS="for details."
		_DOWNLOAD_COMPLETE="Download complete"
		_DEPENDENCIES_NOT_INSTALLED="The following required dependencies are not installed:"
		_ASK_INSTALL_DEPENDECIES="Do you want to install the missing dependencies?"
		_PRESS_ENTER_TO_CONTINUE_OR_CANCEL="Press ENTER to continue, Control + C to cancel."
		_UPDATE_APT_GET="OK, let's first update the apt-get package list. Enter the password, if prompted:"
		_INSTALL_DEPENDENCIES="Now, I'll try to install the dependencies. Enter your password, if prompted:"
		_ALL_DEPENDENCIES_INSTALLED="All dependencies are currently installed."
		_PROJECT_TITLE="Project: "
		_PROJECT_NAME="Project name"
		_PROJECT_ARCH="Architeture"
		_PROJECT_SAVE="Save project"
		_PROJECT_KERNEL="Kernel Version"
		_PROJECT_OPTM="Arch optimization"
		_PROJECT_THREADS="Threads"
		_PROJECT_CONFIGURATION="Kernel Setup Utility"
		_NEW_PROJECT="New Project"
		_PROJECT_SAVE_CHANGES="Save changes to project file."
		_GENERATE_CONFIG_FILE_TXT="Configure Kernel setup file"
		_CREATE_LOCAL_FILES="Create local stucture to manage files"
		_DOWNLOAD_KERNEL_FILES="1. Download Kernel package"
		_DOWNLOAD_KERNEL_FILES_TXT="Store local cache package"
		_EXTRACT_KERNEL_FILES="2. Extract Kernel files"
		_CLEAN_TEMPORARY_FILES="3. Clean temporary files"
		_GENERATE_CONFIG_FILE="4. Configure Kernel"
		_CLEAN_TEMPORARY_FILES_TXT="Remove pre-compiled files"
		_PROJECT_START_BUILD="5. Start build"
		_PROJECT_START_BUILD_TXT=""
		_PROJECT_FOLDER_EMPTY_ERROR="There is no current project work folder.\nYou must select '$_EXTRACT_KERNEL_FILES' to continue."
		_PROJECT_PREFIX="Project prefix"
		_PKG_NOT_FOUND="Package not found.\n\nSelect '$_DOWNLOAD_KERNEL_FILES' before continue."
		_PROJECT_PREFIX_CUSTOM="Without custom prefix"
		_CUSTOM_PREFIX_ON_TXT="Set the custom kernel version prefix"
		_CUSTOM_PREFIX_OFF_TXT="Do not use custom kernel version prefix"
		_CUSTOM_PREFIX_TXT="Defines whether to use a prefix along with the kernel version.\nExample: Kernel 3.8.10-custom_prefix_here."
		_NO_SPACE_IN_DISK="No free space in disk or unknown error."
		_SELECT_CONFIG_MODE="Select the Kernel configuration utility:"
		_TEXT_MODE="Text mode"
		_KERNEL_VERSION="Kernel version"
		_GRAFICAL_MODE="Graphical mode"
		_COMPILATION_COMPLETED_SUCESSFULLY="Compilation completed successfully. Exit status:"
		_PROJECT_LOCATION_TXT="Project location build:"
		_CELL_PS3_INFO="**NOTE** The implementation of compatibility with the Cell Broadband Engine processor of the PlayStation 3 is only intended to apply optimizations in the Kernel, in which it does not offer any other platform-specific additional features, such as RSX and PS3 Bluray drive or playback support, unless the target version of the Kernel, .config or patch has support enabled for this. Systems with PS3 firmware 3.21 or higher versions, Slim or Superslim models will only support Linux through the use of OtherOS++."
		_I386_SUPPORT_WARN="**NOTE** Official support for the i386 architecture has been removed since Kernel 3.8, but you can choose the i686 architecture that still continues to be officially supported as the x86/32bits architecture by the newer versions.\n\nYou may have problems trying to compile Kernel 3.8 code or newer versions for i386 architecture. If your processor was manufactured in 2000 (such as Pentium 4 or Athlon64) or later, you can choose the i686 architecture compatible with most new x86 processors.\n\nSee: https://bit.ly/2EMx6jY"
		_IA64_SUPPORT_WARN="**NOTE** IA64 (Itanium) is not an architecture compatible with x86 or x86_64/AMD64 code.\n\nYou will not be able to run IA64 compiled code on an x86_64/AMD64 processor machine, or vice versa, in this case you will need an IA64 (Itanium) based processor."
		_FREE_SPACE_ERROR="You only have free GB on disk in the root partition, and you need at least GB. Failure to do so will cause problems in the compilation, impossibility of installing the new kernel and may compromise the operation of the system due to lack of space. Make sure you have at least a free GB for the compilation to take place successfully."
	fi
}

CROSS_CC=0
_MENUCONFIG="menuconfig"
_XCONFIG="xconfig"
_DEFAULT="Default"
_PROJECT_PREFIX_CUSTOM="Custom"
_CUSTOM_PREFIX_ON="Enabled"
_CUSTOM_PREFIX_OFF="Disabled"
_GCC="GNU Compiler Collection"
_LLVM="Low Level Virtual Machine"
_HYPER_V_MACHINE="Hyper-V $_DEFAULT_VM_MACHINE"
_VMWARE_MACHINE="VMware $_DEFAULT_VM_MACHINE"
_QEMU_MACHINE="QEMU $_DEFAULT_VM_MACHINE"
_VIRTUALBOX_MACHINE="VirtualBox $_DEFAULT_VM_MACHINE"

MicrosoftSystemID="Microsoft@Microsoft.com"
DOWNLOAD_DIR="$HOME/kfn/downloads"
SOURCE_DIR="$HOME/kfn/source"
BUILD_DIR="$HOME/kfn/builds"
PROJECT_DIR="$HOME/kfn/projects"
TEMP_DIR="$HOME/kfn/temp"
LOG_DIR="$HOME/kfn/logs"
ALL_DEPENDECIES_INSTALLED=0
KFNTIME="`date +%d-%m-%y-%Hh%Mm%Ss`"

export DIALOGRC="$HOME/kfn/dialog_color_scheme_black_and_green"

title()
{
	clear
	echo -e "\e[32;1m$TITLE $VERSION\n\e[m"
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

	echo "[$MODE] $TEXT" >> "$LOG_DIR/$KFNTIME.log"
}

_start()
{
	title

	mkdir -p "$DOWNLOAD_DIR"
	mkdir -p "$SOURCE_DIR"
	mkdir -p "$BUILD_DIR"
	mkdir -p "$PROJECT_DIR"
	mkdir -p "$TEMP_DIR"
	mkdir -p "$LOG_DIR"

	if [ ! -f "$HOME/kfn/language" ]
	then
		_set_language
	fi

	SELECT_LANGUAGE=`cat $HOME/kfn/language`

	_load_language
	_dialog_scheme_files

	print ok "Set KFN dir as: $HOME/kfn"
	print ok "	Downloads: $DOWNLOAD_DIR"
	print ok "	   Source: $SOURCE_DIR"
	print ok "	   Builds: $BUILD_DIR"
}

# Dialog utility color scheme White:

_dialog_scheme_files()
{
	echo 'aspect = 0
	separate_widget = ""
	tab_len = 0
	visit_items = OFF
	use_shadow = ON
	use_colors = ON
	screen_color = (CYAN,BLUE,ON)
	shadow_color = (BLACK,BLACK,ON)
	dialog_color = (BLACK,WHITE,OFF)
	title_color = (BLUE,WHITE,ON)
	border_color = (WHITE,WHITE,ON)
	button_active_color = (WHITE,BLUE,ON)
	button_inactive_color = dialog_color
	button_key_active_color = button_active_color
	button_key_inactive_color = (RED,WHITE,OFF)
	button_label_active_color = (YELLOW,BLUE,ON)
	button_label_inactive_color = (BLACK,WHITE,ON)
	inputbox_color = dialog_color
	inputbox_border_color = dialog_color
	searchbox_color = dialog_color
	searchbox_title_color = title_color
	searchbox_border_color = border_color
	position_indicator_color = title_color
	menubox_color = dialog_color
	menubox_border_color = border_color
	item_color = dialog_color
	item_selected_color = button_active_color
	tag_color = title_color
	tag_selected_color = button_label_active_color
	tag_key_color = button_key_inactive_color
	tag_key_selected_color = (WHITE,BLUE,ON)
	check_color = dialog_color
	check_selected_color = button_active_color
	uarrow_color = (GREEN,WHITE,ON)
	darrow_color = uarrow_color
	itemhelp_color = (WHITE,BLACK,OFF)
	form_active_text_color = button_active_color
	form_text_color = (WHITE,CYAN,ON)
	form_item_readonly_color = (CYAN,WHITE,ON)
	gauge_color = title_color
	border2_color = dialog_color
	inputbox_border2_color = dialog_color
	searchbox_border2_color = dialog_color
	menubox_border2_color = dialog_color' > "$HOME/kfn/dialog_color_scheme_default_custom"

	# Dialog utility color scheme Black+Blue:

	echo 'aspect = 0
	separate_widget = ""
	tab_len = 0
	visit_items = OFF
	use_shadow = OFF
	use_colors = ON
	screen_color = (CYAN,BLUE,ON)
	shadow_color = (WHITE,WHITE,ON)
	dialog_color = (WHITE,BLACK,OFF)
	title_color = (BLUE,BLACK,ON)
	border_color = (WHITE,BLACK,ON)
	button_active_color = (BLUE,BLUE,ON)
	button_inactive_color = (WHITE,BLACK,ON)
	button_key_active_color = button_active_color
	button_key_inactive_color = (BLUE,BLACK,ON)
	button_label_active_color = (WHITE,BLUE,ON)
	button_label_inactive_color = (WHITE,BLACK,ON)
	inputbox_color = (WHITE,BLACK,ON)
	inputbox_border_color = (WHITE,BLACK,ON)
	searchbox_color = (WHITE,BLACK,ON)
	searchbox_title_color = (WHITE,BLACK,ON)
	searchbox_border_color = (WHITE,BLACK,ON)
	position_indicator_color = title_color
	menubox_color = (WHITE,BLACK,ON)
	menubox_border_color = (WHITE,BLACK,ON)
	item_color = dialog_color
	item_selected_color = (WHITE,BLUE,ON)
	tag_color = (BLUE,BLACK,ON)
	tag_selected_color = button_label_active_color
	tag_key_color = button_key_inactive_color
	tag_key_selected_color = (CYAN,BLUE,ON)
	check_color = dialog_color
	check_selected_color = button_active_color
	uarrow_color = (GREEN,WHITE,ON)
	darrow_color = uarrow_color
	itemhelp_color = (WHITE,BLACK,OFF)
	form_active_text_color = button_active_color
	form_text_color = (WHITE,CYAN,ON)
	form_item_readonly_color = (CYAN,WHITE,ON)
	gauge_color = title_color
	border2_color = (WHITE,BLACK,ON)
	inputbox_border2_color = (WHITE,BLACK,ON)
	searchbox_border2_color = (WHITE,BLACK,ON)
	menubox_border2_color = (WHITE,BLACK,ON)' > "$HOME/kfn/dialog_color_scheme_black_and_blue"

	# Dialog utility color scheme Black+Green:

	echo 'aspect = 0
	separate_widget = ""
	tab_len = 0
	visit_items = OFF
	use_shadow = OFF
	use_colors = ON
	screen_color = (CYAN,BLUE,ON)
	shadow_color = (WHITE,WHITE,ON)
	dialog_color = (WHITE,BLACK,OFF)
	title_color = (GREEN,BLACK,ON)
	border_color = (WHITE,BLACK,ON)
	button_active_color = (GREEN,GREEN,ON)
	button_inactive_color = (WHITE,BLACK,ON)
	button_key_active_color = button_active_color
	button_key_inactive_color = (GREEN,BLACK,ON)
	button_label_active_color = (WHITE,GREEN,ON)
	button_label_inactive_color = (WHITE,BLACK,ON)
	inputbox_color = (WHITE,BLACK,ON)
	inputbox_border_color = (WHITE,BLACK,ON)
	searchbox_color = (WHITE,BLACK,ON)
	searchbox_title_color = (WHITE,BLACK,ON)
	searchbox_border_color = (WHITE,BLACK,ON)
	position_indicator_color = title_color
	menubox_color = (WHITE,BLACK,ON)
	menubox_border_color = (WHITE,BLACK,ON)
	item_color = dialog_color
	item_selected_color = (WHITE,GREEN,ON)
	tag_color = (GREEN,BLACK,ON)
	tag_selected_color = button_label_active_color
	tag_key_color = button_key_inactive_color
	tag_key_selected_color = (WHITE,GREEN,ON)
	check_color = dialog_color
	check_selected_color = button_active_color
	uarrow_color = (GREEN,WHITE,ON)
	darrow_color = uarrow_color
	itemhelp_color = (WHITE,BLACK,OFF)
	form_active_text_color = button_active_color
	form_text_color = (WHITE,CYAN,ON)
	form_item_readonly_color = (CYAN,WHITE,ON)
	gauge_color = title_color
	border2_color = (WHITE,BLACK,ON)
	inputbox_border2_color = (WHITE,BLACK,ON)
	searchbox_border2_color = (WHITE,BLACK,ON)
	menubox_border2_color = (WHITE,BLACK,ON)' > "$HOME/kfn/dialog_color_scheme_black_and_green"
}


_disk_usage()
{
	DISK_USAGE=( `df / | grep dev` )
	DISK_USAGE=`echo "${DISK_USAGE[3]}/1024/1024" | bc`

	if [ $DISK_USAGE -lt $MIN_DISK_CAPACITY_FREE ]
	then
		print error "$_DISK_FREE_SPACE_P1 $DISK_USAGE $_DISK_FREE_SPACE_P2"
	else
		print ok "$_DISK $DISK_USAGE $_FREE_SPACE"
	fi
}

_tmp_rw_check()
{
	RND_VALUE="$RANDOM"

	touch "/tmp/$RND_VALUE"

	if [ -f "/tmp/$RND_VALUE" ]
	then
		print ok "$_TMP_RW_ALLOWED"
	else
		print error "$_TMP_RO_MSG"  
	fi
}

_source_rw_check()
{
	RND_VALUE="$RANDOM"

	touch "/usr/src/$RND_VALUE" 2> /dev/null

	if [ -f "/usr/src/$RND_VALUE" ]
	then
		print ok "$_SRC_RO_MSG"
	else
		print warn "$_SRC_RW_MSG"
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
		print warn "RAM: $MEM_SIZE MB, $_RECOMMENDED_RAM_SIZE"
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
		print error "$TITLE $_WINDOWS_SUBSYSTEM_INCOMPATICLE_MSG" 
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
		print info "$_HYPER_V_MACHINE"
	fi

	if [ $QEMU_CHECK != 0 ]
	then
		print info "$_QEMU_MACHINE"
	fi

	if [ $VMWARE_CHECK != 0 ]
	then
		print info "$_VMWARE_MACHINE"
	fi

	if [ $VBOX_CHECK != 0 ]
	then
		print info "$_VIRTUALBOX_MACHINE"
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
		print warn "$_SINGLE_CPU_MSG_P1 $CPU_THREADS $_SINGLE_CPU_MSG_P2"
	else
		print ok "$_CPU_MSG_P1 $CPU_THREADS $_CPU_MSG_P2"
	fi

	if [ "`cat /proc/cpuinfo | grep Emotion | wc -l`" != 0 ]
	then
		print error "$_LACK_OF_PS2_SUPPORT"
		exit
	fi

	if [ "`cat /proc/cpuinfo | grep Cell | wc -l`" != 0 ]
	then
		print warn "$_LACK_OF_PS3_SUPPORT"
	fi

	HOST_ARCH="`uname -m`"
}

_cpu_bugs()	
{
	if [ "`cat /proc/cpuinfo | grep bugs | wc -l`" != 0 ]
	then
		print warn "\e[33;1m$_CPU_BUGS\e[m\n		 $_SEE: 'cat /proc/cpuinfo | grep bugs' $_CPU_BUGS_DETAILS"
	fi

	if [ "`cat /proc/cpuinfo | grep meltdown | wc -l`" != 0 ]
	then
		print warn "\e[33;1m$_CPU_BUGS_MSG\e[m Meltdown."
	fi

	if [ "`cat /proc/cpuinfo | grep spectre_v1 | wc -l`" != 0 ]
	then
		print warn "\e[33;1m$_CPU_BUGS_MSG\e[m Spectre v1."
	fi

	if [ "`cat /proc/cpuinfo | grep spectre_v2 | wc -l`" != 0 ]
	then
		print warn "\e[33;1m$_CPU_BUGS_MSG\e[m Spectre v2."
	fi

	if [ "`cat /proc/cpuinfo | grep l1tf | wc -l`" != 0 ]
	then
		print warn "\e[33;1m$_CPU_BUGS_MSG\e[m Foreshadow."
	fi

	if [ "`cat /proc/cpuinfo | grep spec_store_bypass | wc -l`" != 0 ]
	then
		print warn "\e[33;1m$_CPU_BUGS_MSG\e[m Speculative Bypass."
	fi
}

_extract() # Usage: _extract file_url
{
	FILENAME_TAR="$1"

	if [ ! -f "$DOWNLOAD_DIR/$FILENAME_TAR" ]
	then
		dialog --title "$DEFAULT_TITLE" --msgbox "\n$_PKG_NOT_FOUND\n" 9 65
	else
		mkdir -p "$PROJECT_LOCATION_FILES/kernel"

		print info "$_EXTRACTING_PACKAGES $PROJECT_LOCATION_FILES"

		echo -e "\033[00;32m"
		tar -xvvf "$DOWNLOAD_DIR/$FILENAME_TAR" -C "$PROJECT_LOCATION_FILES/kernel"
		echo -e "\033[01;37m" 			

		EXTRACT_STATUS="$?"

		mv -u $PROJECT_LOCATION_FILES/kernel/*/* "$PROJECT_LOCATION_FILES/kernel"
		mv -u $PROJECT_LOCATION_FILES/kernel/*/.c* "$PROJECT_LOCATION_FILES/kernel"
		mv -u $PROJECT_LOCATION_FILES/kernel/*/.g* "$PROJECT_LOCATION_FILES/kernel"
		mv -u $PROJECT_LOCATION_FILES/kernel/*/.m* "$PROJECT_LOCATION_FILES/kernel"

		echo
		print info "$_ALL_FILES_EXTRACTED"
		print ok "$_PRESS_ANY_KEY_TO_CONTINUE"
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

		print info "$_LOCAL_CACHE $FILENAME\n"

		axel -a --insecure "$URL_SOURCE" -o "$DOWNLOAD_DIR/$FILENAME"

		DOWNLOAD_STATUS="$?"

		if [ "$DOWNLOAD_STATUS" == 0 ]
		then
			if [ -f "$DOWNLOAD_DIR/$FILENAME" ]
			then
				MD5=( `md5sum "$DOWNLOAD_DIR/$FILENAME"` )

				print info "$_DOWNLOAD_COMPLETE $FILENAME: ${MD5[0]}"

				echo "${MD5[0]}" > "$DOWNLOAD_DIR/$FILENAME.md5"

				dialog --title "$DEFAULT_TITLE" --msgbox "\n$_DOWNLOAD_COMPLETE: $FILENAME - ${MD5[0]}" 7 75
			fi
		fi
	else
		MD5=( `md5sum "$DOWNLOAD_DIR/$FILENAME"` )
		dialog --title "$DEFAULT_TITLE" --msgbox "\n$_SKIP_VALID_DOWNLOAD\n\n$FILENAME: $MD5" 10 70
	fi

	if [ ! -f "$DOWNLOAD_DIR/$FILENAME" ]
	then
		echo
		print error "$_ERROR_DOWNLOAD $DOWNLOAD_STATUS"
		print info "$_PRESS_ANY_KEY_TO_CONTINUE"
		read a
	fi
}

_check_dependencies()
{
	POSITION="$1"
	echo -e "\n$_SEARCHING_FOR_DEPENDENCIES:\n"

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
	echo -e "$_DEPENDENCIES_NOT_INSTALLED"
	echo -e "\n	\e[33;1m$MISSING_DEPENDENCIES\e[m\n"
	echo "$_ASK_INSTALL_DEPENDECIES"
	echo "$_PRESS_ENTER_TO_CONTINUE_OR_CANCEL"

	read a

	echo -e "$_UPDATE_APT_GET\n"

	sudo apt-get update

	echo -e "\n$_INSTALL_DEPENDENCIES\n"

	sudo apt-get install --no-install-recommends -y $MISSING_DEPENDENCIES
	sudo apt-get install dialog -y # Need fix here

	echo
	print info "$_PRESS_ENTER_TO_CONTINUE"
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
	
	print ok "$_ALL_DEPENDENCIES_INSTALLED" 
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
	SELECT=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_X86_64_TITLE" 20 70 40 \
	"x86_64_generic" 	  	 "$_X86_64_CFLAGS" \
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
	TEST=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_DEFAULT_CFLAGS_TEXT AMD AMD64 arch:" 20 80 40 \
	"AMD_K8_Core" "AMD K8 Sempron/Athlon/Phenom/Opteron" \
	"AMD_K10_Core" "AMD K10 Sempron II/Athlon II/Phenom II/Opteron II" \
	"AMD_Bulldozer_Core" "AMD Bulldozer" \
	"AMD_Bobcat_Core" "AMD Bobcat" \
	"AMD_Jaguar_Pluma_Core" "AMD Jaguar/Pluma/PS4/Xbox One" \
	"AMD_Zen_Core" "AMD Zen" `
}

_preset_cflags_ppc_64()
{
	TEST=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_DEFAULT_CFLAGS_TEXT PowerPC 64 arch:" 15 60 40 \
	"ppc64_generic" "Generic PowerPC64 CFLAGS" \
	"ppc64_cell"	 "PlayStation 3 - Cell Broadband Engine" `
}

_select_arch()
{
	_PROJECT_VAR_ARCH_TMP="$_PROJECT_VAR_ARCH"
	_PROJECT_VAR_ARCH_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_SELECT_TARGET_ARCH $HOST_ARCH." 0 75 0 \
	"i386"	"Intel/AMD/VIA 32 bits ($_OLD_X86)" \
	"i686"	"Intel/AMD/VIA 32 bits ($_NEWER_X86)" \
	"x86_64"	"Intel/AMD/VIA 64 bits ($_ALSO_AMD64)" \
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
			dialog --title "$DEFAULT_TITLE" --msgbox "\n$_I386_SUPPORT_WARN" 17 75 ;;
		"ia64")
			dialog --title "$DEFAULT_TITLE" --msgbox "\n$_IA64_SUPPORT_WARN" 12 75 ;;
		"ppc64")
			dialog --title "$DEFAULT_TITLE" --msgbox "\n$_CELL_PS3_INFO" 14 75 ;;
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
			dialog --title "$DEFAULT_TITLE" --yesno "\n$_OVERRIDE_FILE\n\n$PROJECT_DIR/$_PROJECT_VAR_NAME.kfn?" 9 75

			if [ "$?" == 0 ]
			then
				_save_project_to_file
			fi
		else
			_save_project_to_file
		fi
	else
		dialog --title "$DEFAULT_TITLE" --msgbox "\n$_TITLE_CANNOT_BE_EMPTY" 7 50
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
		_PROJECT_VAR_THREADS_TMP=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n$_SELECT_NUMBER_OF_THREADS $CPU_THREADS threads.\n " 13 55 "$_PROJECT_VAR_THREADS" )

		if [ $_PROJECT_VAR_THREADS_TMP -lt 0 ]
		then
			_PROJECT_VAR_THREADS_TMP=0
		fi

		case "x$_PROJECT_VAR_THREADS_TMP" in

			"x")
				dialog --title "$DEFAULT_TITLE" --msgbox "\n$_THREADS_CANNOT_BE_EMPTY" 7 50 ;;
			"x0")
				dialog --title "$DEFAULT_TITLE" --msgbox "\n$_THREADS_CANNOT_BE_ZERO" 9 60 ;;
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
		_PROJECT_VAR_NAME_TMP=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n$_SET_PROJECT_NAME" 10 55 "$_PROJECT_VAR_NAME" )

		COUNTER=0

		while [ "x${BANNED_CHARS[$COUNTER]}" != "x" ]
		do
			BAN_CHAR="${BANNED_CHARS[$COUNTER]}"
			_PROJECT_VAR_NAME_TMP=`echo "$_PROJECT_VAR_NAME_TMP" | tr --delete "$BAN_CHAR"`
			COUNTER=$(($COUNTER+1))
		done

		_PROJECT_VAR_NAME_TMP=${_PROJECT_VAR_NAME_TMP//'*'/}
		_PROJECT_VAR_NAME_TMP=${_PROJECT_VAR_NAME_TMP//'\'/}
		_PROJECT_VAR_NAME_TMP=${_PROJECT_VAR_NAME_TMP//'/'/}
		_PROJECT_VAR_NAME_TMP=${_PROJECT_VAR_NAME_TMP//'|'/}

		if [ "x$_PROJECT_VAR_NAME_TMP" == "x" ]
		then
			dialog --title "$DEFAULT_TITLE" --msgbox "\n$_TITLE_CANNOT_BE_EMPTY" 7 50
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
		_PROJECT_VAR_PREFIX_TMP=$( dialog --stdout --title "$DEFAULT_TITLE" --inputbox "\n$_SET_PROJECT_PREFIX\n " 15 70 "$_PROJECT_VAR_PREFIX" )

		COUNTER=0

		while [ "x${BANNED_CHARS[$COUNTER]}" != "x" ]
		do
			BAN_CHAR="${BANNED_CHARS[$COUNTER]}"
			_PROJECT_VAR_PREFIX_TMP=`echo "$_PROJECT_VAR_PREFIX_TMP" | tr --delete "$BAN_CHAR"`
			COUNTER=$(($COUNTER+1))
		done

		_PROJECT_VAR_PREFIX_TMP=${_PROJECT_VAR_PREFIX_TMP//'*'/}
		_PROJECT_VAR_PREFIX_TMP=${_PROJECT_VAR_PREFIX_TMP//'\'/}
		_PROJECT_VAR_PREFIX_TMP=${_PROJECT_VAR_PREFIX_TMP//'/'/}
		_PROJECT_VAR_PREFIX_TMP=${_PROJECT_VAR_PREFIX_TMP//'|'/}

		if [ "x$_PROJECT_VAR_PREFIX_TMP" == "x" ]
		then
			dialog --title "$DEFAULT_TITLE" --msgbox "\n$_PREFIX_CANNOT_BE_EMPTY" 7 50
		else
			_PROJECT_VAR_PREFIX="$_PROJECT_VAR_PREFIX_TMP"
			PREFIX_EXIT=1
		fi
	done
}

_select_config_mode()
{
	CONFIG_MODE_TMP="$_PROJECT_VAR_SETUP"
	CONFIG_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n$_SELECT_CONFIG_MODE" 9 55 0 \
	"$_MENUCONFIG" "$_TEXT_MODE" \
	"$_XCONFIG" "$_GRAFICAL_MODE" `

	if [ "x$CONFIG_MODE_TMP" != "x" ]
	then
		_PROJECT_VAR_SETUP="$CONFIG_MODE_TMP"
	fi
}

_select_prefix_mode()
{
	CONFIG_PREFIX_TMP="$_PROJECT_VAR_PREFIX_MODE"
	CONFIG_PREFIX_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n$_CUSTOM_PREFIX_TXT\n " 11 70 0 \
	"$_CUSTOM_PREFIX_OFF" "$_CUSTOM_PREFIX_OFF_TXT" \
	"$_CUSTOM_PREFIX_ON" "$_CUSTOM_PREFIX_ON_TXT" `

	if [ "x$CONFIG_PREFIX_TMP" != "x" ]
	then
		_PROJECT_VAR_PREFIX_MODE="$CONFIG_PREFIX_TMP"

		if [ "$CONFIG_PREFIX_TMP" == "$_CUSTOM_PREFIX_ON" ]
		then
			_set_project_prefix
		fi
	fi
}

_main_menu()
{
	CONFIG_MODE_TMP="$_PROJECT_VAR_SETUP"
	CONFIG_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_SELECT_CONFIG_MODE" 7 45 0 \
	"$_ABOUT_KFN" "$_TEXT_MODE" \
	"$_ABOUT_KFN" "$_ABOUT_KFN_MSG" `

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
	dialog --title "$DEFAULT_TITLE" --msgbox "\n$_PROJECT_LOCATION_TXT\n\n$BUILD_DIR/$LOCATION_NAME/" 9 65
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
		dialog --title "$DEFAULT_TITLE" --yesno "\n$_FOLDER_IS_NOT_EMPTY\n\n$PROJECT_LOCATION_FILES\n\n$_CONTINUE_TO_EMPTY_DIR" 12 75
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
		dialog --title "$DEFAULT_TITLE" --msgbox "\n$_PROJECT_FOLDER_EMPTY_ERROR" 9 70
	else
		title
		print info "$_CLEAN_MAKE_FILES\n"
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
		dialog --title "$DEFAULT_TITLE" --msgbox "\n$_CONFIG_NOT_FOUND" 8 75
	else
		title
		print info "$_START_BUILD $_PROJECT_VAR_ARCH$CROSS_COMPILATION_INFO"
		print info "$_COMPILER: $_PROJECT_VAR_COMPILER ($COMPILER_NAME)"
		print info "$_KERNEL_VERSION: $_PROJECT_VAR_KVERSION"

		echo

		CPU_TASK="$(($CPU_THREADS+1))"
		DEFAULT_CA="--initrd kernel_image kernel_headers"
		DEFAULT_CA2="kernel_image kernel_headers"
		ACTUAL_DIR="`pwd`"

		cd "$PROJECT_LOCATION_FILES/kernel/"

		if [ "$_PROJECT_VAR_PREFIX_MODE" == "$_CUSTOM_PREFIX_ON" ]
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
			make deb-pkg -j $CPU_TASK $PROJECT_PREFIX #$DEFAULT_CA2
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
				"2")   print error "$_EXIT_BY_ERROR $STATUS: $_NO_SPACE_IN_DISK" ;;
				"130") print error "$_EXIT_BY_ERROR $STATUS: $_CANCELLED_BY_USER" ;;
				"255") print error "$_EXIT_BY_ERROR $STATUS: $_CANCELLED_BY_USER" ;;
				*)     print error "$_EXIT_BY_ERROR $STATUS: $_UNKNOWN" ;;
			esac

			print info "$_PRESS_ANY_KEY_TO_CONTINUE"
			read a
		else
			mkdir -p "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/"

			mv $PROJECT_LOCATION_FILES/*.deb "$PROJECT_LOCATION_FILES/packages/"

			mv $PROJECT_LOCATION_FILES/packages/linux-headers* "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/linux-headers-$_PROJECT_VAR_KVERSION-$_PROJECT_VAR_ARCH.deb"

			mv $PROJECT_LOCATION_FILES/packages/linux-image* "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/linux-image-$_PROJECT_VAR_KVERSION-$_PROJECT_VAR_ARCH.deb"

			echo

			if [ ! -f "$PROJECT_LOCATION_FILES/packages/$_PROJECT_VAR_ARCH/linux-image-$_PROJECT_VAR_KVERSION-$_PROJECT_VAR_ARCH.deb" ]
			then
				print error "$_EXIT_BY_ERROR $STATUS: $_UNKNOWN"
			else
				print info "$_COMPILATION_COMPLETED_SUCESSFULLY $STATUS"
			fi
			print info "$_PRESS_ANY_KEY_TO_CONTINUE"
			read a
		fi

		cd "$ACTUAL_DIR"
	fi
}

_manage_config_file()
{
	if [ ! -f "$PROJECT_LOCATION_FILES/kernel/Makefile" ]
	then
		dialog --title "$DEFAULT_TITLE" --msgbox "\n$_PROJECT_FOLDER_EMPTY_ERROR" 9 70
	else
		title

		ACTUAL_DIR="`pwd`"

		cd "$PROJECT_LOCATION_FILES/kernel/"

		if [ "$CROSS_CC" == 0 ]
		then
			print info "$_KERNEL_SETUP_UTILITY\n"

			if [ "$_PROJECT_VAR_SETUP" == "$_MENUCONFIG" ]
			then
				make menuconfig
			else
				make xconfig
			fi
		else
			print info "$_KERNEL_SETUP_UTILITY ($_PROJECT_VAR_ARCH)\n"

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
			dialog --title "$DEFAULT_TITLE" --msgbox "\n$_CONFIG_NOT_FOUND" 8 75
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
	COMPILER_MODE_TMP="$_COMPILER_TXT"
	MODE="$1"

	if [ "$MODE" == 0 ]
	then
		COMPILER_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n$_COMPILER_TXT $_PROJECT_VAR_ARCH:" 9 60 0 \
		"gcc" "$_GCC" `
	else
		COMPILER_MODE_TMP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "\n$_COMPILER_TXT $_PROJECT_VAR_ARCH:" 9 60 0 \
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

		if [ "$_PROJECT_VAR_PREFIX_MODE" == "$_CUSTOM_PREFIX_ON" ]
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

		SELECT_SETUP=`dialog --stdout --title "$DEFAULT_TITLE" --menu "$_PROJECT_TITLE $_PROJECT_VAR_NAME" 24 0 40 \
		"$_PROJECT_NAME" "$_PROJECT_VAR_NAME" \
		"$_PROJECT_KERNEL" "$_PROJECT_VAR_KVERSION" \
		"$_PROJECT_ARCH" "$_PROJECT_VAR_ARCH$CROSS_COMPILATION_INFO" \
		"$_PROJECT_OPTM" "$_PROJECT_VAR_OPTIMIZATION" \
		"$_COMPILER" "$_PROJECT_VAR_COMPILER ($COMPILER_NAME)" \
		"$_PROJECT_PREFIX" "$_PROJECT_VAR_PREFIX_MODE$PREFIX_OUTPUT" \
		"$_PROJECT_THREADS" "$_PROJECT_VAR_THREADS $_THREADS" \
		"$_PROJECT_CONFIGURATION" "$_PROJECT_VAR_SETUP" \
		"" "" \
		"$_PROJECT_LOCATION_BUILD" "$BUILD_DIR/$LOCATION_NAME/" \
		"$_PROJECT_SAVE" "$_PROJECT_SAVE_CHANGES" \
		"" "" \
		"$_DOWNLOAD_KERNEL_FILES" "$_DOWNLOAD_KERNEL_FILES_TXT" \
		"$_EXTRACT_KERNEL_FILES" "$_CREATE_LOCAL_FILES" \
		"$_CLEAN_TEMPORARY_FILES" "$_CLEAN_TEMPORARY_FILES_TXT" \
		"$_GENERATE_CONFIG_FILE" "$_GENERATE_CONFIG_FILE_TXT" \
		"$_PROJECT_START_BUILD" "$_PROJECT_START_BUILD_TXT" `

		case "$SELECT_SETUP" in

			"$_DOWNLOAD_KERNEL_FILES")
				_download_package ;;

			"$_PROJECT_START_BUILD")
				_start_build ;;

			"$_CLEAN_TEMPORARY_FILES")
				_clean_files ;;

			"$_EXTRACT_KERNEL_FILES")
				_extract_project ;;

			"$_PROJECT_PREFIX")
				_select_prefix_mode ;;

			"$_PROJECT_NAME")
				_set_project_name ;;

			"$_PROJECT_THREADS")
				_set_threads ;;

			"$_PROJECT_ARCH")
				_select_arch ;;

			"$_PROJECT_SAVE")
				_save_project ;;

			"$_COMPILER")
				_select_compiler ;;

			"$_PROJECT_CONFIGURATION")
				_select_config_mode ;;

			"$_GENERATE_CONFIG_FILE")
				_manage_config_file ;;

			"$_PROJECT_LOCATION_BUILD")
				_location_build_info ;;

		esac
	done
}

_run()
{
	_start

	_windows_subsystem_checker

	_scan_dependencies 0

	print info "System: `uname` `uname -r` (`dpkg --print-architecture`/`getconf LONG_BIT` bits)"

	_cpu_cores

	_cpu_bugs

	_ram_check

	_disk_usage

	_tmp_rw_check

	_source_rw_check

	_detect_cflags

	_vm_checker
	echo -e "\e[32;1m\n $_ALL_READY\e[m"
#	read a

	#FILE=$( dialog --stdout --title "Please choose a file" --fselect "/home/motomagx/kfn/projects/" 15 70 )

	_main_setup new
}

_run










