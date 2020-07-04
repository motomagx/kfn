#!/bin/bash

# Kernel for Newbies
# The KFN Team

TITLE="Kernel for Newbies"
MAIN_TITLE="The multi-arch kernel compiler tool"
VERSION=3.0-alpha2+virt
FILE_FORMAT_VERSION=1
DEFAULT_KERNEL="5.7.7"
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

DEPENDENCIES[0]="alien axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g++ gcc gnupg2 gzip initramfs-tools kernel-package libc6 libelf-dev libncurses libncurses5-dev libnotify-bin libssl-dev lzop make pkg-config qemu tar wget"
DEPENDENCIES[1]="dpkg-cross gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi" # ARM
DEPENDENCIES[2]="dpkg-cross gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" 	   # ARM64
DEPENDENCIES[3]="dpkg-cross gcc-multilib-i686-linux-gnu' gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" 	   # i686
DEPENDENCIES[4]="dpkg-cross gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi" 	   # powerpc

_COMPILER[0]="Compilador"
_COMPILER[1]="Compiler"
_COMPILER_TXT[0]="Compiladores disponívels para"
_COMPILER_TXT[1]="Compilers available for"
_LOCAL_CACHE[0]="Nao há cache do pacote do Kernel criado. Realizando download do pacote"
_LOCAL_CACHE[1]="There is no cache of the Kernel package created. Downloading the package"
_ALL_FILES_EXTRACTED[0]="Todos os arquivos foram extraídos com sucesso."
_ALL_FILES_EXTRACTED[1]="All files have been extracted successfully."
_UNKNOWN_ERROR[0]="Saindo devido ao erro desconhecido:"
_UNKNOWN_ERROR[1]="Exit by unknown error:"
_EXIT_BY_ERROR[0]="Saindo pelo erro"
_EXIT_BY_ERROR[1]="Exit by error"
_RECOMMENDED_RAM_SIZE[0]="Recomendado: >[]= 4096 MB de RAM e pelo menos 1024 MB de Swap."
_RECOMMENDED_RAM_SIZE[1]="recommended: >[]= 4096 MB RAM and at least 1024 MB Swap."
_SEARCHING_FOR_DEPENDENCIES[0]="Procurando por dependencias"
_SEARCHING_FOR_DEPENDENCIES[1]="Searching for dependencies"
_CPU_BUGS[0]="Bugs ou falhas de seguranca foram detectados no seu CPU:"
_CPU_BUGS[1]="Bugs or security holes have been detected on your CPU."
_SINGLE_CPU_MSG_P1[0]="CPU: Seu processador possui apenas"
_SINGLE_CPU_MSG_P1[1]="CPU: Your system has only"
_SINGLE_CPU_MSG_P2[0]="nucleos disponíveis.\n	   Compilar o Kernel neste sistema pode levar um tempo muito longo."
_SINGLE_CPU_MSG_P2[1]="available CPU cores.\n	   Compiling the kernel on this system can take a very long time."
_SEE[0]="Veja"
_SEE[1]="See"
_CANCELLED_BY_USER[0]="Cancelado pelo usuário."
_CANCELLED_BY_USER[1]="Cancelled by user."
_UNKNOWN[0]="Desconhecido."
_UNKNOWN[1]="Unknown."
_ALL_READY[0]="** Tudo pronto. Pressione ENTER para iniciar o $TITLE **"
_ALL_READY[1]="** All ready. Press ENTER to start $TITLE **"
_ALSO_AMD64[0]="tambem AMD64"
_ALSO_AMD64[1]="also AMD64"
_NEWER_X86[0]="novos processadores x86"
_NEWER_X86[1]="newer x86 processors"
_OLD_X86[0]="antigos processadores x86"
_OLD_X86[1]="old x86 processors"
_DEFAULT_CFLAGS_TEXT[0]="Select safe/preset CFLAGS optimization for"
_DEFAULT_CFLAGS_TEXT[1]="Select safe/preset CFLAGS optimization for"
_WINDOWS_SUBSYSTEM_INCOMPATIBLE_MSG[0]="nao e' compativel com Linux on Windows Subsystem, experimente utilizar num sistema sendo executado no VirtualBox, Vmware, QEMU/KVM ou dual-boot."
_WINDOWS_SUBSYSTEM_INCOMPATIBLE_MSG[1]="is not compatible with Linux on Windows subsystem, try VirtualBox, Vmware, QEMU, Linux-KVM or dual-boot. Exiting."
_ERROR_DOWNLOAD[0]="Ocorreu um erro enquanto o arquivo era baixado. Status:"
_ERROR_DOWNLOAD[1]="Error while downloading file. Status:"
_PRESS_ANY_KEY_TO_CONTINUE[0]="Pressione ENTER para continuar."
_PRESS_ANY_KEY_TO_CONTINUE[1]="Press ENTER to continue."
_TMP_RW_ALLOWED[0]="Leitura e escrita em /tmp e' aceito."
_TMP_RW_ALLOWED[1]="Read/Write access in /tmp is allowed."
_DEFAULT_VM_MACHINE[0]="e' detectado como maquina virtual hospedeira. Desempenho pode ser reduzido."
_DEFAULT_VM_MACHINE[1]="is detected as virtual machine host. Performance may be reduced."
_SKIP_VALID_DOWNLOAD[0]="Nao e' necessario download pois já existe um pacote do Kernel baixado e validado por MD5."
_SKIP_VALID_DOWNLOAD[1]="It is not necessary to download since there is already a Kernel package downloaded and validated by MD5."
_PRESS_ENTER_TO_CONTINUE[0]="$_PRESS_ANY_KEY_TO_CONTINUE"
_PRESS_ENTER_TO_CONTINUE[1]="$_PRESS_ANY_KEY_TO_CONTINUE"
_LACK_OF_PS2_SUPPORT[0]="Sistema Sony PlayStation 2 nao e' mais suportado desde o KFN v2.8. Saindo..."
_LACK_OF_PS2_SUPPORT[1]="Sony PlayStation 2 systems ARE NOT SUPPORTED anymore since KFN v2.8. Please exit."
_LACK_OF_PS3_SUPPORT[0]="Sistema PlayStation 3 systems nao e' totalmente compativel desde KFN v3.0."
_LACK_OF_PS3_SUPPORT[1]="Sony PlayStation 3 systems no longer have full KFN oficial support since v3.0."
_CPU_BUGS_MSG[0]="$_CPU_BUGS"
_CPU_BUGS_MSG[1]="$_CPU_BUGS"
_X86_64_CFLAGS[0]="CFLAGS x86_64 genericas"
_X86_64_CFLAGS[1]="Generic x86_64 CFLAGS"
_X86_64_TITLE[0]="$_DEFAULT_CFLAGS_TEXT Arquitetura Intel x86_64:"
_X86_64_TITLE[1]="$_DEFAULT_CFLAGS_TEXT Intel x86_64 arch:"
_SELECT_TARGET_ARCH[0]="Selecione a arquitetura alvo.\nSe voce deseja compilar para esta mesma máquina, selecione:"
_SELECT_TARGET_ARCH[1]="Select the target architecture.\nIf you want to compile for this same computer, select:"
_SAVED_PROJECT[0]="Projeto salvo como:"
_SAVED_PROJECT[1]="Project saved as:"
_SELECT_NUMBER_OF_THREADS[0]="Selecione o numero de nucleos a serem usados para compilar o codigo (1 to 1024).\n\nValor recomendado para este sistema:"
_SELECT_NUMBER_OF_THREADS[1]="Set the number of threads to use when compiling the code (1 to 1024).\n\nRecommended value for this system:"
_CLEAN_MAKE_FILES[0]="Removendo arquivos pre' compilados. Isso pode levar alguns minutos."
_CLEAN_MAKE_FILES[1]="Removing precompiled files. This may take some time."
_OVERRIDE_FILE[0]="Voce deseja sobrescrever o seguinte arquivo:"
_OVERRIDE_FILE[1]="Do you want to overwrite the current file:"
_KERNEL_SETUP_UTILITY[0]="Compilando arquivos do Utilitário de Configuracao do Kernel, por favor, aguarde."
_KERNEL_SETUP_UTILITY[1]="Compiling files for Kernel Setup Utility, please wait."
_TITLE_CANNOT_BE_EMPTY[0]="Nome do projeto nao pode estar vazio."
_TITLE_CANNOT_BE_EMPTY[1]="Project name cannot be empty."
_PREFIX_CANNOT_BE_EMPTY[0]="Prefixo nao pode ficar vazio."
_PREFIX_CANNOT_BE_EMPTY[1]="Prefix cannot be empty."
_CONFIG_NOT_FOUND[0]="Arquivo de configuracao do Kernel nao localizado.\nTenha certeza de que ele foi salvo com o seguinte nome: .config"
_CONFIG_NOT_FOUND[1]="Kernel configuration file not found.\nMake sure it has been saved as .config name."
_THREADS_CANNOT_BE_EMPTY[0]="Valor de tarefas nao pode ficar fazio."
_THREADS_CANNOT_BE_EMPTY[1]="Threads value cannot be empty."
_THREADS[0]="threads"
_THREADS_CANNOT_BE_ZERO[0]="Valor de tarefas nao pode ser '0' ou negativo, precisa ser pelo menos '1', a menos que voce esteja na Matrix e Morpheus autorizou voce a utilizar esse valor."
_THREADS_CANNOT_BE_ZERO[1]="Threads value cannot be '0' or negative, must be at least '1', unless you are in the Matrix and Morpheus authorize you to use this value."
_START_BUILD[0]="Iniciando compilacao do Kernel para:"
_START_BUILD[1]="Started kernel compilation for:"
_SET_PROJECT_NAME[0]="Digite o nome do projeto:"
_SET_PROJECT_NAME[1]="Type the project name:"
_CROSS_COMPILATION_INFO[0]="(modo de compilacao-cruzada)"
_CROSS_COMPILATION_INFO[1]="(cross-compile mode)"
_SET_PROJECT_PREFIX[0]="Selecione o profixo a ser utilizado.\n\nNote que poderá ser utilizado somente letras (A-Z, a-z), numeros (0-9), traco, ponto e underline sao recomendados.\n\nEspaco e caracteres especiais nao sao permitidos."
_SET_PROJECT_PREFIX[1]="Choose the name of the prefix to be used.\n\nNote that only letters (A-Z, a-z), numbers (0-9), stroke, point, and underline are recommended.\n\nSpace and special characters are not allowed."
_PROJECT_LOCATION_BUILD[0]="Estrutura local do projeto"
_PROJECT_LOCATION_BUILD[1]="Local project structure"
_FOLDER_IS_NOT_EMPTY[0]="O seguinte diretorio nao está vazio:"
_FOLDER_IS_NOT_EMPTY[1]="The following directory is not empty:"
_CONTINUE_TO_EMPTY_DIR[0]="Para extrair e continuar, e' necessário apagar os arquivos. Voce deseja remover o conteudo deste diretorio?"
_CONTINUE_TO_EMPTY_DIR[1]="To extract and continue, you must delete the files. Do you want to remove the contents of the directory?"
_SRC_RO_MSG[0]="Acesso de leitura e escrita em /usr/src foi permitido."
_SRC_RO_MSG[1]="Read/Write access in /usr/src is allowed."
_TMP_RO_MSG[0]="Acesso de somente leitura em /tmp."
_TMP_RO_MSG[1]="Read-only access in /tmp."
_SRC_RW_MSG[0]="Acesso de somente leitura em /usr/src. Talvez será necessário acesso Root."
_SRC_RW_MSG[1]="Read-only access in /usr/src."
_EXTRACTING_PACKAGES[0]="Extraindo pacote, diretorio de saida:"
_EXTRACTING_PACKAGES[1]="Extracting package, output directory:"
_DISK_FREE_SPACE_P1[0]="Disco: Apenas"
_DISK_FREE_SPACE_P1[1]="Disk: Only"
_DISK_FREE_SPACE_P2[0]="GB estao livre na particao da pasta /home, onde pelo menos 20GB e' necessario. Proceda com cuidado."
_DISK_FREE_SPACE_P2[1]="GB free in /home partition, when at least 20GB is needed. Proceed cautiously."
_DISK[0]="Disco:"
_DISK[1]="Disk:"
_FREE_SPACE[0]="GB livres na particao do diretorio /home."
_FREE_SPACE[1]="GB free in /home partition partition."
_CPU_MSG_P1[0]="CPU: Um processador de"
_CPU_MSG_P1[1]="CPU: A"
_CPU_MSG_P2[0]="nucleos detectado."
_CPU_MSG_P2[1]="-core/threads CPU detected."
_CPU_BUGS_DETAILS[0]="para detalhes."
_CPU_BUGS_DETAILS[1]="for details."
_DOWNLOAD_COMPLETE[0]="Download concluído"
_DOWNLOAD_COMPLETE[1]="Download complete"
_DEPENDENCIES_NOT_INSTALLED[0]="As seguintes dependencias nao estao instaladas:"
_DEPENDENCIES_NOT_INSTALLED[1]="The following required dependencies are not installed:"
_ASK_INSTALL_DEPENDECIES[0]="Voce deseja instalar as dependencias em falta?"
_ASK_INSTALL_DEPENDECIES[1]="Do you want to install the missing dependencies?"
_PRESS_ENTER_TO_CONTINUE_OR_CANCEL[0]="Pressione ENTER para continuar, Control + C para cancelar."
_PRESS_ENTER_TO_CONTINUE_OR_CANCEL[1]="Press ENTER to continue, Control + C to cancel."
_UPDATE_APT_GET[0]="OK, vamos entao atualizar a lista de pacotes do apt-get. Digite a senha, se for solicitada:"
_UPDATE_APT_GET[1]="OK, let's first update the apt-get package list. Enter the password, if prompted:"
_INSTALL_DEPENDENCIES[0]="Agora, vamos instalar as depedencias que estao em falta. Digite a senha, se for solicitada:"
_INSTALL_DEPENDENCIES[1]="Now, I'll try to install the dependencies. Enter your password, if prompted:"
_ALL_DEPENDENCIES_INSTALLED[0]="Todas as dependencias estao instaladas."
_ALL_DEPENDENCIES_INSTALLED[1]="All dependencies are currently installed."
_PROJECT_TITLE[0]="Projeto: "
_PROJECT_TITLE[1]="Project: "
_PROJECT_NAME[0]="Nome do projeto"
_PROJECT_NAME[1]="Project name"
_PROJECT_ARCH[0]="Arquitetura"
_PROJECT_ARCH[1]="Architeture"
_PROJECT_SAVE[0]="Salvar projeto"
_PROJECT_SAVE[1]="Save project"
_PROJECT_KERNEL[0]="Versao do Kernel"
_PROJECT_KERNEL[1]="Kernel Version"
_PROJECT_OPTM[0]="Otimizacao da arquitetura"
_PROJECT_OPTM[1]="Arch optimization"
_PROJECT_THREADS[0]="Tarefas paralelas de compilacao"
_PROJECT_THREADS[1]="Threads"
_PROJECT_CONFIGURATION[0]="Utilitário de Configuracao do Kernel"
_PROJECT_CONFIGURATION[1]="Kernel Setup Utility"
_NEW_PROJECT[0]="Novo projeto"
_NEW_PROJECT[1]="New Project"
_THREADS[0]="processos simultâneos"
_THREADS[1]="threads"
_PROJECT_SAVE_CHANGES[0]="Salvar alteracões no arquivo do projeto."
_PROJECT_SAVE_CHANGES[1]="Save changes to project file."
_GENERATE_CONFIG_FILE_TXT[0]="Customizar arquivo .config"
_GENERATE_CONFIG_FILE_TXT[1]="Configure Kernel setup file"
_CREATE_LOCAL_FILES[0]="Criar estrutura local para gerenciar arquivos"
_CREATE_LOCAL_FILES[1]="Create local stucture to manage files"
_DOWNLOAD_KERNEL_FILES[0]="1. Download pacote do Kernel"
_DOWNLOAD_KERNEL_FILES[1]="1. Download Kernel package"
_DOWNLOAD_KERNEL_FILES_TXT[0]="Fazer download do pacote do Kernel"
_DOWNLOAD_KERNEL_FILES_TXT[1]="Store local cache package"
_EXTRACT_KERNEL_FILES[0]="2. Extrair arquivos do Kernel"
_EXTRACT_KERNEL_FILES[1]="2. Extract Kernel files"
_CLEAN_TEMPORARY_FILES[0]="3. Limpar arquivos temporários"
_CLEAN_TEMPORARY_FILES[1]="3. Clean temporary files"
_GENERATE_CONFIG_FILE[0]="4. Configurar o Kernel"
_GENERATE_CONFIG_FILE[1]="4. Configure Kernel"
_CLEAN_TEMPORARY_FILES_TXT[0]="Remover arquivos pre'-compilados"
_CLEAN_TEMPORARY_FILES_TXT[1]="Remove pre-compiled files"
_PROJECT_START_BUILD[0]="5. Iniciar compilacao"
_PROJECT_START_BUILD[1]="5. Start build"
_PROJECT_START_BUILD_TXT[0]=""
_PROJECT_START_BUILD_TXT[1]=""
_PROJECT_FOLDER_EMPTY_ERROR[0]="Nao há pasta de trabalho do projeto existente.\nVoce precisa selecionar '$_EXTRACT_KERNEL_FILES' para continuar."
_PROJECT_FOLDER_EMPTY_ERROR[1]="There is no current project work folder.\nYou must select '$_EXTRACT_KERNEL_FILES' to continue."
_NO_SPACE_IN_DISK[0]="Sem espaco livre em disco ou erro desconhecido."
_NO_SPACE_IN_DISK[1]="No free space in disk or unknown error."
_PROJECT_PREFIX[0]="Prefixo do projeto"
_PROJECT_PREFIX[1]="Project prefix"
_PKG_NOT_FOUND[0]="O pacote do Kernel selecionado nao foi encontrado.\n\nSelecione '$_DOWNLOAD_KERNEL_FILES' antes de continuar."
_PKG_NOT_FOUND[1]="Package not found.\n\nSelect '$_DOWNLOAD_KERNEL_FILES' before continue."
_PROJECT_PREFIX_CUSTOM[0]="Sem prefixo customizado"
_PROJECT_PREFIX_CUSTOM[1]="Without custom prefix"
_CUSTOM_PREFIX_ON_TXT[0]="Definir prefixo customizado do Kernel"
_CUSTOM_PREFIX_ON_TXT[1]="Set the custom kernel version prefix"
_CUSTOM_PREFIX_OFF_TXT[0]="nao utilizar prefixo personalizado"
_CUSTOM_PREFIX_OFF_TXT[1]="Do not use custom kernel version prefix"
_CUSTOM_PREFIX_TXT[0]="Defines whether to use a prefix along with the kernel version.\nExample: Kernel 3.8.10-custom_prefix_here."
_CUSTOM_PREFIX_TXT[1]="Escolha o prefixo a ser utilizado com a versao do Kernel.\nExamplo: Kernel 3.8.10-prefixo_customizado_aqui."
_SELECT_CONFIG_MODE[0]="Selecione o Utilitário de Configuracao do Kernel:"
_SELECT_CONFIG_MODE[1]="Select the Kernel configuration utility:"
_TEXT_MODE[0]="Modo de texto"
_TEXT_MODE[1]="Text mode"
_GRAFICAL_MODE[0]="Modo grafico"
_GRAFICAL_MODE[1]="Graphical mode"
_KERNEL_VERSION[0]="Versao do Kernel"
_KERNEL_VERSION[1]="Kernel version"
_COMPILATION_COMPLETED_SUCESSFULLY[0]="Compilacao concluída com sucesso. Status da saída:"
_COMPILATION_COMPLETED_SUCESSFULLY[1]="Compilation completed successfully. Exit status:"
_PROJECT_LOCATION_TXT[0]="Local de trabalho do projeto:"
_PROJECT_LOCATION_TXT[1]="Project location build:"
_CELL_PS3_INFO[0]="**NOTA** A implementacao da compatibilidade do processador Cell Broadband Engine do PlayStation 3 disponibiliza a capacidade de compilacao e otimizacao em qualquer plataforma, entretanto, o KFN nao oferece recursos exclusivos desta plataforma, como compatibilidade com RSX e reproducao de discos Bluray, a menos que o Kernel e o arquivo de configuracões .config disponibilizem os modulos e compatibilidade para estes dispositivos. Sistemas PS3 com Firmware 3.21 ou versões superiores e modelos FAT (NOR), Slim e Super Slim somente suportarao Linux usando OtherOS++."
_CELL_PS3_INFO[1]="**NOTE** The implementation of compatibility with the Cell Broadband Engine processor of the PlayStation 3 is only intended to apply optimizations in the Kernel, in which it does not offer any other platform-specific additional features, such as RSX and PS3 Bluray drive or playback support, unless the target version of the Kernel, .config or patch has support enabled for this. Systems with PS3 firmware 3.21 or higher versions, Slim or Superslim models will only support Linux through the use of OtherOS++."
_I386_SUPPORT_WARN[0]="**NOTE** Official support for the i386 architecture has been removed since Kernel 3.8, but you can choose the i686 architecture that still continues to be officially supported as the x86/32bits architecture by the newer versions.\n\nYou may have problems trying to compile Kernel 3.8 code or newer versions for i386 architecture. If your processor was manufactured in 2000 (such as Pentium 4 or Athlon64) or later, you can choose the i686 architecture compatible with most new x86 processors.\n\nSee: https://bit.ly/2EMx6jY"
_I386_SUPPORT_WARN[1]="**NOTE** Official support for the i386 architecture has been removed since Kernel 3.8, but you can choose the i686 architecture that still continues to be officially supported as the x86 architecture by the newer versions.\n\nYou may have problems trying to compile Kernel 3.8 code or newer versions for i386 architecture. If your processor was manufactured in 2000 (such as Pentium 4 or Athlon64) or later, you can choose the i686 architecture compatible with most new x86 processors.\n\nSee: https://bit.ly/2EMx6jY"
_IA64_SUPPORT_WARN[0]="**NOTE** IA64 (Itanium) is not an architecture compatible with x86 or x86_64/AMD64 code.\n\nYou will not be able to run IA64 compiled code on an x86_64/AMD64 processor machine, or vice versa, in this case you will need an IA64 (Itanium) based processor."
_IA64_SUPPORT_WARN[1]="**NOTE** IA64 (Itanium) is not an architecture compatible with x86 or x86_64/AMD64 code.\n\nYou will not be able to run IA64 compiled code on an x86_64/AMD64 processor machine, or vice versa, in this case you will need an IA64 (Itanium) based processor."
_FREE_SPACE_ERROR[0]="You only have free GB on disk in the root partition, and you need at least GB. Failure to do so will cause problems in the compilation, impossibility of installing the new kernel and may compromise the operation of the system due to lack of space. Make sure you have at least a free GB for the compilation to take place successfully."
_FREE_SPACE_ERROR[1]="You only have free GB on disk in the root partition, and you need at least GB. Failure to do so will cause problems in the compilation, impossibility of installing the new kernel and may compromise the operation of the system due to lack of space. Make sure you have at least a free GB for the compilation to take place successfully."
_HYPER_V_MACHINE[0]="O KFN nao pode ser executado no Windows Subsystem for Linux. Saindo."
_HYPER_V_MACHINE[1]="KFN cannot be run on Windows Subsystem for Linux. Existing."
_SEE_YOU_SOON[0]="Nos vemos em breve. Ate' mais."
_SEE_YOU_SOON[1]="See you soon. Good bye."
_BUILDS[0]="           Compilacoes:"
_BUILDS[1]="        Builds:"
_SOURCE[0]="                 Fonte:"
_SOURCE[1]="        Source:"
_DOWNLOADS[0]="             Downloads:"
_DOWNLOADS[1]="     Downloads:"
_SET_KFN_DIR[0]="Config. dir. do KFN em:"
_SET_KFN_DIR[1]="Set KFN dir as:"


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

	echo "$LANGUAGE" > "$HOME/kfn/language"
}



CROSS_CC=0


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

	LANGUAGE=`cat $HOME/kfn/language`

	_load_language
	_dialog_scheme_files

	print ok "${_SET_KFN_DIR[$LANGUAGE]} $HOME/kfn"
	print ok "${_DOWNLOADS[$LANGUAGE]} $DOWNLOAD_DIR"
	print ok "${_SOURCE[$LANGUAGE]} $SOURCE_DIR"
	print ok "${_BUILDS[$LANGUAGE]} $BUILD_DIR"
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

		print warn "\e[33;1m${_CPU_BUGS[$LANGUAGE]}\e[m\n\n		 \e[31;1m$CPU_BUGS\e[m\n		 ${_SEE[$LANGUAGE]}: 'cat /proc/cpuinfo | grep bugs' ${_CPU_BUGS_DETAILS[$LANGUAGE]}\n"
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
		print error "${_ERROR_DOWNLOAD[$LANGUAGE]} $DOWNLOAD_STATUS[$LANGUAGE]}"
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
	sudo apt-get install dialog -y # Need fix here

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

	#_windows_subsystem_checker

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
	echo -e "\e[32;1m\n ${_ALL_READY[$LANGUAGE]}\e[m"
	read a

	_main_setup new
}

_run



