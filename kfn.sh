#!/bin/bash

# Kernel for Newbies.

KFNVERSION=2.9f
MAINKERNEL=4.0.5
KERNELVERSION=$MAINKERNEL
TITLEMSG="Kernel for Newbies v$KFNVERSION"
RELEASEDATE=22/06/2015
KFNFORUM="https://sourceforge.net/p/kfn/discussion/general/"
KFNLINKUPDATE="http://sourceforge.net/projects/kfn/files/kfn.sh"
DEPENDENCES="axel build-essential bzip2 dialog dkms fakeroot g++ gcc gzip initramfs-tools kernel-package libc6 libncurses libnotify-bin tar wget"

if [ ! -d $HOME/.kfn/ ] # Pasta de configurações do usuário.
then 			# A pasta .kfn original foi substituida na versão 2.8 por .kfn_tmp
	mkdir $HOME/.kfn/
	chmod 777 -R $HOME/.kfn/
fi

if [ ! -f $HOME/.kfn/language ]
then
	STOPLNG=0
	while [ $STOPLNG -eq 0 ]
	do
		clear
		echo -e "\033[1;36mKernel for newbies (v$KFNVERSION)\033[0m"
		echo
		echo -e "\033[1;36m 1) Para idioma Português-BR, digite 1 e pressione ENTER.\033[0m"
		echo -e "\033[1;36m 2) For English language, type 2 and press ENTER.\033[0m"
#		echo -e "\033[1;36m 3) En el idioma español, escriba 3 y pulse ENTRAR.\033[0m"
		read KEY

		case "$KEY" in
		1) echo "pt-br" > $HOME/.kfn/language
		       STOPLNG=1
		       ;;
		2) echo "english" > $HOME/.kfn/language
		       STOPLNG=1
		       ;;
		esac

		chmod 777 $HOME/.kfn/language
	done
fi

case "`cat $HOME/.kfn/language`" in

	pt-br)

_GENERALOPTIONS="Sistema: Kernel `uname -r` - `cat /etc/issue.net` (`file /bin/bash | cut -d' ' -f3`/`dpkg --print-architecture`)"
_KERNELVERSIONTXT="Versão do Kernel"
_SOURCEPACKAGE="Fonte do pacote"
_URL="URL/Caminho"
_CORES="Núcleos a serem usados"
_CORES1="núcleos"
_CORE1="núcleo"
_COMPILERAMDISK="Compilar via RAMDISK"
_WHENCOMPLETE="Comando ao terminar"
_STARTPROCESS="Iniciar processos"
_YES="Sim"
_NO="Não"
_AUTO="Automático"
_CANCEL="Cancelar"
_ERROR="[ Erro ]"
_OK="[  OK  ]"
_32BITERROR="Seu sistema operacional não é um sistema 64-bits, no qual não poderá trabalhar com a RAMDISK necessária."
_NOROOT="$TITLEMSG\nDesculpe, é necessário executar este programa como usuário Root.\nExperimente executar como: 'sudo kfn'"
_CHECKDEP="Verificando dependências..."
_SUCESSFULLINSTALL="\nAs dependências foram instaladas corretamente."
_ERRORDEP="Erro ao instalar as dependências. Possiveis causas:\033[0m\n\n1- O pacote de programas do sistema está desatualizado.\n    Execute o comando 'sudo apt-get update' e tente novamente.\n2- O computador pode não estar conectado à Internet.\n    Verifique as conexões de rede ou contate o administrador ou o provedor.\n3- O apt-get pode estar ocupado no momento.\n    Não é possivel usar duas ou mais instâncias do apt-get ao mesmo tempo.\n4- O sistema não possui o apt-get ou não é um 'debian-like'.\n    Consulte a ajuda online do $TITLEMSG para mais detalhes.\n\nSe todas as possibilidades acima estão 'satisfeitas', experimente instalar\nmanualmente as seguintes dependências em falta:"
_NOTINSTALLED="não instalado"
_UPDATEREPO="Atualizando repositórios"
_INSTALLINGDEP="Instalando as dependências:"
_CHECKINSTALLEDDEP="Verificando se as dependências foram instaladas corretamente..."
_CANCELEDINSTDEP="Processo cancelado pelo usuário.\nSem as devidas dependências não será possivel continuar."
_CANCELED="Processo cancelado pelo usuário."
_MISSINGPKG="* Os seguintes pacotes necessários não estão instalados:"
_INSTALLDEPQUESTION="Deseja instalar as dependências em falta?"
_OPTIONSRAMDISK="Selecione o tamanho da RAMDISK:"
_DONTUSE="Não utilizar"
_ERRORDOWNLOAD="Falha ao baixar o pacote. Isso pode ter ocorrido devido a conexão com a internet ou a versão do pacote solicitada não existe."
_LOWMEM="para  7GB RAM ou menos"
_8GB="para  8GB RAM ou mais"
_10GB="para 10GB RAM ou mais"
_12GB="para 12GB RAM ou mais"
_14GB="para 14GB RAM ou mais"
_16GB="para 16GB RAM ou mais"
_18GB="para 18GB RAM ou mais"
_OPTIONSCORE="Selecione o número de núcleos a serem usados durante a compilação. Recomenda-se utilizar `grep "processor" /proc/cpuinfo | wc -l` núcleos para este sistema. Utilizar mais núcleos ou menos núcleos que a quantidade real de núcleos do(s) processador(es) pode causar queda de performance durante a compilação."
_USELOCALFILE="Usar um arquivo local"
_DOWNLOADFROMURL="Baixar a partir de uma URL"
_PLATFORM="Plataforma"
_OPTIONSPLATFORM="Selecione a plataforma desejada:" 
_PLATFORMGENERIC="Genérico / GRUB"
_PLATFORMPS3="PlayStation 3 / kboot"
_OPTIONSDOWNLOAD="Selecione uma forma de adquirir o pacote do Kernel:"
_DOWNLOADFROMKERNELORG="Baixar pacote de Kernel.org"
_DELETEPREVIOUSDIR="Removendo arquivo linux-$KERNELVERSION.tar.xz previamente baixado."
_OPTIONSWHENCOMPLETE="Executar ação ao terminar:"
_RUMCMD="Executar comando personalizado"
_SHUTDOWN="Desligar"
_REBOOT="Reiniciar"
_DELETEPREVIOUSFILE="Removendo arquivo"
_NOTHINGTODO="Nada a fazer"
_MENUCONFIG="menuconfig (modo texto)"
_MAKEMENUCONFIG="menuconfig"
_XCONFIG="xconfig (modo gráfico)"
_MAKEXCONFIG="xconfig"
_CONFIGMODE="Modo de configuração"
_UPDATEINITRAMFS="Gerando initramfs"
_OPTIONSSETUP="Selecione uma interface de configuração:"
_INVALIDVERSION="Versão do Kernel inválida. Digite valores como $MAINKERNEL ou 3.1"
_ENTERURL="Digite a URL do pacote a ser baixado:"
_ENTERLOCAL="Digite o caminho do pacote:"
_ERRORURL="O arquivo digitado não existe. Verifique o caminho digitado."
_RUNENDCOMMAND="Digite o comando a ser executado ao término:"
_DOWNLOADINGKERNEL="Baixando pacote do Kernel"
_DOWNLOADCOMPLETE="Download concluido."
_COPYINGSOURCE="Copiando pacote para"
_EXTRACTINGSOURCE="Extraindo pacote para"
_COMPILING="Compilando"
_ENTERKERNELVERSION="Digite a versão do Kernel (ex: $MAINKERNEL)"
_STARTINGPROCESS="Iniciando processos de compilação"
_DELETINGDIR="Removendo pasta previamente trabalhada:"
_ERRORCONFIG="Não foi possivel localizar o arquivo .config, necessário para compilar o Kernel. Na interface de configuração, salve antes de sair."
_COMPILINGKERNEL="Compilando Kernel"
_INSTALLINGMODULES="Instalando módulos"
_INSTALLINGKERNEL="Instalando Kernel"
_UPDATEINITFAMFS="Atualizando Initramfs"
_UPDATINGKBOOT="Atualizando o kboot.conf:"
_UPDATINGGRUB="Atualizando GRUB"
_GETVERSION="Verificar última versão do Kernel"
_ENTERVERSION="Digitar versão desejada"
_SELECTKERNEL="Versão do Kernel"
_AUTODEFINECORE="Definir automaticamente"
_ERRORUPDATEVERSION="Erro ao verificar a última versão do Kernel. Verifique a conexão com a internet."
_UMOUNTINGRAMDISK="Desmontando RAMDISK"
_COPYINGFILESTOUSRSRC="Copiando arquivos para"
_TOTALEXECUTIONTIME="Tempo total de execução:"
_COMPILATIONCOMPLETEFINISH="Compilação concluida. Novo Kernel instalado:"
_DELETEDEB="Removendo pacotes conflitantes"
_RUNUPDATE="Verificar atualizações"
_UPDATEEXECNOUP="Esta versão do KFN é a mais recente"
_UPDATEEXECNEW="Novo Kernel for Newbies disponível:"
_UPDATENOEXEC="Verifique atualização do Kernel e do KFN"
_KERNELNOTINSTALLED="FATAL: Kernel não instalado corretamente"
_SUCESSFULLKERNELINSTALLED="Kernel instalado corretamente"
_HEADERSNOTINSTALLED="FATAL: Cabeçalhos não instalados corretamente"
_SUCESSFULLHEADERSINSTALLED="Cabeçalhos instalados corretamente"
_UNABLE="Desativado"
_ERRORKERNELHEADERS="* Houve falha ao instalar o Kernel ou os cabeçalhos, isso pode causar malfuncionamento do sistema se executar este Kernel. Se você acredita que esta pode ser uma falha do $TITLEMSG, não deixe de nos comunicar em nosso forum, em:\n"
_OTHERS="Outros"
_SELECTPROC="Atenção: o uso INCORRETO de CFLAGS para seu processador pode causar problemas na compilação do Kernel, tornando-o instável ou até mesmo inoperável. O uso CORRETO de CFLAGS pode proporcionar grande ganho de desempenho em diversos casos."
_OPTIMIZATION="Performance (CFLAGS)"
_TESTCOMPILATION="Executando teste de compilação"
_ERRORTESTCOMPILE="O GCC não compilou o teste com sucesso. Verifique se seu GCC está funcionando corretamente, caso contrário, experimente reinstalá-lo ou atualizá-lo. Você deseja continuar a compilação mesmo assim?"
_PASSTESTCOMPILE="Teste concluído com sucesso."
_TESTCOMPILATIONERROR="Falha ao executar o teste de compilação.\nO Sistema retornou o seguinte resultado:"
_AUTOCONFIG="Auto configurar (teste)"
_AUTOCONFIGERROR="Não foi possivel habilitar a configuração automática: Configuração do Kernel `uname -r` não encontrada."
_CPCONFIG="Utilizando o arquivo de configuração do Kernel `uname -r`"
_COMPRESS="Compactando pacotes compilados do Kernel"
_COMPRESSOK="Pacote do Kernel compactado em:"
_COMPRESSERROR="Erro desconhecido ao compactar pacote do Kernel."
_EXISTKERNEL="Ja existe um kernel com a versão selecionada instalada em seu sistema. Deseja removê-lo?"
_VERSIONRUN="A versão selecionada do Kernel é a mesma em execução:\n\n`uname -r`\n\nSelecione outra versão do Kernel ou reinicie o sistema utilizando uma versão diferente do Kernel."
_VERSIONRUN1="A versão selecionada do Kernel é a mesma em execução: `uname -r`. Selecione outra versão do Kernel ou reinicie o sistema utilizando uma versão diferente do Kernel."
_REMOVEKERNEL="Desinstalando Kernel"
_CANCELREMOVEKERNEL="Remoção do Kernel cancelada. Não é possivel continuar."
_ERRORMACOS="\nDesculpe, mas o Kernel for Newbies não pode ser executado em Mac OS X.\nEntretanto, você poderá executá-lo no Linux em uma máquina virtual :)\n"
_AUTODETECT="Auto detectar"
_AUTODETECT1="Detectar automaticamente"
_CFLAGSMSG="A melhor configuração de performance para esta máquina é:"
_WAIT="Aguarde enquanto o sistema realiza algumas verificações..."
_APPLYCFLAGS="Aplicando configurações de performance"
_APPLYPATCH="Aplicar Patches"
_APPLYPATCH1="Aplicando Patches"
_DOWNLOADPATCH="Baixando Patches"
_DEFAULTKERNEL="Kernel Padrão (KFN)"
_INSTALLKERNEL="Instalando Kernel"
_SELECTKERNEL="Kernel selecionado"
_SAVEDLOG="Log salvo em:"
_NEWVERSION="Nova versão está disponível:"
_NEWVERSION1="Deseja atualizar para a versão mais recente?"
_DEVELOPER="Modo desenvolvedor"
_UPDATEOK="Atualização concluída.\nExecute novamente o Kernel for Newbies."
_UPDATINGKFN="Atualizando $TITLEMSG para a versão mais recente" 
_CHECKKFNUPDATE="Verificando atualizações do Kernel for Newbies"
_CHECKKERNELUPDATE="Verificando atualizações do Kernel em Kernel.org"
_404URL="O arquivo do link do Kernel não existe ou não está disponivel no momento. Verifique o link ou tente mais tarde."
_KERNELVERSIONCHECK=" << novo Kernel disponível"
_KERNELVERSIONCHECK1="Novo Kernel disponível:"
_KERNELVERSIONCHECKOK=" - Seu kernel está atualizado"
_NOSPACE="Não há espaço suficiente em disco. É Necessário ter, no mínimo, 10 GB em disco livres para a compilação do Kernel. Você atualmente tem"
_NOSPACE1="GB livres em disco. Elimine programas desnecessários, arquivos temporários, compilações e Kerneis antigos para liberar mais espaço em disco. Você pode continuar por sua conta e risco."
_DETECTEDVERSION="Versão reconhecida:"
_INSTALLBIN="Instalando Kernel for Newbies"
_OKSETUP="Instalação concluída. Execute o comando:\n\n    sudo kfn\n\npara executar o $TITLEMSG"
_TEMPERATURE="Temperatura do processador"
_EXITLOG="Kernel for Newbies foi encerrado. Log salvo em:"
_ERRORDOWNLOADKFN="Erro ao instalar o KFN. Verifique sua conexão com a internet."
_NEWDIR="Configuração de atualização concluída. Por favor, reinicie o KFN."
_ANDROID="Erro: o KFN não pode ser executado diretamente na plataforma Android, entretanto, você pode executá-lo utilizando alguma distribuição Linux rodando paralelamente com o Android, como sistemas virtualizados ou pelo comando 'chroot'."
_ADVANCED="Opções avançadas"
_ADVANCEDTXT="Sobre o KFN, Benchmark e outras opções"
_LANGUAGE="Idioma"
_LANGUAGETXT="Mude o idioma do KFN"
_LANGUAGETITLE="ID/Idioma:"
_LANGUAGEEXIT="Idioma configurado. Reinicie o KFN."
;;
	english)

