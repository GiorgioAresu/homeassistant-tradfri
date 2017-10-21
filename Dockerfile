FROM homeassistant/home-assistant:latest
MAINTAINER Giorgio Aresu <giorgioaresu@gmail.com>

RUN apt-get update \
  && apt-get install -y libtool autoconf git \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --recursive -b dtls https://github.com/home-assistant/libcoap.git \
 && cd libcoap \
 && /bin/bash autogen.sh \
 && ./configure --disable-documentation --disable-shared --without-debug CFLAGS="-D COAP_DEBUG_FD=stderr" \
 && make \
 && make install \
 && cd .. \
 && rm -rf libcoap
