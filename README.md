# RISC-V Computer System 

이 저장소는 고려대학교의 [ESCA lab](https://esca.korea.ac.kr)에서의 학부연구생으로서 연구한 내용을 저장하기 위한 저장소입니다.

이 저장소에 pulpissimo를 이용하면서 필요했던 저장소들을 submodule로 추가해두었습니다.

``` shell
$ git clone --recursive https://github.com/hanchaa/RISC-V_Computer_System.git
```
명령어를 통해 submodule까지 모두 다운 받을 수 있습니다.

<br>

# 실행 환경
- Ubuntu 20.04LTS 
- Python 3.8.5
- Vivado 2018.3

<br>

# Zedboard에 Pulpissimo 포팅하기

하드웨어 IP들을 받기 위해 pulpissimo 디렉토리로 이동하여 다음 스크립트를 실행한다.

``` shell
$ cd ../pulpissimo
$ ./update-ips
```

이후 fpga 디렉토리로 이동해 zedboard를 위한 bitstream을 생성하기 위해 아래 명령어를 사용하면 된다.

(이때 vivado: command not found 에러가 발생한다면 vivado 설치 폴더의 settings64.sh 파일을 실행시켰는지 확인한다.)

``` shell
$ cd fpga
$ make zedboard
```

bitstream 생성이 끝나면 fpga 폴더 안에 pulpissimo_zebdboard.bit 파일이 생성된다.

이 파일을 vivado를 실행시킨 후 Hardware Manager > Open Target > Program device 순으로 실행시켜 Zedboard에 flashing을 하면 된다.

![vivado](./images/1.png)

![hardware_manager](./images/2.png)

![target_setting](./images/3.png)

![program_device](./images/4.png)

![bitstream](./images/5.png)

# FPGA를 위한 애플리케이션 컴파일

우선 [Pulp RISC-V GNU Compiler Toolchain](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain#prerequisites)을 설치해주어야 한다.

이 저장소의 submodule로 toolchain을 저장해두었으며 root/pulp-riscv-gnu-toolchain 디렉토리로 이동하면 사용할 수 있다.

아래 명령어를 이용해 Pulp RISC-V GNU Compiler Toolchain을 위한 system dependency를 설치한다. ([참고자료](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain#prerequisites))

``` shell
$ sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
```

system dependency 설치 후, 위의 명령어를 이용해 toolchain을 설치할 수 있다. ([참고자료](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain#installation-pulp))

``` shell
$ cd pulp-riscv-gnu-toolchain
$ ./configure --prefix={INSTALL_PATH} --with-arch=rv32imc --with-cmodel=medlow --enable-multilib
$ sudo make
```

필자는 참고자료에 나온대로 /opt/riscv에 설치하였으며, 이 경우 설치 중 permission denined 문제가 발생하여 sudo 명령어를 이용하였다.

toolchain 설치가 끝난 후 환경변수를 이용해 toolchain의 경로를 지정해준다.

``` shell
$ export PULP_RISCV_GCC_TOOLCHAIN={INSTALL_PATH}
```

다음으로 PULP-SDK를 설치하여야 하는데, [여기](https://github.com/pulp-platform/pulp-sdk/tree/v1#linux-dependencies)에 나온대로 system dependecy를 우선 설치한다.

대신 python2가 지원 종료되었으므로 configparser를 pip3로 install 하였다.

``` shell
$ sudo apt install git python3-pip python-pip gawk texinfo libgmp-dev libmpfr-dev libmpc-dev swig3.0 libjpeg-dev lsb-core doxygen python-sphinx sox graphicsmagick-libmagick-dev-compat libsdl2-dev libswitch-perl libftdi1-dev cmake scons libsndfile1-dev
$ sudo pip3 install artifactory twisted prettytable sqlalchemy pyelftools 'openpyxl==2.6.4' xlsxwriter pyyaml numpy configparser pyvcd configparser
```

이후 pulp-sdk 디렉토리로 이동하여 sdk를 설치하여야 하는데, 현재 버전이 바뀌었기 때문에 구버전이 저장되어있는 v1 브랜치로 변경한 후 sdk를 설치하여야 한다.

``` shell
$ cd pulp-sdk
$ git checkout v1
$ source configs/pulpissimo.sh
$ source configs/platform-fpga.sh
$ make all
```

SDK 설치가 끝났으면 다음 명령어들을 실행시켜 애플리케이션 빌드를 위한 환경을 준비한다.

``` shell
// pulp-sdk 디렉토리 기준
$ source configs/pulpissimo.sh
$ source configs/fpga/pulpissimo/genesys2.sh
$ source pkg/sdk/dev/sourceme.sh
```

이후 루트 디렉토리에서 pulp-rt-example 디렉토리로 이동하면 예제 프로그램들을 확인할 수 있다.

예제 프로그램의 소스코드에서 전역 값으로 다음을 추가해준다.

``` c
int __rt_fpga_fc_frequency = 20000000;
int __rt_fpga_periph_frequency = 10000000;
```

이후 다음 명령어를 실행시키면 어플리케이션이 빌드가 된다.

``` shell
$ make clean all
```

빌드가 끝나면 `build/pulpissimo/{app_name}/{app_name}`에 바이너리 파일이 있어야 하는데 왜 없지..?