_GENERALOPTIONS="System: Kernel `uname -r` - `cat /etc/issue.net` (`file /bin/bash | cut -d' ' -f3`/`dpkg --print-architecture`)"
_KERNELVERSIONTXT="Kernel version"
_SOURCEPACKAGE="Package source"
_URL="URL/Path"
_CORES="Cores to be used"
_CORES1="Cores"
_CORE1="Core"
_COMPILERAMDISK="Compile via RAMDISK"
_WHENCOMPLETE="Command when finish"
_STARTPROCESS="Start process"
_YES="Yes"
_NO="No"
_AUTO="Automatic"
_CANCEL="Cancel"
_ERROR="[ Erro ]"
_OK="[  OK  ]"
_32BITERROR="Your operating system is not a 64-bit system, which may not work with RAMDISK required."
_NOROOT="$TITLEMSG\nSorry, you must run this program as root user.\nTry as: 'sudo kfn'"
_CHECKDEP="Checking dependencies..."
_SUCESSFULLINSTALL="\nThe dependencies are installed correctly."
_ERRORDEP="Error installing dependencies. Possible causes:\033[0m\n\n1- The software package system is outdated.\n    Run 'sudo apt-get update' and try again.\n2- The computer isn't connected to the Internet.\n    Check your network connections or contact your administrator or ISP.\n3- Apt-get can be busy at the moment.\n    It is not possible to use two or more instances of apt-get at the same time.\n4- The system does not have the aptitude or not are a 'debian-like' system.\n    Check online help of $TITLEMSG for more info.\n\nIf all the above possibilities are 'satisfied', try installing\nmanually the following missing dependencies:"
_NOTINSTALLED="not installed"
_UPDATEREPO="Updating repositories"
_INSTALLINGDEP="Installing dependencies:"
_CHECKINSTALLEDDEP="Checking if the dependencies are installed correctly..."
_CANCELEDINSTDEP="Process canceled by user.\nWithout appropriate dependencies will not be possible to continue."
_CANCELED="Process canceled by user."
_MISSINGPKG="* The following required packages are not installed:"
_INSTALLDEPQUESTION="Want to install the missing dependencies?"
_OPTIONSRAMDISK="Select the size of RAMDISK:"
_DONTUSE="Do not use"
_ERRORDOWNLOAD="Failed to download the package. This may be due to internet connection or the version of the package requested does not exist."
_LOWMEM="for  7GB RAM or more"
_8GB="for  8GB RAM or more"
_10GB="for 10GB RAM or more"
_12GB="for 12GB RAM or more"
_14GB="for 14GB RAM or more"
_16GB="for 16GB RAM or more"
_18GB="for 18GB RAM or more"
_OPTIONSCORE="Select the number of cores to be used during compilation. It is recommended to use `grep "processor" /proc/cpuinfo | wc -l` cores for this system. Using more cores or fewer cores than the actual amount of cores(s) of processor(s) can reduse performance during compilation."
_USELOCALFILE="Use a local file"
_DOWNLOADFROMURL="Download from a URL"
_PLATFORM="Platform"
_OPTIONSPLATFORM="Select the desired platform:" 
_PLATFORMGENERIC="Generic / GRUB"
_PLATFORMPS3="PlayStation 3 / kboot"
_OPTIONSDOWNLOAD="Select a way to acquire the package kernel:"
_DOWNLOADFROMKERNELORG="Download from Kernel.org"
_DELETEPREVIOUSDIR="Removing file linux-$KERNELVERSION.tar.xz previously downloaded."
_OPTIONSWHENCOMPLETE="Take action to finish:"
_RUMCMD="Run custom command"
_SHUTDOWN="Shutdown"
_REBOOT="Reboot"
_DELETEPREVIOUSFILE="Deleting file"
_NOTHINGTODO="Nothing to do"
_MENUCONFIG="menuconfig (text mode)"
_MAKEMENUCONFIG="menuconfig"
_XCONFIG="xconfig (graphic mode)"
_MAKEXCONFIG="xconfig"
_CONFIGMODE="Configuration mode"
_UPDATEINITRAMFS="Generating initramfs"
_OPTIONSSETUP="Select a configuration interface:"
_INVALIDVERSION="Kernel version invalid. Enter values ​​as $MAINKERNEL or 3.9"
_ENTERURL="Enter the URL of the package to be downloaded:"
_ENTERLOCAL="Enter the path of the package:"
_ERRORURL="The file type does not exist. Check the path entered."
_RUNENDCOMMAND="Enter the command to be executed at the end:"
_DOWNLOADINGKERNEL="Downloading the Kernel package"
_DOWNLOADCOMPLETE="Download complete."
_COPYINGSOURCE="Copying package to"
_EXTRACTINGSOURCE="Extracting package to"
_COMPILING="Compiling"
_ENTERKERNELVERSION="Enter the version of the Kernel (ex: $MAINKERNEL)"
_STARTINGPROCESS="Starting compilation processes"
_DELETINGDIR="Removing folder previously worked:"
_ERRORCONFIG="Unable to locate the .config file, needed to compile the kernel. In interface configuration, save before exiting."
_COMPILINGKERNEL="Compiling Kernel"
_INSTALLINGMODULES="Installing modules"
_INSTALLINGKERNEL="Installing Kernel"
_UPDATEINITFAMFS="Updating Initramfs"
_UPDATINGKBOOT="Updating kboot.conf:"
_UPDATINGGRUB="Updating GRUB"
_GETVERSION="Check last version of Kernel"
_ENTERVERSION="Enter desired version"
_SELECTKERNEL="Kernel version"
_AUTODEFINECORE="Automatically set"
_ERRORUPDATEVERSION="Error checking the latest kernel version. Check the internet connection."
_UMOUNTINGRAMDISK="Unmounting RAMDISK"
_COPYINGFILESTOUSRSRC="Copying files to"
_TOTALEXECUTIONTIME="Execution time:"
_COMPILATIONCOMPLETEFINISH="Compilation complete. New Kernel installed:"
_DELETEDEB="Removing conflicting packages"
_RUNUPDATE="Check for updates"
_UPDATEEXECNOUP="This version of KFN is the latest"
_UPDATEEXECNEW="New KFN available :"
_UPDATENOEXEC="Checking for kernel and KFN update"
_KERNELNOTINSTALLED="FATAL: Kernel not installed correctly"
_SUCESSFULLKERNELINSTALLED="Kernel installed correctly"
_HEADERSNOTINSTALLED="FATAL: Headers not installed correctly"
_SUCESSFULLHEADERSINSTALLED="Headers installed correctly"
_UNABLE="Disabled"
_ERRORKERNELHEADERS="* Failed to install the kernel and headers, it can cause malfunction of the system running this Kernel. If you believe that this can be a failure of $TITLEMSG, be sure to let us know in our forum, in:\n"
_OTHERS="Others"
_SELECTPROC="Warning: INCORRECT usage of CFLAGS for your processor can cause problems when compiling the kernel, making it unstable or even inoperable. The CORRECT use of CFLAGS can provide large performance gains in several cases."
_OPTIMIZATION="Performance (CFLAGS)"
_TESTCOMPILATION="Running test compilation"
_ERRORTESTCOMPILE="The GCC did not compile the test successfully. Check if your GCC is working properly, otherwise, try to reinstall it or upgrade it. You want to continue to build anyway?"
_PASSTESTCOMPILE="Test completed successfully."
_TESTCOMPILATIONERROR="Failed to run the test build.\nThe system returned the following results:"
_AUTOCONFIG="Auto configure (testing)"
_AUTOCONFIGERROR="Unable to enable automatic configuration: Kernel `uname -r` configuration not found."
_CPCONFIG="Using the configuration file Kernel `uname -r`"
_COMPRESS="Compressing packages compiled Kernel"
_COMPRESSOK="Kernel Package compacted:"
_COMPRESSERROR="Unknown error compress package Kernel."
_EXISTKERNEL="There is already a kernel with the selected version installed on your system. Want to remove it?"
_VERSIONRUN="The selected version of the same kernel is running:\n\n`uname -r`\n\nSelect another version of the kernel or reboot the system using a different version of the kernel."
_VERSIONRUN1="The selected version of the same kernel is running: `uname -r`. Select another version of the kernel or reboot the system using a different version of the kernel."
_REMOVEKERNEL="Removing Kernel"
_CANCELREMOVEKERNEL="Removing Kernel canceled. It is not possible to continue."
_ERRORMACOS="\nSorry, the Kernel for Newbies can not run on Mac OS X.\nHowever, you can run it on Linux in a virtual machine :)\n"
_AUTODETECT="Auto detect"
_AUTODETECT1="Automatically detect"
_CFLAGSMSG="The best performance setting for this machine is:"
_WAIT="Wait while the system performs some checks..."
_APPLYCFLAGS="Applying performance settings"
_APPLYPATCH="Apply Patch"
_APPLYPATCH1="Applying Patch"
_DOWNLOADPATCH="Downloading Patches"
_DEFAULTKERNEL="Default Kernel (KFN)"
_INSTALLKERNEL="Installing Kernel"
_SELECTKERNEL="Selected Kernel"
_SAVEDLOG="Log saved in:"
_NEWVERSION="New version is available:"
_NEWVERSION1="Want to upgrade to the latest version?"
_DEVELOPER="Developer mode"
_UPDATEOK="Update complete.\nRun KFN again."
_UPDATINGKFN="Updating $TITLEMSG for the latest version" 
_CHECKKFNUPDATE="Checking for KFN updates"
_CHECKKERNELUPDATE="Checking for updates on Kernel Kernel.org"
_404URL="The file link kernel does not exist or is not available at the moment. Check the link or try again later."
_KERNELVERSIONCHECK=" << new Kernel available"
_KERNELVERSIONCHECK1="New Kernel available:"
_KERNELVERSIONCHECKOK=" - This kernel is upgraded"
_NOSPACE="There is not enough disk space. It is required to have at least 10 GB free disk to compile a kernel. You currently have"
_NOSPACE1="GB free disk. Eliminate unnecessary programs, temporary files, and compilations Kerneis old to free up more disk space. You can proceed at your own risk."
_DETECTEDVERSION="Version recognized:"
_INSTALLBIN="Installing Kernel for Newbies"
_OKSETUP="Setup complete. Run the command:\n\n    sudo kfn\n\nto run $TITLEMSG"
_TEMPERATURE="Processador temperature"
_EXITLOG="Kernel for Newbies was closed. Log save in:"
_ERRORDOWNLOADKFN="Error installing KFN. Check your internet connection."
_NEWDIR="Configuration update completed. Please restart the KFN."
_ANDROID="Error: KFN can not be run directly on the Android platform, however, you can run it using a Linux distribution running parallel with Android as virtualized systems or the 'chroot' command."
_ADVANCED="Advanced options"
_ADVANCEDTXT="About KFN, Benchmark and others options"
_LANGUAGE="Language"
_LANGUAGETXT="Change language of KFN"
_LANGUAGETITLE="ID/Language:"
_LANGUAGEEXIT="Language set. Restart the KFN."
;;

	*) rm $HOME/.kfn/language
	echo -e "\nError reading language file. FIXED! Restart KFN.\n"
	exit
