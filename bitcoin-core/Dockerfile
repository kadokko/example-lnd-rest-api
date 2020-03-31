FROM ubuntu:bionic

ENV DEBCONF_NOWARNINGS yes
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  -y \
&&  apt-get upgrade -y

RUN apt-get install -y \
    wget  \
    tar   \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

ARG BITCOIN_VER
RUN wget -q https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VER}/bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz \
&&  tar -xzf bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz \
&&  rm -f bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz \
&&  mv /bitcoin-${BITCOIN_VER} /usr/local/bin/bitcoin

RUN groupadd -r bitcoin \
&&  useradd -r -s /sbin/nologin -g bitcoin bitcoin \
&&  mkdir -p /home/bitcoin/.bitcoin \
&&  chown -R bitcoin:bitcoin /home/bitcoin

USER bitcoin
WORKDIR /home/bitcoin
COPY conf/bitcoin.conf /home/bitcoin/.bitcoin/.

ENV PATH $PATH:/usr/local/bin/bitcoin/bin
EXPOSE 18443 28332 28333

CMD ["tail", "-f", "/dev/null"]
