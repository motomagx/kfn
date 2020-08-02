Kernel for Newbies é um simples assistente de customização e compilação do Kernel Linux, escrito em Shell, permitindo a compilação para multi-plataformas, suportando múltiplos compiladores (GCC e LLVM).<br>
<br>
O Novo KFN está sendo reescrito do zero, para compatibilizar as mais recentes tecnologias e suportar as distribuições Debian-like mais recentes, como Ubuntu e Mint, e com desenvolvimento atual para compatibilizar plataformas baseadas em RedHat e OpenSUSE.<br>

O programa suporta 2 idiomas (Português e inglês) que pode ser definido durante a instalação ou promeiro uso.<br>

O KFN suporta compilações para a arquitetura do host nativamente (qualquer arquitetura) e compilação cruzada* para ARM, ARM64, PowerPC e x86_32.<br>

*A compatibilidade para compilação cruzada ainda é parcial, e em breve, novas atualizações irão complementar as arquiteturas faltantes.<br><br>

Instalação:

$ wget https://raw.githubusercontent.com/motomagx/kfn/master/kfn.sh<br>
$ chmod +x kfn.sh<br>
$ ./kfn.sh<br>

Na primeira execução, o KFN irá baixar módulos adicionais para sua execução, que podem ser localizados em <home>/kfn/modules.

Para atualizar os múdulos, execute:<br>
$ ./kfn.sh update<br>

<br>
<br>
Requerimentos:
<br>
-Sistema baseado em Debian (Ubuntu, Mint, etc) ou uma distribuição compatível, de 2018 em diante.<br>
-Processador de 4 núcleos ou mais é recomendado (Intel Core i3/i5/i7/i9/Xeon, AMD Ryzen 3/5/7, ARM Cortex A9+)<br>
-Pelo menos 20GB de espaço livre em HD (tamanho médio de uma complilação normal do Kernel, incluindo temporários)<br>
-2GB de RAM (recomendado: 4GB ou mais)<br>
-Requer conexão com a internet com acesso aos repositórios da sua distruição + acesso livre ao Kernel.org e ao Github<br>
 <br>
<br>
Dependências: 

Para que a compilação ocorra de forma perfeita, recomendamos que os seguintes pacotes sejam instalados, no entanto, o KFN pode instalar para você após a instalação: 

alien autoconf axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g++ gcc gnupg2 gzip initramfs-tools kernel-package libc6 libelf-dev libncurses libncurses5-dev  libudev-dev libpci-dev libiberty-dev libnotify-bin libssl-dev lzop make openssl pkg-config qemu tar wget

=========================================================================


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
-At least 20GB of free HD space (average size of a normal Kernel build, including temporary ones)<br>
-2GB of RAM (recommended: 4GB or more)<br>
-Requires internet connection with access to your distribution repositories + free access to Kernel.org and Github<br>
 

Dependencies:

In order for the build to take place perfectly, we recommend that the following packages be installed, however, KFN can install for you after installation:

alien autoconf axel bash bc bison binutils-multiarch build-essential bzip2 clang curl dialog dkms fakeroot flex g ++ gcc gnupg2 gzip initramfs-tools kernel-package libc6 libelf-dev libncurses libncurses5-dev libudev-dev libpci-dev libiberty-dev -dev lzop make openssl pkg-config qemu tar wget