;;

esac

################################################################################

# Variáveis com valores padrão: (evite alterá-las, caso contrário, muito cuidado)

KERNELVERSIONCHECK=""
_DOWNLOADTXT="$_DOWNLOADFROMKERNELORG"
_WHENCOMPLETETXT="$_NOTHINGTODO"
NUMBERCORE=`grep "processor" /proc/cpuinfo | wc -l`
_NUMBERCORE=$NUMBERCORE
RAMDISKTXT="$_NO"
RAMDISK=0
RAMDISKSIZE=0
RAMDISKMOUNT=0
SELECTEDCORE=0
_PLATFORMTXT="$_PLATFORMGENERIC"
URL=0
_SETUPTXT="$_MENUCONFIG"
_INTERFACE="$_MAKEMENUCONFIG"
ARCH="`dpkg --print-architecture`"
_CODENAMETXT="kfn-$ARCH"
_UPDATEEXECTXT="$_UPDATENOEXEC"
_CFLAGSTXT="$_AUTODETECT1"
_SETCFLAGS=1
_MODCFLAGS=0
_PATCHTXT="$_NO"
_MENUCFLAGS=0
DEBIANCOUNTER=200
FREESIZE=10485760
_SYSTEMERROR=0

################################################################################

clear
echo -e "\033[1;36mKernel for newbies (v$KFNVERSION)\033[0m"

if [ "$USER" != root ]
then
	if [ -f /usr/local/bin/kfn ]
	then
		sudo kfn
		exit
	else
		echo -e "\033[1;36m$_NOROOT\033[0m"
		exit
	fi
fi

################################################################################

_exit() # Função "exit" personalizada para evitar problemas com RAMDISK
{
	if [ "$RAMDISK" -eq "1" ]
	then
		umount $HOME/.kfn_tmp/ramdisk
	fi
	echo "[`date +%H:%M:%S`] Exit: `date +%d/%m/%Y` - `date +%H:%M:%S`" >> "$LOGKFN"
	echo
	echo -e "\033[1;36m[`date +%H:%M:%S`] $_SAVEDLOG $LOGKFN\n\033[0m"
	exit
}

################################################################################

LOGKFN="/usr/src/kfn/`date +[%m-%d-%y]-%Hh%Mm%Ss.log`"

if [ -f /usr/bin/kfn ]
then
	mv /usr/bin/kfn /usr/local/bin/kfn # A partir da versão 2.2, o KFN executará de /usr/local/bin, por questões de organização.
	echo -e "\033[1;36m\n$_NEWDIR\033[0m"
	echo "[`date +%H:%M:%S`] $_NEWDIR" >> "$LOGKFN"
	_exit
fi

if [ ! -f /usr/local/bin/kfn ]
then
	if [ -f /home/test/kfn/kfn.sh ]
	then
		ln -s /home/test/kfn/kfn.sh /usr/local/bin/kfn
	else
		echo -e "\033[1;36m\n$_INSTALLBIN\033[0m"
		echo "[`date +%H:%M:%S`] $_INSTALLBIN" >> "$LOGKFN"
		wget $KFNLINKUPDATE -O /usr/local/bin/kfn
		chmod 777 /usr/local/bin/kfn
		if [ -f /usr/local/bin/kfn ]
		then
			echo -e "\033[1;36m\n$_OKSETUP\033[0m"
			echo "[`date +%H:%M:%S`] $_UPDATEOK" >> "$LOGKFN"
		else
			echo -e "\033[1;31m$_ERRORDOWNLOADKFN\033[0m"
			echo "[`date +%H:%M:%S`] $_ERRORDOWNLOADKFN" >> "$LOGKFN"
		fi
	fi
	_exit
fi

if [ -f /boot/config-`uname -r` ]
then
	AUTOCONFIG=1
	_AUTOCONFIGTXT="$_NO"
	ENABLEAUTOCONFIG=1
else
	AUTOCONFIG=0
	_AUTOCONFIGTXT="$_NO"
	ENABLEAUTOCONFIG=0
fi

if [ -f /mach_toh ]
then
	echo -e "\033[1;31m$_ERRORMACOS\033[0m"
	_SYSTEMERROR=1
fi

if [ -f /mach_kernel ]
then
	echo -e "\033[1;31m$_ERRORMACOS\033[0m"
	_SYSTEMERROR=1
fi

if [ $_SYSTEMERROR == 1 ]
then
	exit
fi

if [ ! -d $HOME/.kfn_tmp/ ]
then
	mkdir $HOME/.kfn_tmp/
else
	rm -r $HOME/.kfn_tmp/
	mkdir $HOME/.kfn_tmp/
fi

if [ ! -d /usr/src/kfn ]
then
	mkdir /usr/src/kfn
fi

chmod 777 /usr/src/kfn

echo $LOGKFN > /usr/src/kfn/.last

touch "$LOGKFN"

chmod 777 -R /usr/src/kfn

echo "$MAINKERNEL" > $HOME/.kfn_tmp/kernelversion

echo "[`date +%H:%M:%S`] Start: `date +%d/%m/%Y` - `date +%H:%M:%S`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] $TITLEMSG - Release: $RELEASEDATE" >> "$LOGKFN"
CPUINFO=`grep -m 1 "model name" /proc/cpuinfo` && CPUINFO="`echo ${CPUINFO/model/}`" && CPUINFO="`echo ${CPUINFO/name/}`" && CPUINFO="`echo ${CPUINFO/:/}`"
echo "[`date +%H:%M:%S`] Processador: $CPUINFO (`grep "processor" /proc/cpuinfo | wc -l` núcleos)" >> "$LOGKFN"
MEM=(`free -o -m | grep Mem`)
MEM=${MEM[1]}
echo "[`date +%H:%M:%S`] Memória RAM: $MEM MB" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] $_DEFAULTKERNEL: $MAINKERNEL" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] $_GENERALOPTIONS" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] gcc: `gcc --version | grep gcc -m 1`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] cc: `cc --version | grep cc -m 1`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] g++: `g++ --version | grep g++ -m 1`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] make: `make --version | grep Make -m 1`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] dialog: `dialog --version`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] axel: `axel --version | grep Axel -m 1`" >> "$LOGKFN"
echo "[`date +%H:%M:%S`] wget: `wget --version | grep Wget -m 1`" >> "$LOGKFN"

################################################################################

_hddfree() # Função que verifica se o HD possui espaço suficiente livre para executar os processos
{
	HDDFREE=(`df | grep /dev/`)
	
	if [ ${HDDFREE[3]} -le "$FREESIZE" ]
	then
		HDDFREE1=$((${HDDFREE[3]}/1048576))
		dialog --title "$TITLEMSG" --msgbox "\n$_NOSPACE $HDDFREE1 $_NOSPACE1" 11 75
		echo "[`date +%H:%M:%S`] $_NOSPACE $HDDFREE1 $_NOSPACE1" >> "$LOGKFN"
		echo
	fi
}

################################################################################

_numbercore() # Função que define o número de núcleos do processador da máquina
{
	if [ $SELECTEDCORE == 0 ]
	then
		case "$NUMBERCORE" in
		    1|2|3|4|6|8|10|12|14|16|20|24|32|48|64|96|112|128|192|225|256|384|448|512|1024)
			;;
		    *) 	NUMBERCORE="2"
		esac 
	fi
}

################################################################################

echo
echo -e "\033[1;36m$_CHECKDEP\033[0m"
echo

TESTDEP1=0
TRY_INSTALL=0

################################################################################

_cancel() # Função que exibe uma mensagem caso o usuário cancele uma operação
{
	dialog --title "$TITLEMSG" --msgbox "\n$_CANCELED" 7 40
	clear
	_exit
}

################################################################################

_check_dep() # Função que verifica se há dependências em falta no sistema
{
	DEP=""
	TESTDEP=0
	DEPPKG="$DEPENDENCES"
	INSTALLEDPKG="`dpkg --get-selections`"	
	for PACKAGE in $DEPPKG
	do
		if [ `echo $INSTALLEDPKG | grep " $PACKAGE" | wc -l` -eq 0 ]
		then
			DEP="$DEP $PACKAGE"
			echo -e "\033[1;31m$_ERROR\033[0m $PACKAGE: $_NOTINSTALLED\033[0m"
			TESTDEP=1
		else
			echo -e "\033[1;36m$_OK\033[0m $PACKAGE\033[0m"
		fi
	done

	INSTALLDEP=0
}

_check_dep

################################################################################

_gensubversion() # Função que gera a versão, subversão e revisão do Kernel para finalidades de compilação e instalação
{
	KERNELVERSION=`cat $HOME/.kfn_tmp/kernelversion`
	KERNELVERSION=`echo ${KERNELVERSION/./ }`
	KERNELVERSION=`echo ${KERNELVERSION/./ }`
	KERNELVERSION1=($KERNELVERSION)
	KERNEL1=`echo ${KERNELVERSION1[0]}`
	KERNEL2=`echo ${KERNELVERSION1[1]}`
	KERNEL3=`echo ${KERNELVERSION1[2]}`

	case "$KERNEL1" in
	    0|1|2|3|4|5|6|7|8|9)
		;;
	    *) 	ERROR=1
		;;
	esac
	case "$KERNEL2" in
	    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20)
		;;
	    *) 	ERROR=1
		;;
	esac
	case "$KERNEL3" in
	    0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40)
		;;
	    *) 	KERNEL3=0 # para se adaptar à nova numeração, qualquer valor INTEIRO
		;;        # diferente entre 0 e 40 é assumido como 0. O script se encarrega
	esac              # com o resto.

	# Gerando regras para a versão:

	if [ "$ERROR" != 1 ]
	then
		if [ "$KERNEL3" -eq 0 ]
		then
			KERNELVERSION="$KERNEL1.$KERNEL2"
		else
			KERNELVERSION="$KERNEL1.$KERNEL2.$KERNEL3"
		fi
		
		if [ "$KERNEL1" -eq 2 ]
		then
			KERNELVERSION="$KERNEL1.$KERNEL2.$KERNEL3"
		fi
		
		if [ "$KERNEL1" -eq "3" ] # Versão
		then
			GENSUBVERSION=x
		else		        
			GENSUBVERSION=$KERNEL2
		fi
	else
		dialog --title "$TITLEMSG" --msgbox "\n$_INVALIDVERSION" 8 60
		KERNELVERSION=$MAINKERNEL
	fi
}

################################################################################

install_dep() # Função que instala as dependêncas no sistema (se permitido)
{
	case "$INSTALLDEP" in
	    1)  echo -e "\033[1;36m$_UPDATEREPO\033[0m"
		apt-get update
		echo -e "\033[1;36m$_INSTALLINGDEP$DEP\033[0m"
		apt-get install $DEP ncurses-dev -y --no-install-recommends
		apt-get install qt3-dev-tools -y --no-install-recommends
		apt-get install qt4-dev-tools -y --no-install-recommends
		apt-get build-dep linux -y --no-install-recommends
		TESTDEP1=1
		# onde $DEP fica os valores das dependências em falta
		echo
		echo -e "\033[1;36m$_CHECKINSTALLEDDEP\033[0m"
		echo
		TRY_INSTALL=1
		_check_dep
		_set_dep # _set_dep é repetido aqui para testar se as dependências
	    	;;	 # foram instaladas corretamente.
	    2)	echo -e "\033[1;36m$_CANCELEDINSTDEP\033[0m"
		_exit
	    	;;
	    *) 	echo
		echo -e "$_MISSINGPKG\033[1;36m$DEP\033[0m"
		echo -e "$_INSTALLDEPQUESTION (\033[1;36m 1=$_YES\033[0m / \033[1;31m2=$_NO \033[0m)"
		read INSTALLDEP
		install_dep
		;;
	esac
}

################################################################################

_set_dep() # Função que verifica se as dependências estão instaladas
{
	if [ $TESTDEP -eq 1 ]
	then
		if [ $TRY_INSTALL -eq 1 ]
		then
			echo 
			echo -e "\033[1;31m $_ERRORDEP\n\n\033[1;36m$DEP\033[0m"
			_exit
		fi
		install_dep
	fi
}

_set_dep

if [ $TESTDEP1 -eq 1 ]
then
	dialog --title "$TITLEMSG" --msgbox "$_SUCESSFULLINSTALL" 7 50 
