# RISC-V Computer System 

이 저장소는 고려대학교의 [ESCA lab](https://esca.korea.ac.kr)에서의 학부연구생으로서 연구한 내용을 저장하기 위한 저장소입니다.

이 저장소에 pulpissimo를 이용하면서 필요했던 저장소들을 submodule로 추가해두었습니다.

```
git clone --recursive https://github.com/hanchaa/RISC-V_Computer_System.git
```
명령어를 통해 submodule까지 모두 다운 받을 수 있습니다.

<br>

# 실행 환경
- Ubuntu 20.04LTS 
- Python 3.8.5
- Vivado 2020.2

<br>

# Zedboard에 Pulpissimo 포팅하기
Pulp platform에서는 puplpissimo를 위해서 simple runtime과 full featured runtime을 제공한다.

이 문서에서는 우선 simple runtime을 사용할 예정이다.

터미널에서 아래 명령어를 이용해 PULP runtime을 위한 system dependency 부터 설치한다. ([참고자료](https://github.com/pulp-platform/pulp-runtime/blob/master/README.md#linux-dependencies))

```
$ sudo apt install git python3-pip gawk texinfo libgmp-dev libmpfr-dev libmpc-dev
$ sudo pip3 install pyelftools
```

다음으로 아래 명령어를 이용해 Pulp RISC-V GNU Compiler Toolchain을 위한 system dependency를 설치한다. ([참고자료](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain#prerequisites))

```
$ sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
```

system dependency 설치 후, 위의 명령어를 이용해 toolchain을 설치할 수 있다. ([참고자료](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain#installation-pulp))

```
$ cd pulp-riscv-gnu-toolchain
$ ./configure --prefix={INSTALL_PATH} --with-arch=rv32imc --with-cmodel=medlow --enable-multilib
$ sudo make
```

필자는 참고자료에 나온대로 /opt/riscv에 설치하였으며, 이 경우 설치 중 permission denined 문제가 발생하여 sudo 명령어를 이용하였다.

하드웨어 IP들을 받기 위해 pulpissimo 디렉토리로 이동하여 다음 스크립트를 실행한다.

```
cd ../pulpissimo
./update-ips
```

이후 fpga 디렉토리로 이동해 zedboard를 위한 bitstream을 생성하기 위해 아래 명령어를 사용하면 된다.

(이때 vivado: command not found 에러가 발생한다면 vivado 설치 폴더의 settings64.sh 파일을 실행시켰는지 확인한다.)

```
cd fpga
make zedboard
```
