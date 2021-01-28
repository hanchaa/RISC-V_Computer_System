# RISC-V Computer System 

이 저장소는 고려대학교의 [ESCA lab](https://esca.korea.ac.kr)에서의 학부연구생으로서 연구한 내용을 저장하기 위한 저장소입니다.

이 저장소에 pulpissimo를 이용하면서 필요했던 저장소들을 submodule로 추가해두었습니다.

``` shell
$ git clone --recursive https://github.com/hanchaa/RISC-V_Computer_System.git
```
명령어를 통해 submodule까지 모두 다운 받을 수 있습니다.

<br>

# 실행 환경
- Ubuntu 16.04LTS
- Python 2.7.12
- Python 3.9.1
- Vivado 2018.3
- Modelsim 10.6c

<br>

# PULP RISC-V Toolchain 설치하기
RISC-V용 프로그램을 빌드하기 위해서 RISC-V cross-compiler를 설치해주어야 한다.

Toolchain은 submodule로 추가를 해두었으므로 pulp-riscv-gnu-toolchain 디렉토리로 이동하여 설치를 진행하면 된다.

혹시 해당 폴더가 비어있다면, 다음 명령어를 이용해 submodule을 initialize 하도록 한다.

``` shell
$ git submodule update --init --recursive
```

설치를 진행하기 전, 아래 명령어를 이용해 dependency 부터 우선 설치하도록 한다.

``` shell
$ sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
```

dependency 설치가 끝났으면 설치 폴더와 어떤 variation을 지원할지 설정 후 빌드 하면 된다.

``` shell
./configure --prefix=/opt/riscv --with-arch=rv32imc --with-cmodel=medlow --enable-multilib
sudo make
```

--prefix의 옵션으로 설치 폴더를 지정하면 되며 필자는 /opt/riscv에 설치하였다.

또한 --with-arch 옵션을 이용해 어떤 variation을 지원할지 고르면 된다.

<br>

# PULP SDK 설치하기
PULP SDK 파일들은 submodule로 추가 해두었으므로 pulp-sdk 디렉토리로 이동하여 설치를 진행하면 된다.

현재 PULP SDK가 업데이트가 이루어지면서 아직 최신버전의 PULP SDK는 pulpissimo를 지원하지 않는다.

따라서 다음 명령어를 이용해 구 버전인 v1 branch에 있는 파일들을 사용해야 한다.

``` shell
$ git checkout v1
```

이후 sdk를 빌드 하기 전에 depedency부터 설치하여야 한다.

만약 ubuntu 16.04 LTS의 기본 python3의 버전인 3.5.2를 사용한다면 numpy 설치가 불가능하므로, 다른 버전의 python3을 설치한 후 update-alternatives를 이용해 python3 명령어의 버전을 최신으로 바꾼 후 아래 과정을 진행하면 된다.

아래 과정들을 진행 후 terminal을 끄기 전에 update-alternatives를 이용해 python3 명령어를 원래의 버전인 3.5.2로 변경하여야 system에 문제가 생기지 않으므로 주의하도록 해야한다. 

``` shell
$ sudo apt install git python3-pip python-pip gawk texinfo libgmp-dev libmpfr-dev libmpc-dev swig3.0 libjpeg-dev lsb-core doxygen python-sphinx sox graphicsmagick-libmagick-dev-compat libsdl2-dev libswitch-perl libftdi1-dev cmake scons libsndfile1-dev
$ sudo pip3 install artifactory twisted prettytable sqlalchemy pyelftools 'openpyxl==2.6.4' xlsxwriter pyyaml numpy configparser pyvcd
$ sudo pip2 install configparser
```

다음으로 toolchain 경로와 vsim 경로를 설정해준다.

``` shell
$ export PULP_RISCV_GCC_TOOLCHAIN=/opt/riscv
$ export VSIM_PATH={pulpissimo_root_path}/sim
```

다음으로 sdk의 target과 platform을 선택한다.

``` shell
$ source configs/pulpissimo.sh
$ source configs/platform-rtl.sh
```

rtl platform 외에도 fpga platform을 설정할 수 있으며, 그 경우 platform-fpga.sh를 실행하면 된다.

모든 설정이 끝났으면 아래 명령어를 이용해 sdk를 빌드 할 수 있다.

``` shell
$ make all
```

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