fi

_hddfree

################################################################################

_check_bit() # Função que verifica se o processador da máquina é arquitetura 32 ou 64 bits. Isso depende do sistema operacional em execução. Esta função depende da arquitetura para habilitar (ou não) a compilação via RAMDISK. Não recomendo "burlar" esta função para trabalhar em máquinas 32 bits ou com pouca memória RAM, pois pode haver resultados inesperados. Não aplica a instalações com Kernel com suporte a PAE.
{
	CHKBIT=`file /bin/bash | cut -d' ' -f3`
	if [ "$CHKBIT" == "64-bit" ]
	then
		RAMDISKSIZE=$( dialog --title "$TITLEMSG" \
		      --stdout                            \
		      --menu "$_OPTIONSRAMDISK"           \
		      0 0 0                               \
		      "$_DONTUSE" "$_LOWMEM"              \
		      "7G" "$_8GB"                        \
		      "8G" "$_10GB"                       \
		      "9G" "$_10GB"                       \
		      "10G" "$_12GB"                      \
		      "11G" "$_12GB"                      \
		      "12G" "$_14GB"                      \
		      "13G" "$_14GB"                      \
		      "14G" "$_16GB"                      \
		      "15G" "$_16GB"                      \
		      "16G" "$_18GB" )

		case $RAMDISKSIZE in
			7G|8G|9G|10G|11G|12G|13G|14G|15G|16G)
				RAMDISK=1
				RAMDISKTXT="$_YES ($RAMDISKSIZE)"
					;;
			*)	RAMDISK=0
				RAMDISKTXT="$_NO"
					;;
		esac
	else
		dialog --title "$TITLEMSG" --msgbox "\n$_32BITERROR" 8 60
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_32BITERROR"
		RAMDISK=0
		RAMDISKTXT="$_NO"
	fi
}

################################################################################

_selectcore() # Função que permite ao usuário definir o número de núcleos a serem usados durante a compilação
{
	NUMBERCORE=$( dialog --title "$TITLEMSG" \
		      --stdout                   \
		      --menu "$_OPTIONSCORE"     \
		      0 70 0       	         \
		      "0" "$_AUTODEFINECORE"     \
		      "1" "$_CORE1"   \
		      "2" "$_CORES1"  \
		      "3" "$_CORES1"  \
		      "4" "$_CORES1"  \
		      "6" "$_CORES1"  \
		      "8" "$_CORES1"  \
		      "10" "$_CORES1" \
		      "12" "$_CORES1" \
		      "14" "$_CORES1" \
		      "16" "$_CORES1" \
		      "20" "$_CORES1" \
		      "24" "$_CORES1" \
 		      "32" "$_CORES1" \
 		      "48" "$_CORES1" \
 		      "64" "$_CORES1" \
 		      "96" "$_CORES1" \
		      "112" "$_CORES1" \
		      "128" "$_CORES1" \
		      "192" "$_CORES1" \
		      "225" "$_CORES1" \
		      "256" "$_CORES1" \
		      "384" "$_CORES1" \
		      "448" "$_CORES1" \
		      "512" "$_CORES1" \
		      "1024" "$_CORES1" \
		      "$_CANCEL" "" )

		case $NUMBERCORE in
			1|2|3|4|6|8|10|12|14|16|20|24|32|48|64|96|112|128|192|225|256|384|448|512|1024) SELECTEDCORE=1
					;;
			*) NUMBERCORE="$_NUMBERCORE"
					;;
		esac
}

################################################################################

_getkernelversion() # Função responsável por gerar o link de download do kernel de acordo com sua versão
{
	if [ -f $HOME/.kfn_tmp/kernelversion ]
	then
		rm $HOME/.kfn_tmp/kernelversion
	fi
	if [ -f $HOME/.kfn_tmp/release ]
	then
		rm $HOME/.kfn_tmp/release
	fi
	if [ -f $HOME/.kfn_tmp/kernel.org ]
	then
		rm $HOME/.kfn_tmp/kernel.org
	fi

	echo -e "\033[1;36m\n\n[`date +%H:%M:%S`] $_CHECKKFNUPDATE\033[0m"
	echo "[`date +%H:%M:%S`] $_CHECKKFNUPDATE" >> "$LOGKFN"
	
	wget $KFNLINKUPDATE -q -O $HOME/.kfn_tmp/kfn.sh

	chmod 777 $HOME/.kfn_tmp/kfn.sh

	KFNVERSIONUPDATE=`cat $HOME/.kfn_tmp/kfn.sh | grep KFNVERSION -m 1`
	TESTKFNVERSION="$KFNVERSIONUPDATE"
	KFNVERSIONUPDATE=`echo ${KFNVERSIONUPDATE/'KFNVERSION='/}`

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_CHECKKERNELUPDATE\033[0m"
	echo "[`date +%H:%M:%S`] $_CHECKKERNELUPDATE" >> "$LOGKFN"

	wget www.kernel.org -q -O $HOME/.kfn_tmp/kernel.org	

	KERNELORGVERSION=`cat $HOME/.kfn_tmp/kernel.org | grep "./pub/linux/kernel/v" -m 1`
	TESTKERNELVERION="$KERNELORGVERSION"
	KERNELORGVERSION=`echo ${KERNELORGVERSION/'<a href="./pub/linux/kernel/v'/ }`
	KERNELORGVERSION=`echo ${KERNELORGVERSION/'linux-'/ }`
	KERNELORGVERSION=`echo ${KERNELORGVERSION/'/'/ }`
	KERNELORGVERSION=`echo ${KERNELORGVERSION/'.tar'/ }`
	KERNELORGVERSION1=($KERNELORGVERSION)
	KERNELORGVERSION="${KERNELORGVERSION1[1]}"

	if [ `uname -r | grep $KERNELORGVERSION | wc -l` == 0 ]
	then
		KERNELVERSIONCHECK="$_KERNELVERSIONCHECK"
		KERNELVERSIONCHECK1="$_KERNELVERSIONCHECK1 $KERNELORGVERSION"
	else
		KERNELVERSIONCHECK="$_KERNELVERSIONCHECKOK"
		KERNELVERSIONCHECK1="$_KERNELVERSIONCHECKOK"
	fi

	TESTKERNELVERION=`echo "$TESTKERNELVERION" | grep kernel -m 1 | wc -l`

	if [ "$TESTKERNELVERION" == 1 ]
	then
		echo "$KERNELORGVERSION" > $HOME/.kfn_tmp/kernelversion
		_gensubversion
		URL="kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz"
	else
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_ERRORUPDATEVERSION"
		dialog --title "$TITLEMSG" --msgbox "\n$_ERRORUPDATEVERSION" 8 50
	fi

	TESTKFNVERSION="`echo "$TESTKFNVERSION" | grep KFNVERSION -m 1 | wc -l`"

	if [ "$TESTKFNVERSION" == 1 ]
	then
		if [ "$KFNVERSIONUPDATE" != "$KFNVERSION" ]
		then
			_UPDATEEXECTXT="$_UPDATEEXECNEW $KFNVERSIONUPDATE"
			notify-send -i gtk-dialog-info -u normal "$TITLEMSG" "$_UPDATEEXECNEW $KFNVERSIONUPDATE\n$KERNELVERSIONCHECK1"
			_gensubversion
			URL="kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz"

			dialog  --title "$TITLEMSG" --yesno "\n$_NEWVERSION $KFNVERSIONUPDATE \n$_NEWVERSION1 " 8 60
			if [ $? == 0 ]
			then
				echo -e "\033[1;36m\n[`date +%H:%M:%S`] $_UPDATINGKFN\033[0m"
				echo "[`date +%H:%M:%S`] $_UPDATINGKFN" >> "$LOGKFN"
				if [ -f /usr/local/bin/kfn ]
				then
					rm /usr/local/bin/kfn
				fi
				if [ -f /home/test/kfn/kfn.sh ]
				then
					echo -e "\033[1;36m\n[`date +%H:%M:%S`] $_DEVELOPER\033[0m"
					echo "[`date +%H:%M:%S`] $_DEVELOPER" >> "$LOGKFN"
					ln -s /home/test/kfn/kfn.sh /usr/local/bin/kfn
					dialog --title "$TITLEMSG" --msgbox "\n$_UPDATEOK" 8 60
					echo "[`date +%H:%M:%S`] $_UPDATEOK" >> "$LOGKFN"
					_exit
				else
					cp $HOME/.kfn_tmp/kfn.sh /usr/local/bin/kfn
					dialog --title "$TITLEMSG" --msgbox "\n$_UPDATEOK" 8 60
					echo "[`date +%H:%M:%S`] $_UPDATEOK" >> "$LOGKFN"
					_exit
				fi
			fi
		else
			notify-send -i gtk-dialog-info -u normal "$TITLEMSG" "$_UPDATEEXECNOUP\n$KERNELVERSIONCHECK1"
			_UPDATEEXECTXT="$_UPDATEEXECNOUP"
		fi
	fi
}

################################################################################

_kernelsource() # Função que define qual será a fonte do pacote do Kernel.
{
	_DOWNLOADTXT=$( dialog --title "$TITLEMSG"        \
		      --stdout                            \
		      --menu "$_OPTIONSDOWNLOAD"          \
		      0 0 0                               \
		      "$_DOWNLOADFROMKERNELORG" ""        \
		      "$_USELOCALFILE" ""                 \
		      "$_DOWNLOADFROMURL" "" )

	case $_DOWNLOADTXT in
		$_DOWNLOADFROMKERNELORG) _gensubversion
			URL="kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz"
			;;
		$_DOWNLOADFROMURL)
			dialog --title "$TITLEMSG" --inputbox "$_ENTERURL" 0 50  2>$HOME/.kfn_tmp/url
			URL="`cat $HOME/.kfn_tmp/url`"
			;;
		$_USELOCALFILE)
			dialog --title "$TITLEMSG" --inputbox "$_ENTERLOCAL" 0 50  2>$HOME/.kfn_tmp/url
			URL="`cat $HOME/.kfn_tmp/url`"
			URL1="`cat $HOME/.kfn_tmp/url`"
			if [ ! -f $URL ]
			then
				dialog --title "$TITLEMSG" --msgbox "\n$_ERRORURL" 8 50
				$_DOWNLOADTXT="$_DOWNLOADFROMKERNELORG"
				$KERNELVERSION="$MAINKERNEL"
				URL="www.kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz"
			fi
			;;
		$_GETVERSION)
			 _getkernelversion
			;;
		*) _DOWNLOADTXT="$_DOWNLOADFROMKERNELORG"
			;;
	esac
}

################################################################################

_platform() # Função que define a plataforma que o KFN irá trabalhar. Isso é extremamente importante, pois, selecionar uma plataforma diferente da qual você utiliza pode causar efeitos indesejados, como falha na instalação do Kernel
{
	_PLATFORMTXT=$( dialog --title "$TITLEMSG"       \
		      --stdout                           \
		      --menu "$_OPTIONSPLATFORM"         \
		      0 0 0                              \
		      "$_PLATFORMGENERIC" ""             \
		      "$_PLATFORMPS3" "" )

	case "$_PLATFORMTXT" in
		"$_PLATFORMGENERIC")
			;;
		"$_PLATFORMPS3")
			;;
		*) _PLATFORMTXT="$_PLATFORMGENERIC"
			;;
	esac
}

################################################################################

_whencomplete() # Função que executa um comando ao terminar a compilação
{
	_WHENCOMPLETETXT=$( dialog --title "$TITLEMSG"    \
		      --stdout                            \
		      --menu "$_OPTIONSWHENCOMPLETE"      \
		      0 0 0                               \
		      "$_SHUTDOWN" ""                     \
		      "$_REBOOT" ""                       \
		      "$_RUMCMD" ""                       \
		      "$_NOTHINGTODO" "")

	if [ "$_WHENCOMPLETETXT" == "$_SHUTDOWN" ]
	then
		CMD="halt"
	elif [ "$_WHENCOMPLETETXT" == "$_REBOOT" ]
	then
		CMD="reboot"
	elif [ "$_WHENCOMPLETETXT" == "$_RUMCMD" ]
	then
		dialog --title "$TITLEMSG" --inputbox "$_RUNENDCOMMAND" 0 50  2>$HOME/.kfn_tmp/runcmd
		CMD=`cat $HOME/.kfn_tmp/runcmd`
		_WHENCOMPLETETXT="$CMD"
	else
		_WHENCOMPLETETXT="$_NOTHINGTODO"
	fi
}

################################################################################

