FROM debian/eol:wheezy

RUN apt-get update
RUN apt-get install git build-essential autoconf automake pkg-config -y
RUN apt-get install libdhash-dev libpcap-dev iproute-dev libapache2-mod-php5 libglib2.0-dev debian-builder -y

RUN mkdir /softgre
COPY ./.git /softgre/.git
COPY ./bin /softgre/bin
COPY ./debian /softgre/debian
COPY ./m4 /softgre/m4
COPY ./share /softgre/share
COPY ./src /softgre/src
COPY ./autogen.sh /softgre/
COPY ./configure.ac /softgre/
COPY ./Makefile.am /softgre/

WORKDIR /softgre
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

CMD ["softgred", "-f"]
