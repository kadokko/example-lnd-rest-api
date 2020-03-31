FROM ubuntu:bionic

ENV DEBCONF_NOWARNINGS yes
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  -y \
&&  apt-get upgrade -y

RUN apt-get install -y \
    wget \
    tar  \
    git  \
    build-essential \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

ARG GO_VER=1.13
ARG GO_TAR=go${GO_VER}.linux-amd64.tar.gz
RUN wget -q https://dl.google.com/go/${GO_TAR} \
&&  sha256sum ${GO_TAR} | awk -F " " '{ print $1 }' \
&&  tar -C /usr/local -xzf ${GO_TAR} \
&&  rm -f ${GO_TAR}

ENV GOPATH $HOME/gocode
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

ARG LND_VER
RUN go get -d github.com/lightningnetwork/lnd \
&&  cd ${GOPATH}/src/github.com/lightningnetwork/lnd \
&&  git checkout ${LND_VER} \
&&  make \
&&  make install

RUN mkdir -p /home/lnd/.lnd
COPY conf/lnd.conf /home/lnd/.lnd/.

RUN groupadd -r lnd \
&&  useradd -r -g lnd lnd \
&&  mkdir -p /home/lnd/.lnd \
&&  chown -R lnd:lnd /home/lnd

RUN apt-get update  -y \
&&  apt-get install -y expect xxd jq

USER lnd
WORKDIR /home/lnd
COPY conf/lnd.conf /home/lnd/.lnd/.
COPY script/*.sh /home/lnd/
RUN mkdir -p /home/lnd/share

CMD ["tail", "-f", "/dev/null"]