_setup() # Função que define qual utilitário de configuração do Kernel será utilizado antes da compilação
{
	_SETUPTXT=$( dialog --title "$TITLEMSG"    \
		      --stdout                     \
		      --menu "$_CONFIGMODE"        \
		      0 0 0                        \
		      "$_MENUCONFIG" ""            \
		      "$_XCONFIG" "")

	case "$_SETUPTXT" in
		"$_MENUCONFIG") _INTERFACE="menuconfig"
			;;
		"$_MENUCONFIG") _INTERFACE="xconfig"
			;;
		*) _SETUPTXT="$_XCONFIG"
			;;
	esac
}

################################################################################

_clear_tmp() # Função que remove arquivos conflitantes
{
	if [ -f linux-$KERNELVERSION.tar.xz ]
	then
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_DELETEPREVIOUSFILE linux-$KERNELVERSION.tar.xz\033[0m"
		echo "[`date +%H:%M:%S`] $_DELETEPREVIOUSFILE linux-$KERNELVERSION.tar.xz" >> "$LOGKFN"
		rm linux-$KERNELVERSION.tar.xz
	fi
}

################################################################################

_testdownload() # Função que verifica se o arquivo foi baixado corretamente.
{
	if [ ! -f linux-$KERNELVERSION.tar.xz ]
	then
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_ERRORDOWNLOAD"
		echo "[`date +%H:%M:%S`] $_ERRORDOWNLOAD" >> "$LOGKFN"
		dialog --title "$TITLEMSG" --msgbox "\n$_ERRORDOWNLOAD" 9 60
		_exit
	fi
}

################################################################################

_ramdisk() # Função que ativa ou desativa a RAMDISK.
{
	if [ ! -d $HOME/.kfn_tmp/ramdisk ]
	then 
		mkdir $HOME/.kfn_tmp/ramdisk
	else
		umount -f $HOME/.kfn_tmp/ramdisk
		rmdir $HOME/.kfn_tmp/ramdisk
		mkdir $HOME/.kfn_tmp/ramdisk
	fi
	RAMDISKMOUNT=1
}

################################################################################

_download() # Função que realiza o download do pacote do kernel
{
	_clear_tmp
	cd /usr/src/
	echo -e "\033[1;36m[`date +%H:%M:%S`] $_DOWNLOADINGKERNEL $KERNELVERSION:\033[0m"
	echo "[`date +%H:%M:%S`] $_DOWNLOADINGKERNEL $KERNELVERSION" >> "$LOGKFN"

	URL=${URL/"4.0"/"4.x"}

	wget --spider --quiet "$URL" && URLTEST=1 || URLTEST=0
	if [ $URLTEST == 1 ]
	then
		axel -a "$URL" -o /usr/src/linux-$KERNELVERSION.tar.xz
		_testdownload
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_DOWNLOADCOMPLETE\033[0m"
		echo "[`date +%H:%M:%S`] $_DOWNLOADCOMPLETE" >> "$LOGKFN"
	else
		echo "[`date +%H:%M:%S`] $_404URL" >> "$LOGKFN"
		dialog --title "$TITLEMSG" --msgbox "\n$_404URL" 9 60
		_exit
	fi
}

################################################################################

_kernelversion() # Função que permite ao usuário selecionar o kernel a ser compilado
{
	SELECTKERNEL=$( dialog --title "$TITLEMSG"         \
		      --stdout                             \
		      --menu "$_SELECTKERNEL"              \
		      0 0 0                                \
		      "$_ENTERVERSION" ""                  \
		      "$_GETVERSION" "" )

	case $SELECTKERNEL in
		"$_ENTERVERSION")
			dialog --title "$TITLEMSG" --inputbox "$_ENTERKERNELVERSION" 0 50  2>$HOME/.kfn_tmp/kernelversion
			KERNELVERSIONCHECK=""
			_gensubversion
			URL="kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz"
				;;
		"$_GETVERSION")
			_getkernelversion
				;;
		*)
				;;
	esac
	URL="kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz"
}

################################################################################

_autoconfig() # Função que define se o kernel será auto configurado baseando-se na confiuração do Kernel em execução
{
	if [ $ENABLEAUTOCONFIG -eq 1 ]	
	then
		if [ "$_AUTOCONFIGTXT" == "$_YES" ]
		then
			_AUTOCONFIGTXT="$_NO"
		else
			_AUTOCONFIGTXT="$_YES"
		fi
	else
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_AUTOCONFIGERROR"
		dialog --title "$TITLEMSG" --msgbox "\n$_AUTOCONFIGERROR" 8 60
	fi
}

################################################################################

_test_cflags()
{
	case $CFLAGSTXT in
		"K6")		CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=k6 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"K6-2")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=k6-2 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Geode LX")	CHOST="i486-pc-linux-gnu"
				CFLAGS="-march=geode -Os -mmmx -m3dnow -fno-align-jumps -fno-align-functions -fno-align-labels -fno-align-loops -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Geode GX1")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=pentium-mmx -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"K6-3")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=k6-3 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Duron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-tbird -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Mobile Duron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-tbird -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Duron Morgan")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-xp -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon Thunderbird")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-tbird -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon (Palomino) XP/Duron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-xp -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon 4")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-4 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon XP/Geode NX")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-4 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon MP")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-mp -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon 64")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=k8 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon 64 (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=k8 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon 64 X2")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=k8 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon 64 X2 (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=k8 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"1xx Opteron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-O2 -march=opteron -msse3 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"1xx Opteron (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=opteron -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"2xx/8xx Opteron")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=opteron -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"22xx Dual-Core Opteron")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=opteron -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"23xx Quad-Core Barcelona")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=barcelona -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"61xx Eight-Core Magny-Cours")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-mtune=amdfam10 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon X2 7x50, Phenom X3/X4, Phenom II (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=amdfam10 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Athlon II X2/X3/X4, Turion II (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=amdfam10 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Sempron / Sempron64 / Sempron Family WirNet")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-xp -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Sempron / Sempron64 / Sempron Family WirNet (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=k8 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Sempron / Sempron64 / Sempron Family WirNet (Socket 754/AM2) (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=k8 -msse3 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Sempron / Sempron64 / Sempron Family WirNet (Socket AM3) (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=amdfam10 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Turion64 / X2 / Ultra / Sempron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-xp -msse3 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Turion64 / X2 / Ultra / Sempron (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=k8 -msse3 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Mobile Sempron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=athlon-xp -msse3 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Mobile Sempron (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=k8 -msse3 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"C-30, C-50, C-60, E-350, E-450 series")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=amdfam10 -O2 -pipe -mno-3dnow -mcx16 -mpopcnt -msse3 -msse4a -mmmx"
				CXXFLAGS="${CFLAGS}"
				;;
		"C-30, C-50, C-60, E-350, E-450 series (64bit Kernel)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=amdfam10 -O2 -pipe -fomit-frame-pointer -mno-3dnow -mcx16 -mpopcnt -msse3 -msse4a -mmmx"
				CXXFLAGS="${CFLAGS}"
				;;
		"A4/A6/A8-XXXX (Llano) (64bit Kernel)")	CFLAGS="-O2 -march=amdfam10 -mcx16 -mpopcnt -pipe"
				CXXFLAGS="${CFLAGS}"
				CHOST="x86_64-pc-linux-gnu"
				USE="mmx mmxext sse sse2 sse3 sse4a"
				;;
		"FX-8xxx/6xxx/4xxx (Bulldozer) (64bit Kernel)")	CFLAGS="-O2 -pipe -fomit-frame-pointer -march=bdver1 -mtune=bdver1 -mcx16 -msahf -maes -mpclmul -mpopcnt -mabm -mlwp -mavx"
				CXXFLAGS="${CFLAGS}"
				CHOST="x86_64-pc-linux-gnu"
				;;
		"Pentium I")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=pentium -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium MMX")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=pentium-mmx -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium Pro")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentiumpro -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium II")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium2 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Celeron (Mendocino), aka Celeron1")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium2 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium III/ Mobile Celeron")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium3 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Celeron (Coppermine)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium3 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Celeron (Willamette)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium4 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium M(Centrino)/Celeron M")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium-m -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Mobile Pentium 4-M (Northwood)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium4 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium 4")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium4 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium 4 (Prescott) / Celeron D")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium 4 (Prescott) / Celeron D (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=nocona -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium D 8xx / 9xx")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Pentium D 8xx / 9xx (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=nocona -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Xeon w/o EM64T")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=pentium4 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Xeon w/EM64T (also Pentium 4 P6xx or Celeron M 5xx)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Xeon w/EM64T (also Pentium 4 P6xx or Celeron M 5xx) (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=nocona -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Core 2 Solo/Duo, Pentium Dual-Core T20xx/T21xx")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Core 2 Duo/Quad, Xeon 51xx/53xx/54xx/3360, Pentium Dual-Core T23xx+/Exxxx, Celeron Dual-Core")		CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=core2 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Core 2 Duo/Quad, Xeon 51xx/53xx/54xx/3360, Pentium Dual-Core T23xx+/Exxxx, Celeron Dual-Core (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=core2 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Core i7 and Core i5, Xeon 55xx")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=prescott -O2 -fomit-frame-pointer -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Core i7 and Core i5, Xeon 55xx (64bit Kernel - GCC 4.3)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=core2 -mtune=generic -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Core i7 and Core i5, Xeon 55xx (64bit Kernel - GCC 4.6)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=corei7 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Atom 230, Atom 330, Atom N-Series")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=native -O2 -fomit-frame-pointer -pipe -mfpmath=sse"
				CXXFLAGS="${CFLAGS}"
				;;
		"Atom 230, Atom 330, Atom N-Series (64bit Kernel)")	CHOST="x86_64-pc-linux-gnu"
				CFLAGS="-march=atom -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Sparc")	CHOST="sparc-unknown-linux-gnu"
				CFLAGS="-O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Sparc 64")	CHOST="sparc-unknown-linux-gnu"
				CFLAGS="-mcpu=ultrasparc -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"HPPA 1.1")	CHOST="hppa1.1-unknown-linux-gnu"
				CFLAGS="-O2 -pipe -mschedule=7100LC -march=1.1 -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"HPPA 2.0")	CHOST="hppa2.0-unknown-linux-gnu"
				CFLAGS="-O2 -pipe -mschedule=8000 -march=2.0 -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Alpha ev56")	CHOST="alpha-unknown-linux-gnu"
				CFLAGS="-mcpu=ev56 -mieee -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Alpha ev67")	CHOST="alpha-unknown-linux-gnu"
				CFLAGS="-mieee -mcpu=ev67 -Wa,-mev6 -O2 -pipe "
				CXXFLAGS="${CFLAGS}"
				;;
		"Cyrix MediaGX")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=pentium-mmx -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"TI OMAP2")	CHOST="arm-gentoo-linux-gnueabi"
				CFLAGS="-march=armv6j -Os -pipe -fomit-frame-pointer -mtune=arm1136jf-s -mfpu=vfp"
				CXXFLAGS="${CFLAGS}"
				;;
		"MIPS (Cobalt RaQ2)")	CHOST="mipsel-unknown-linux-gnu"
				CFLAGS="-Os -mips4 -mabi=32 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PXA270")	CHOST="armv5te-iwmmxt-linux-gnueabi"
				CFLAGS="-O2 -march=iwmmxt -mtune=iwmmxt -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"Kirkwood (Sheevaplug and alike)")	CFLAGS="-O2 -pipe -march=armv5te -mtune=xscale -fweb -frename-registers -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				CHOST="armv5tel-softfloat-linux-gnueabi"
				;;
		"Transmeta Crusoe")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=i686 -Os -mmmx -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Transmeta Efficeon")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-mtune=pentium3 -msse2 -O2 -pipe -falign-functions=0 -falign-jumps=0 -falign-loops=0"
				CXXFLAGS="${CFLAGS}"
				;;
		"Eden")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=c3-2 -mtune=c3-2 -pipe  -mfpmath=sse,387 -msse2 -mmmx -msse"
				;;
		"Esther C5J (Via C7)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=i686 -mmmx -msse -msse2 -msse3 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Esther C5J (Via C7) (Safe Build)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"C3 Nehemiah (C5X/C5XL/C5P)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=c3-2 -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"C3 Nehemiah (C5X/C5XL/C5P) (i686 code)")	CHOST="i686-pc-linux-gnu"
				CFLAGS="-march=c3-2 -mtune=generic -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"C3 Samuel/Ezra (Via EPIA)")	CHOST="i586-pc-linux-gnu"
				CFLAGS="-march=c3 -m3dnow -O2 -pipe -fomit-frame-pointer"
				CXXFLAGS="${CFLAGS}"
				;;
		"Cell Broadband Engine (PlayStation 3)")	CHOST="powerpc64-unknown-linux-gnu"
				CFLAGS="-O2 -pipe -mcpu=cell"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 750cx (G3e) (Nintendo Gamecube / Wii)")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=750 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 601")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=601 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 603")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=603 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 603e")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=603e -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 604")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=604 -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 604e")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=604e -O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 750/745/755 (G3)")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=750 -Os -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 7400/7410 (G4)")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=7400 -O2 -pipe -maltivec -mabi=altivec"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 744x/745x (G4 second generation)")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-mcpu=7450 -O2 -pipe -maltivec -mabi=altivec"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC 970 (G5)")	CHOST="powerpc64-unknown-linux-gnu"
				CFLAGS="-O2 -pipe -mcpu=970"
				CXXFLAGS="${CFLAGS}"
				;;
		"PowerPC (Generic)")	CHOST="powerpc-unknown-linux-gnu"
				CFLAGS="-O2 -pipe"
				CXXFLAGS="${CFLAGS}"
				;;
		*) _CFLAGSTXT="$_UNABLE"
				;;
	esac
}

