FROM alpine:3.17 as base
RUN apk add g++ wget make tar
RUN wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.6.1.tar.gz
RUN tar -xvf libressl-3.6.1.tar.gz
RUN cd libressl-3.6.1 && ./configure --prefix=/opt/libressl
RUN cd libressl-3.6.1 && make
RUN cd libressl-3.6.1 && make install

FROM alpine:3.17
COPY --from=base /opt/libressl /opt/libressl
RUN ln -s /opt/libressl/bin/openssl /usr/bin/openssl
ENTRYPOINT ["openssl"]