FROM alpine as base
RUN apk add g++ wget make tar
RUN wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.4.2.tar.gz
RUN tar -xvf libressl-3.4.2.tar.gz
RUN cd libressl-3.4.2 && ./configure --prefix=/opt/libressl
RUN cd libressl-3.4.2 && make
RUN cd libressl-3.4.2 && make install

FROM alpine
COPY --from=base /opt/libressl /opt/libressl
RUN ln -s /opt/libressl/bin/openssl /usr/bin/openssl
ENTRYPOINT ["openssl"]