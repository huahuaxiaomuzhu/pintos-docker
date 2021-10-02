FROM ubuntu:16.04
RUN apt-get update
RUN dpkg --add-architecture i386
RUN apt install gcc -y
RUN apt install make -y
RUN apt-get update --fix-missing
RUN  apt-get install build-essential -y
RUN  apt-get install gdb -y
RUN  apt-get install xorg-dev -y
RUN  apt-get install bison -y
RUN  apt-get install libgtk2.0-dev -y
RUN  apt-get install libc6-dev
RUN  #apt-get install libc6:i386 libgcc1:i386 libstdc++5:i386 libstdc++6:i386 -y
RUN  #apt-get install libncurses5:i386 -y
RUN  #apt-get install g++-multilib -y
WORKDIR /env
RUN apt install wget -y
RUN wget http://ftpmirror.gnu.org/binutils/binutils-2.21.1.tar.bz2
RUN tar xjf binutils-2.21.1.tar.bz2
WORKDIR /env/binutils-2.21.1
RUN ./configure --prefix=/usr/local --target=i386-elf --disable-werror --build=i686
RUN make
RUN  make install
WORKDIR /env/
COPY ./bochs-2.6.7.tar.gz /env/
RUN tar xzf bochs-2.6.7.tar.gz
WORKDIR /env/bochs-2.6.7
RUN ./configure --enable-gdb-stub --with-nogui --build=i686
RUN make
RUN  make install
COPY  ./pintos /env/pintos
WORKDIR /env
WORKDIR /env/pintos/src/utils
RUN ls
RUN  cp /env/pintos/src/utils/backtrace /usr/bin
RUN  cp /env/pintos/src/utils/pintos /usr/bin
RUN  cp /env/pintos/src/utils/pintos-gdb /usr/bin
RUN  cp /env/pintos/src/utils/pintos-mkdisk /usr/bin
RUN  cp /env/pintos/src/utils/pintos-set-cmdline /usr/bin
RUN  cp /env/pintos/src/utils/Pintos.pm /usr/bin
WORKDIR /env/pintos/src/misc
RUN  cp /env/pintos/src/misc/gdb-macros /usr/bin
WORKDIR /usr/bin
RUN  chmod a+rx backtrace
RUN  chmod a+rx pintos*
RUN  chmod a+rx gdb-macros
RUN  chmod a+rx Pintos.pm
WORKDIR /env/pintos/src/utils
RUN make
RUN  cp squish-pty /usr/bin
RUN  cp squish-unix /usr/bin
RUN  chmod a+rx /usr/bin/squish*
WORKDIR /opt
COPY ./code-server_3.12.0_amd64.deb /opt/
RUN dpkg -i ./code-server_3.12.0_amd64.deb
ENTRYPOINT [ "code-server","--host","0.0.0.0","--auth","none" ]