################################################################################

_CFLAGS_amd()

{
	CFLAGSTXT=$( dialog --title "$TITLEMSG" \
		      --stdout \
		      --menu "$_SELECTPROC" \
		      0 80 12 \
		"A4/A6/A8-XXXX (Llano) (64bit Kernel)" "" \
		"Athlon X2 7x50, Phenom X3/X4, Phenom II (64bit Kernel)" "" \
		"Athlon II X2/X3/X4, Turion II (64bit Kernel)" "" \
		"Athlon 64" "" \
		"Athlon 64 (64bit Kernel)" "" \
		"Athlon 64 X2" "" \
		"Athlon 64 X2 (64bit Kernel)" "" \
		"Athlon" "" \
		"Athlon Thunderbird" "" \
		"Athlon (Palomino) XP/Duron" "" \
		"Athlon 4" "" \
		"Athlon XP/Geode NX" "" \
		"Athlon MP" "" \
		"C-30, C-50, C-60, E-350, E-450 series" "" \
		"C-30, C-50, C-60, E-350, E-450 series (64bit Kernel)" "" \
		"Duron" "" \
		"Duron Morgan" "" \
		"FX-8xxx/6xxx/4xxx (Bulldozer) (64bit Kernel)" "" \
		"Geode LX" "" \
		"Geode GX1" "" \
		"K6" "" \
		"K6-2" "" \
		"K6-3" "" \
		"Mobile Duron" "" \
		"Mobile Sempron" "" \
		"Mobile Sempron (64bit Kernel)" "" \
		"Sempron / Sempron64 / Sempron Family WirNet" "" \
		"Sempron / Sempron64 / Sempron Family WirNet (64bit Kernel)" "" \
		"Sempron / Sempron64 / Sempron Family WirNet (754/AM2) (64bit Kernel)" "" \
		"Sempron / Sempron64 / Sempron Family WirNet (AM3) (64bit Kernel)" "" \
		"Turion64 / X2 / Ultra / Sempron" "" \
		"Turion64 / X2 / Ultra / Sempron (64bit Kernel)" "" \
		"1xx Opteron" "" \
		"1xx Opteron (64bit Kernel)" "" \
		"2xx/8xx Opteron" "" \
		"22xx Dual-Core Opteron" "" \
		"23xx Quad-Core Barcelona" "" \
		"61xx Eight-Core Magny-Cours" "" \
		"$_CANCEL" "" )

	_CFLAGSTXT="$CFLAGSTXT"

	_test_cflags

}

################################################################################

_CFLAGS_intel()

{
	CFLAGSTXT=$( dialog --title "$TITLEMSG" \
		      --stdout \
		      --menu "$_SELECTPROC" \
		      0 80 12 \
		"Atom 230, Atom 330, Atom N-Series" "" \
		"Atom 230, Atom 330, Atom N-Series (64bit Kernel)" "" \
		"Celeron (Mendocino), aka Celeron1" "" \
		"Celeron (Coppermine)" "" \
		"Celeron (Willamette)" "" \
		"Core 2 Duo/Quad, Xeon 51xx/53xx/54xx/3360, Pentium Dual-Core T23xx+/Exxxx, Celeron Dual-Core" "" \
		"Core 2 Duo/Quad, Xeon 51xx/53xx/54xx/3360, Pentium Dual-Core T23xx+/Exxxx, Celeron Dual-Core (64bit Kernel)" "" \
		"Core 2 Solo/Duo, Pentium Dual-Core T20xx/T21xx" "" \
		"Core i7 and Core i5, Xeon 55xx" "" \
		"Core i7 and Core i5, Xeon 55xx (64bit Kernel - GCC 4.3)" "" \
		"Core i7 and Core i5, Xeon 55xx (64bit Kernel - GCC 4.6)" "" \
		"Pentium I" "" \
		"Pentium II" "" \
		"Pentium III/ Mobile Celeron" "" \
		"Pentium MMX" "" \
		"Pentium Pro" "" \
		"Pentium M(Centrino)/Celeron M" "" \
		"Pentium 4" "" \
		"Pentium 4 (Prescott) / Celeron D" "" \
		"Pentium 4 (Prescott) / Celeron D (64bit Kernel)" "" \
		"Pentium D 8xx / 9xx" "" \
		"Pentium D 8xx / 9xx (64bit Kernel)" "" \
		"Mobile Pentium 4-M (Northwood)" "" \
		"Xeon w/o EM64T" "" \
		"Xeon w/EM64T (also Pentium 4 P6xx or Celeron M 5xx)" "" \
		"Xeon w/EM64T (also Pentium 4 P6xx or Celeron M 5xx) (64bit Kernel)" "" \
		"$_CANCEL" "" )

	_CFLAGSTXT="$CFLAGSTXT"

_test_cflags

}

################################################################################

_CFLAGS_powerpc()

{
	CFLAGSTXT=$( dialog --title "$TITLEMSG" \
		      --stdout \
		      --menu "$_SELECTPROC" \
		      0 80 12 \
		"Cell Broadband Engine (PPC64 / PlayStation 3)" "" \
		"PowerPC 750cx (G3e) (Nintendo Gamecube / Wii)" "" \
		"PowerPC 601" "" \
		"PowerPC 603" "" \
		"PowerPC 603e" "" \
		"PowerPC 604" "" \
		"PowerPC 604e" "" \
		"PowerPC 750/745/755 (G3)" "" \
		"PowerPC 7400/7410 (G4)" "" \
		"PowerPC 744x/745x (G4 second generation)" "" \
		"PowerPC 970 (G5)" "" \
		"PowerPC (Generic)" "" \
		"$_CANCEL" "" )

	_CFLAGSTXT="$CFLAGSTXT"

_test_cflags

}

################################################################################

_CFLAGS_via()

{
	CFLAGSTXT=$( dialog --title "$TITLEMSG" \
		      --stdout \
		      --menu "$_SELECTPROC" \
		      0 80 12 \
		"C3 Nehemiah (C5X/C5XL/C5P)" "" \
		"C3 Nehemiah (C5X/C5XL/C5P) (i686 code)" "" \
		"C3 Samuel/Ezra (Via EPIA)" "" \
		"Eden" "" \
		"Esther C5J (Via C7)" "" \
		"Esther C5J (Via C7) (Safe Build)" "" \
		"$_CANCEL" "" )

	_CFLAGSTXT="$CFLAGSTXT"

_test_cflags

}

################################################################################

_CFLAGS_transmeta()

{
	CFLAGSTXT=$( dialog --title "$TITLEMSG" \
		      --stdout \
		      --menu "$_SELECTPROC" \
		      0 80 12 \
		"Transmeta Crusoe" "" \
		"Transmeta Efficeon" "" \
		"$_CANCEL" "" )

	_CFLAGSTXT="$CFLAGSTXT"

_test_cflags

}

################################################################################

_CFLAGS_others()

{
	CFLAGSTXT=$( dialog --title "$TITLEMSG" \
		      --stdout \
		      --menu "$_SELECTPROC" \
		      0 80 12 \
		"Sparc" "" \
		"Sparc 64" "" \
		"HPPA 1.1" "" \
		"HPPA 2.0" "" \
		"Alpha ev56" "" \
		"Alpha ev67" "" \
		"Cyrix MediaGX" "" \
		"TI OMAP2" "" \
		"MIPS (Cobalt RaQ2)" "" \
		"PXA270" "" \
		"Kirkwood (Sheevaplug and alike)" "" \
		"$_CANCEL" "" )

	_CFLAGSTXT="$CFLAGSTXT"

_test_cflags

}

################################################################################

_auto_CFLAGS() # Detecta automaticamente a melhor configuração para a máquina
{

	if [ $_MENUCFLAGS -eq 1 ]
	then
		dialog --title "$TITLEMSG" --infobox "\n$_WAIT" 4 80
	else
		echo -e "\033[1;36m\n$_WAIT\n\033[0m"
	fi
	NATIVE=(`cc -march=native -E -v - </dev/null 2>&1 | grep " -march="`)

	COUNTER=0
	FOUND=0

	while [ $FOUND -eq 0 ]
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

	while [ $FOUND -eq 0 ]
	do
		if [ `echo "${NATIVE[$COUNTER]}" | grep fstack-protector | wc -l` == "0" ]
		then
			if [ $COUNTER -eq $DEBIANCOUNTER ] # Patch para usuários debian e algumas arquiteturas mais antigas
			then
				FOUND=1
			else
				CFLAGS="$CFLAGS ${NATIVE[$COUNTER]}"
				COUNTER=$(($COUNTER+1))
			fi # Fim do patch
		else
			FOUND=1
		fi
	done
	_CFLAGSTXT="$_AUTODETECT1"
	echo "[`date +%H:%M:%S`] CFLAGS ($CPUINFO): $CFLAGS" >> "$LOGKFN"
}

################################################################################

_apply_patch() # Função que habilita (ou desabilita) o uso de patches no Kernel
{
	if [ "$_PATCHTXT" == "$_YES" ]
	then
		_PATCHTXT="$_NO"
	else
		_PATCHTXT="$_YES"
	fi
}

################################################################################

_CFLAGS() # Função que define as CFLAGS a serem utilizadas. Utilizar CFLAGS incorretamente pode comprometer a compilação
{
	_CFLAGS1=$( dialog --title "$TITLEMSG"                                        \
		      --stdout                                                        \
		      --menu "$_SELECTPROC"                                           \
		      0 80 10                                                         \
		      "$_AUTODETECT" ""                                               \
		      "AMD" "Athlon, Duron, Sempron, Phenom, Opteron, Turion, FX..."  \
		      "Intel" "Pentium, Celeron, Atom, i3, i5, i7, Xeon..."           \
		      "PowerPC" "Cell PS3, G3, G4, G5, Wii, GC..."       \
		      "VIA" "Eden, Esther, C3, C7, Samuel, Ezra..."                   \
		      "Transmeta" "Crusoe, Efficeon"                                  \
		      "$_OTHERS" "Sparc, HPPA, Alpha, Cyrix, TI, MIPS, ARM..."        \
		      "$_UNABLE" ""                                                   \
		      "$_CANCEL" "" )

	case $_CFLAGS1 in
		"AMD") _CFLAGS_amd
			;;
		"Intel") _CFLAGS_intel
			;;
		"VIA") _CFLAGS_via
			;;
		"PowerPC") _CFLAGS_powerpc
			;;
		"Transmeta") _CFLAGS_transmeta
			;;
		"$_AUTODETECT") _auto_CFLAGS
			;;
		"$_OTHERS") _CFLAGS_others
			;;
		"$_UNABLE")_CFLAGSTXT="$_UNABLE"
			;;
		"$_CANCEL")_CFLAGSTXT="$_UNABLE"
			;;
	esac
}

################################################################################

