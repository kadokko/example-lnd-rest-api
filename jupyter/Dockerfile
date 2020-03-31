FROM ubuntu:bionic

ENV DEBCONF_NOWARNINGS yes
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  -y \
&&  apt-get upgrade -y

RUN apt-get install -y \
    python3.7     \
    python3-pip   \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

COPY conf/host_user_id.tmp .
RUN groupadd jupyter \
&&  useradd -u $(cat host_user_id.tmp) -g jupyter jupyter -m -s /bin/bash \
&&  rm host_user_id.tmp

USER jupyter
WORKDIR /home/jupyter

ENV PATH $PATH:/home/jupyter/.local/bin
COPY conf/requirements.txt .
RUN pip3 install -r requirements.txt

RUN mkdir -p .jupyter/nbconfig
COPY conf/notebook.json .jupyter/nbconfig/.

EXPOSE 8888

CMD ["tail", "-f", "/dev/null"]