_startprocess() # Função padrão. Nela é realizada a maioria das tarefas do KFN :)
{	
	echo "################################################################################" >> "$LOGKFN"
	echo -e "\033[1;36m\n[`date +%H:%M:%S`] $_STARTINGPROCESS\033[0m"
	echo "[`date +%H:%M:%S`] $_STARTINGPROCESS" >> "$LOGKFN"

	echo "[`date +%H:%M:%S`] $_SELECTKERNEL: $KERNELVERSION" >> "$LOGKFN"

	if [ "`uname -r`" == "$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT" ]
	then
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_VERSIONRUN"
		dialog --title "$TITLEMSG" --msgbox "\n$_VERSIONRUN" 12 60
		echo "[`date +%H:%M:%S`] $_VERSIONRUN1" >> "$LOGKFN"
		_exit
	fi
	TESTDEINSTALL=`dpkg --get-selections | grep linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT`
	if [ `dpkg --get-selections | grep linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT | wc -l` -eq 1 ]
	then
		if [ `echo $TESTDEINSTALL | grep deinstall | wc -l` -ne 1 ]
		then
			dialog  --title "$TITLEMSG" --yesno "\n$_EXISTKERNEL" 8 60
			if [ $? != 0 ]
			then
				echo -e "\033[1;31m\n[`date +%H:%M:%S`] $_CANCELREMOVEKERNEL\033[0m"
				echo "[`date +%H:%M:%S`] $_CANCELREMOVEKERNEL" >> "$LOGKFN"
				notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_CANCELREMOVEKERNEL"
				_exit
			else
				echo -e "\033[1;36m\n[`date +%H:%M:%S`] $_REMOVEKERNEL $KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT\033[0m"
				echo "[`date +%H:%M:%S`] $_REMOVEKERNEL $KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT" >> "$LOGKFN"
				apt-get remove linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT linux-headers-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT -y
				apt-get autoremove -y
			fi
		fi
	fi

	echo -e '#include <stdio.h>\nmain()\n{\nprintf("Hello KFN!");\n}' > $HOME/.kfn_tmp/test.c

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_TESTCOMPILATION\033[0m"
	echo "[`date +%H:%M:%S`] $_TESTCOMPILATION" >> "$LOGKFN"

	gcc $HOME/.kfn_tmp/test.c -o $HOME/.kfn_tmp/test

	TESTGCC="`$HOME/.kfn_tmp/test`"

	if [ "$TESTGCC" != "Hello KFN!" ]
	then
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_ERRORTESTCOMPILE"
		echo "[`date +%H:%M:%S`] $_ERRORTESTCOMPILE" >> "$LOGKFN"
		dialog  --title "$TITLEMSG" --yesno "\n$_ERRORTESTCOMPILE" 10 60
		if [ $? != 0 ]
		then
			_exit
		else
			echo -e "\033[1;31m\n[`date +%H:%M:%S`] $_TESTCOMPILATIONERROR $TESTGCC\033[0m"
			echo "[`date +%H:%M:%S`] $_TESTCOMPILATIONERROR $TESTGCC" >> "$LOGKFN"
		fi
	else
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_PASSTESTCOMPILE\033[0m"
		echo "[`date +%H:%M:%S`] $_PASSTESTCOMPILE" >> "$LOGKFN"
	fi

	cd /usr/src

	if [ -d linux-$KERNELVERSION ]
	then
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_DELETINGDIR /usr/src/linux-$KERNELVERSION\033[0m"
		echo "[`date +%H:%M:%S`] $_DELETINGDIR /usr/src/linux-$KERNELVERSION" >> "$LOGKFN"
		rm -r linux-$KERNELVERSION
	fi

	TESTDEB=`ls | grep ".deb" | wc -l`

	if [ $TESTDEB -ne 0 ]
	then
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_DELETEDEB\033[0m"
		echo "[`date +%H:%M:%S`] $_DELETEDEB" >> "$LOGKFN"
		rm *.deb
	fi

	if [ ! -f $HOME/.kfn_tmp/exit ]
	then
		touch $HOME/.kfn_tmp/exit
	fi

	if [ -f $HOME/.kfn_tmp/time ]
	then
		rm $HOME/.kfn_tmp/time
		touch $HOME/.kfn_tmp/time
	else
		touch $HOME/.kfn_tmp/time
	fi

	if [ ! -f $HOME/.kfn_tmp/timer ]
	then
		touch $HOME/.kfn_tmp/timer
	else
		rm $HOME/.kfn_tmp/timer
		touch $HOME/.kfn_tmp/timer
	fi

	if [ "$RAMDISK" -eq 1 ]
	then
		mount -t tmpfs -o size=$RAMDISKSIZE tmpfs $HOME/.kfn_tmp/ramdisk
		_ramdisk
		mkdir /usr/src/linux-$KERNELVERSION
		mount -o bind $HOME/.kfn_tmp/ramdisk /usr/src/linux-$KERNELVERSION
	fi

	case "$_DOWNLOADTXT" in
		"$_DOWNLOADFROMKERNELORG") _gensubversion
			_download
			;;
		"$_DOWNLOADFROMURL") _gensubversion
			_download
			;;
		"$_USELOCALFILE") _gensubversion
			if [ "$URL1" != "/usr/src/linux-$KERNELVERSION.tar.xz" ]
			then
				cp "$URL1" /usr/src/linux-$KERNELVERSION.tar.xz
				echo -e "\033[1;36m[`date +%H:%M:%S`] $_COPYINGSOURCE /usr/src\033[0m"
			fi
			;;
	esac
	cd /usr/src/
	if [ "$_PATCHTXT" == "$_YES" ]
	then
		# Baixando patches

		echo -e "\033[1;36m[`date +%H:%M:%S`] $_DOWNLOADPATCH\033[0m"
		echo "[`date +%H:%M:%S`] $_DOWNLOADPATCH" >> "$LOGKFN"

		axel -a http://kernel.ubuntu.com/~kernel-ppa/mainline/v$KERNEL1.$KERNEL2.$KERNEL3-quantal/0001-base-packaging.patch -o /usr/src/0001-base-packaging.patch
		axel -a http://kernel.ubuntu.com/~kernel-ppa/mainline/v$KERNEL1.$KERNEL2.$KERNEL3-quantal/0002-debian-changelog.patch -o /usr/src/0002-debian-changelog.patch
		axel -a http://kernel.ubuntu.com/~kernel-ppa/mainline/v$KERNEL1.$KERNEL2.$KERNEL3-quantal/0003-default-configs.patch -o /usr/src/0003-default-configs.patch

		CHECKSUM1=(`md5sum /usr/src/0001-base-packaging.patch`)
		CHECKSUM2=(`md5sum /usr/src/0002-debian-changelog.patch`)
		CHECKSUM3=(`md5sum /usr/src/0003-default-configs.patch`)
	fi

	CHECKSUM=(`md5sum /usr/src/linux-$KERNELVERSION.tar.xz`)

	echo -e "\033[1;36m[`date +%H:%M:%S`] MD5SUM linux-$KERNELVERSION.tar.xz: \033[0m${CHECKSUM[0]}"
	echo "[`date +%H:%M:%S`] MD5SUM linux-$KERNELVERSION.tar.xz: ${CHECKSUM[0]}" >> "$LOGKFN"

	if [ "$_PATCHTXT" == "$_YES" ]
	then
		echo -e "\033[1;36m[`date +%H:%M:%S`] MD5SUM 0001-base-packaging.patch: \033[0m${CHECKSUM1[0]}"
		echo "[`date +%H:%M:%S`] MD5SUM 0001-base-packaging.patch: ${CHECKSUM[0]}" >> "$LOGKFN"

		echo -e "\033[1;36m[`date +%H:%M:%S`] MD5SUM 0002-debian-changelog.patch: \033[0m${CHECKSUM2[0]}"
		echo "[`date +%H:%M:%S`] MD5SUM 0002-debian-changelog.patch: ${CHECKSUM[0]}" >> "$LOGKFN"

		echo -e "\033[1;36m[`date +%H:%M:%S`] MD5SUM 0003-default-configs.patch: \033[0m${CHECKSUM3[0]}"
		echo "[`date +%H:%M:%S`] MD5SUM 0003-default-configs.patch: ${CHECKSUM[0]}" >> "$LOGKFN"
	fi

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_EXTRACTINGSOURCE /usr/src/linux-$KERNELVERSION\033[0m"
	echo "[`date +%H:%M:%S`] $_EXTRACTINGSOURCE /usr/src/linux-$KERNELVERSION" >> "$LOGKFN"

	tar -xJf linux-$KERNELVERSION.tar.xz

	cd linux-$KERNELVERSION

	if [ "$_AUTOCONFIGTXT" == "$_YES" ]
	then
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_CPCONFIG"
		echo "[`date +%H:%M:%S`] $_CPCONFIG" >> "$LOGKFN"
		cp /boot/config-`uname -r` /usr/src/linux-$KERNELVERSION/.config
	else
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_COMPILING $_INTERFACE\033[0m"
		echo "[`date +%H:%M:%S`] $_COMPILING $_INTERFACE" >> "$LOGKFN"
		make $_INTERFACE
	fi

	# Verifica se o arquivo .config, necessária para a configuração do Kernel, existe:

	if [ ! -f /usr/src/linux-$KERNELVERSION/.config ]
	then
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_ERRORCONFIG"
		echo "[`date +%H:%M:%S`] $_ERRORCONFIG" >> "$LOGKFN"
		dialog --title "$TITLEMSG" --msgbox "\n$_ERRORCONFIG" 9 60
		_exit
	fi

	TIMER1=`date +%s`

	cd /usr/src/linux-$KERNELVERSION

	if [ "$_PATCHTXT" == "$_YES" ]
	then
		mv /usr/src/0001-base-packaging.patch /usr/src/linux-$KERNELVERSION
		mv /usr/src/0002-debian-changelog.patch /usr/src/linux-$KERNELVERSION
		mv /usr/src/0003-default-configs.patch /usr/src/linux-$KERNELVERSION

		# Aplicando patches

		echo -e "\033[1;36m[`date +%H:%M:%S`] $_APPLYPATCH1\033[0m"
		echo "[`date +%H:%M:%S`] $_APPLYPATCH1" >> "$LOGKFN"

		patch -s -p1 < 0001-base-packaging.patch
		patch -s -p1 < 0002-debian-changelog.patch
		patch -s -p1 < 0003-default-configs.patch

		# Aplicando CFLAGS

		echo -e "\033[1;36m[`date +%H:%M:%S`] $_APPLYCFLAGS\033[0m"
		echo "[`date +%H:%M:%S`] $_APPLYCFLAGS (CFLAGS): $CFLAGS" >> "$LOGKFN"
		sed -e "s/HOSTCFLAGS   = -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer/HOSTCFLAGS = $CFLAGS/g"  Makefile > Makefile1
		rm Makefile
		mv Makefile1 Makefile
		sed -e "s/-march=\([A-Z0-9a-z]\+\)/$CFLAGS/g"  arch/x86/boot/compressed/Makefile > arch/x86/boot/compressed/Makefile1
		rm arch/x86/boot/compressed/Makefile
		mv arch/x86/boot/compressed/Makefile1 arch/x86/boot/compressed/Makefile
		sed -e "s/-march=\([A-Z0-9a-z]\+\)/$CFLAGS/g"  arch/x86/boot/Makefile > arch/x86/boot/Makefile1
		rm arch/x86/boot/Makefile
		mv arch/x86/boot/Makefile1 arch/x86/boot/Makefile

		if [ -f arch/x86/kernel/acpi/realmode/Makefile ]
		then
			sed -e "s/-march=\([A-Z0-9a-z]\+\)/$CFLAGS/g"  arch/x86/kernel/acpi/realmode/Makefile > arch/x86/kernel/acpi/realmode/Makefile1
			rm arch/x86/kernel/acpi/realmode/Makefile
			mv arch/x86/kernel/acpi/realmode/Makefile1 arch/x86/kernel/acpi/realmode/Makefile
		fi

		sed -e "s/-march=\([A-Z0-9a-z]\+\)/$CFLAGS/g"  arch/x86/Kconfig.cpu > arch/x86/Kconfig.cpu1
		rm arch/x86/Kconfig.cpu
		mv arch/x86/Kconfig.cpu1 arch/x86/Kconfig.cpu
		sed -e "s/-march=\([A-Z0-9a-z]\+\)/$CFLAGS/g"  arch/x86/Makefile > arch/x86/Makefile1
		rm arch/x86/Makefile
		mv arch/x86/Makefile1 arch/x86/Makefile
		sed -e "s/-march=\([A-Z0-9a-z]\+\)/$CFLAGS/g"  arch/x86/Makefile_32.cpu > arch/x86/Makefile_32.cpu1
		rm arch/x86/Makefile_32.cpu
		mv arch/x86/Makefile_32.cpu1 arch/x86/Makefile_32.cpu
	fi

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_COMPILINGKERNEL $KERNELVERSION\033[0m"
	echo "[`date +%H:%M:%S`] $_COMPILINGKERNEL $KERNELVERSION" >> "$LOGKFN"
	notify-send -i gtk-dialog-info -u normal "$TITLEMSG" "$_COMPILINGKERNEL $KERNELVERSION"

	# Compilando o Kernel:

	NUMBERCORE=$(($NUMBERCORE+1))

  	make-kpkg --initrd --append-to-version=-$_CODENAMETXT kernel_image kernel_headers -j $NUMBERCORE

	# Instalação do Kernel:

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_INSTALLKERNEL $KERNELVERSION\033[0m"
	echo "[`date +%H:%M:%S`] $_INSTALLKERNEL $KERNELVERSION" >> "$LOGKFN"
	dpkg -i /usr/src/*.deb

	# Instalando Initramfs:

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_UPDATEINITRAMFS\033[0m"
	echo "[`date +%H:%M:%S`] $_UPDATEINITRAMFS" >> "$LOGKFN"

	# Como o initramfs necessita do valor EXATO da versão do kernel, devemos
	# informá-lo com a Versão, Subversão e Revisão, ex: 3.2.3 , por isso que
	# a variável $KERNELVERSION não é utilizada aqui:

	if [ "$_PLATFORMTXT" == "$_PLATFORMPS3" ]
	then
		mkinitramfs -o initrd.img $KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT # Modo PlayStation 3
	else
		update-initramfs -k $KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT -u    # Modo Computador
	fi

	# Atualizando o bootloader:

	# Nota: no PlayStation 3 o bootloader lê o arquivo /etc/kboot.conf
	# para iniciar o sistema.

	case $_PLATFORMTXT in
	"$_PLATFORMPS3")
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_INSTALLINGKERNEL\033[0m"
		cp initrd.img /boot/initrd.img-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT
		cp vmlinux /boot/vmlinux-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT
		cp .config /boot/config-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT
		cp System.map /boot/System.map-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT
		echo 'echo $1 > $HOME/.kfn_tmp/hd_root' > $HOME/.kfn_tmp/hd_root.sh
		chmod 777 $HOME/.kfn_tmp/hd_root.sh
		$HOME/.kfn_tmp/hd_root.sh `mount`
		HDROOT=`cat $HOME/.kfn_tmp/hd_root`
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_UPDATINGKBOOT\033[0m\n"
		echo -e "message=/etc/kboot.msg\ndefault=linux\ntimeout=100\nlinux='/boot/vmlinux-$KERNEL1.$KERNEL2.$KERNEL3-$CODENAME initrd=/boot/initrd.img-$KERNEL1.$KERNEL2.$KERNEL3-$CODENAME root=$HDROOT quiet video=ps3fb:mode:5'\nold='/boot/vmlinux initrd=/boot/initrd.img root=$HDROOT quiet video=ps3fb:mode:5'" > /etc/kboot.conf
		cat /etc/kboot.conf
			;;
	"$_PLATFORMGENERIC")
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_UPDATINGGRUB\033[0m"
		echo "[`date +%H:%M:%S`] $_UPDATINGGRUB" >> "$LOGKFN"
		update-grub
			;;
	esac

	if [ "$RAMDISK" -eq 1 ]
	then
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_UMOUNTINGRAMDISK\033[0m"
		echo "[`date +%H:%M:%S`] $_UMOUNTINGRAMDISK" >> "$LOGKFN"
		umount /usr/src/linux-$KERNELVERSION
		mkdir /usr/src/linux-$KERNELVERSION
		echo -e "\033[1;36m[`date +%H:%M:%S`] $_COPYINGFILESTOUSRSRC /usr/src/linux-$KERNELVERSION\033[0m"
		echo "[`date +%H:%M:%S`] $_COPYINGFILESTOUSRSRC /usr/src/linux-$KERNELVERSION" >> "$LOGKFN"
		cp $HOME/.kfn_tmp/ramdisk/linux-$KERNELVERSION/* /usr/src/linux-$KERNELVERSION
	fi
	echo

	cd /usr/src

	# Compactando arquivos finais do Kernel para posterior uso:

	if [ -f linux-kernel-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT.tar.xz ]
	then
		rm linux-kernel-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT.tar.xz
	fi

	echo -e "\033[1;36m[`date +%H:%M:%S`] $_COMPRESS\n\033[0m"
	echo "[`date +%H:%M:%S`] $_COMPRESS" >> "$LOGKFN"
	tar -cf linux-kernel-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT.tar *.deb
	bzip2 linux-kernel-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT.tar

	# Testando se o Kernel e os "headers" foram instalados corretamente:

	if [ `dpkg --get-selections | grep linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT | wc -l` -eq 0 ]
	then
		echo -e "\033[1;31m[`date +%H:%M:%S`] $_ERROR linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT\033[0m $_KERNELNOTINSTALLED\033[0m"
		echo "[`date +%H:%M:%S`] $_ERROR linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT $_KERNELNOTINSTALLED" >> "$LOGKFN"
		TESTKERNEL=1
	else
		echo -e "\033[1;36m[`date +%H:%M:%S`] linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT\033[0m $_SUCESSFULLKERNELINSTALLED\033[0m"
		echo "[`date +%H:%M:%S`]linux-image-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT $_SUCESSFULLKERNELINSTALLED" >> "$LOGKFN"
	fi

	if [ `dpkg --get-selections | grep linux-headers-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT | wc -l` -eq 0 ]
	then
		echo -e "\033[1;31m[`date +%H:%M:%S`] $_ERROR linux-headers-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT\033[0m $_HEADERSNOTINSTALLED\033[0m"
		echo "[`date +%H:%M:%S`] $_ERROR linux-headers-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT $_HEADERSNOTINSTALLED" >> "$LOGKFN"
		TESTKERNEL=1
	else
		echo -e "\033[1;36m[`date +%H:%M:%S`] linux-headers-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT\033[0m $_SUCESSFULLHEADERSINSTALLED\033[0m"
		echo "[`date +%H:%M:%S`] linux-headers-$KERNEL1.$KERNEL2.$KERNEL3-$_CODENAMETXT $_SUCESSFULLHEADERSINSTALLED" >> "$LOGKFN"
	fi

	if [ "$TESTKERNEL" == "1" ]
	then
		notify-send -i gtk-dialog-warning -u normal "$TITLEMSG" "$_ERRORKERNELHEADERS $KFNFORUM"
		echo -e "\n\033[1;31m[`date +%H:%M:%S`] $_ERRORKERNELHEADERS\033[0m\033[1;36m$KFNFORUM\033[0m\n"
		echo "[`date +%H:%M:%S`] $_ERRORKERNELHEADERS $KFNFORUM" >> "$LOGKFN"
	fi

	# Finalização:

	HOUR=0
	MIN=0
	SEC=0

	TIMER2=`date +%s`

	SEC=$(($TIMER2-$TIMER1))

	while [ $SEC -ge 60 ]
	do
		MIN=$(($MIN+1))
		SEC=$(($SEC-60))
	done
	
	while [ $MIN -ge 60 ]
	do
		HOUR=$(($HOUR+1))
		MIN=$(($MIN-60))
	done
	
	case "$SEC" in
		0) SEC=00
		  		;;
		1) SEC=01
		  		;;
		2) SEC=02
		  		;;
		3) SEC=03
		  		;;
		4) SEC=04
		  		;;
		5) SEC=05
		  		;;
		6) SEC=06
		  		;;
		7) SEC=07
		  		;;
		8) SEC=08
		  		;;
		9) SEC=09
		  		;;
	esac
	
	case "$MIN" in
		0) MIN=00
		  		;;
		1) MIN=01
		  		;;
		2) MIN=02
		  		;;
		3) MIN=03
		  		;;
		4) MIN=04
		  		;;
		5) MIN=05
		  		;;
		6) MIN=06
		  		;;
		7) MIN=07
		  		;;
		8) MIN=08
		  		;;
		9) MIN=09
		  		;;
	esac

	case "$HOUR" in
		0) HOUR=00
		  		;;
		1) HOUR=01
		  		;;
		2) HOUR=02
		  		;;
		3) HOUR=03
		  		;;
		4) HOUR=04
		  		;;
		5) HOUR=05
		  		;;
		6) HOUR=06
		  		;;
		7) HOUR=07
		  		;;
		8) HOUR=08
		  		;;
		9) HOUR=09
		  		;;
	esac

	TOTALENDTIME="$HOUR:$MIN:$SEC"

	echo
	echo -e "\033[1;36m$_TOTALEXECUTIONTIME $TOTALENDTIME\nFinalizado em `date +%d/%m/%Y` às `date +%H:%M:%S`\033[0m"
	echo "[`date +%H:%M:%S`] $_TOTALEXECUTIONTIME $TOTALENDTIME Finalizado em `date +%d/%m/%Y` às `date +%H:%M:%S`" >> "$LOGKFN"
	echo -e "\033[1;36m$_COMPILATIONCOMPLETEFINISH $KERNELVERSION-$_CODENAMETXT (`file /bin/bash | cut -d' ' -f3`)\033[0m"
	echo "[`date +%H:%M:%S`] $_COMPILATIONCOMPLETEFINISH $KERNELVERSION-$_CODENAMETXT (`file /bin/bash | cut -d' ' -f3`)" >> "$LOGKFN"

	notify-send -i gtk-dialog-info -u normal "$TITLEMSG" "$_COMPILATIONCOMPLETEFINISH $KERNELVERSION-$_CODENAMETXT (`file /bin/bash | cut -d' ' -f3`): $KERNELVERSION"

	# Reinicia, desliga o sistema ou executa um comando após terminar o processo:

	if [ "$_WHENCOMPLETETXT" != "$_NOTHINGTODO" ]
	then
		echo "[`date +%H:%M:%S`] $CMD" >> "$LOGKFN"
		$CMD
		_exit
	else
		_exit
	fi
}

################################################################################

_menu()
{
	echo $KERNELVERSION > $HOME/.kfn_tmp/kernelversion
	if [ "$URL" == "0" ]
	then
		_gensubversion
		URL="kernel.org/pub/linux/kernel/v$KERNEL1.$GENSUBVERSION/linux-$KERNELVERSION.tar.xz" # Patch para correção (em alguns casos) ao gerar o link do download do kernel.
	fi

	_numbercore

	if [ $_SETCFLAGS -eq 1 ]
	then
		_auto_CFLAGS
		_SETCFLAGS=0
	fi
	_MENUCFLAGS=1
}

################################################################################

_advanced()
{
	BENCH1=0
	BENCH2=0
	COUNTBENCH=0
	while [ $COUNTBENCH != 5 ]
	do
		BENCH=`date +%s`
		BENCH=$(($BENCH+5))
		while [ "`date +%s`" != $BENCH ]
		do
			BENCH1=$(($BENCH1+1))
		done
		BENCH2=$(($BENCH2+$BENCH1))
		echo "Proc: $BENCH1"
		COUNTBENCH=$(($COUNTBENCH+1))
	done
	BENCH2=$(($BENCH2/5))
	echo $BENCH2
	exit
}

################################################################################

_language()
{
	_LANGUAGE1=$( dialog --title "$TITLEMSG" \
	      --stdout                           \
	      --menu "$_LANGUAGETITLE"           \
	      0 50 5                            \
	      "pt-br" "Português-BR"             \
	      "english" "English")

	echo "$_LANGUAGE1" > $HOME/.kfn/language
	echo -e "\n\n\033[1;36m[`date +%H:%M:%S`] $_LANGUAGEEXIT\033[0m"
	echo -e "[`date +%H:%M:%S`] $_LANGUAGEEXIT"  >> "$LOGKFN"
	_exit
}

################################################################################

while true # Menu principal
do
	_menu
	MAINACTION=$( dialog --title "$TITLEMSG"                               \
		      --stdout                                                 \
		      --menu "$_GENERALOPTIONS"                                \
		      0 90 14                                                  \
		      "$_KERNELVERSIONTXT" "$KERNELVERSION$KERNELVERSIONCHECK" \
		      "$_SOURCEPACKAGE" "$_DOWNLOADTXT"                        \
		      "$_URL" "$URL"                                           \
		      "$_CORES" "$NUMBERCORE $_CORES1"                         \
		      "$_WHENCOMPLETE" "$_WHENCOMPLETETXT"                     \
		      "$_PLATFORM" "$_PLATFORMTXT"                             \
		      "$_CONFIGMODE" "$_SETUPTXT"                              \
		      "$_OPTIMIZATION" "$_CFLAGSTXT"                           \
		      "$_AUTOCONFIG" "$_AUTOCONFIGTXT"                         \
		      "$_APPLYPATCH" "$_PATCHTXT"                              \
		      "$_COMPILERAMDISK" "$RAMDISKTXT"                         \
		      "$_RUNUPDATE" "$_UPDATEEXECTXT"                          \
		      "$_LANGUAGE" "$_LANGUAGETXT"                             \
		      "$_STARTPROCESS" "" )

	case $MAINACTION in # Executa a função selecionada no menu
		"$_COMPILERAMDISK")   _check_bit
			;;
		"$_SOURCEPACKAGE")    _kernelsource
			;;
		"$_KERNELVERSIONTXT") _kernelversion
			;;
		"$_PLATFORM")         _platform
			;;
		"$_WHENCOMPLETE")     _whencomplete
			;;
		"$_STARTPROCESS")     _startprocess
			;;
		"$_CONFIGMODE")       _setup
			;;
		"$_OPTIMIZATION")     _CFLAGS
			;;
		"$_CORES")            _selectcore
			;;
		"$_APPLYPATCH")       _apply_patch
			;;
		"$_URL")              echo ""
			;;
		"$_RUNUPDATE")        _getkernelversion
			;;
#		"$_ADVANCED")         _advanced
#			;;
		"$_AUTOCONFIG")       _autoconfig
			;;
		"$_LANGUAGE")         _language
			;;
		"$_CANCEL")           echo && _exit
			;;
		*) echo && _exit
			;;
	esac
done

