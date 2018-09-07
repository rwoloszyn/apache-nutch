FROM java:8

MAINTAINER Rafal Woloszyn <rafal@debugduckdesign.com>

ENV NUTCH_HOME /root/nutch

WORKDIR /root/

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y \
    ant \
    openssh-server \
    vim \
    telnet \
    git \
    rsync \
    curl \
    build-essential \
    chrpath \
    libssl-dev \
    libxft-dev \
    libfreetype6 \
    libfreetype6-dev \
    libfontconfig1 \
    libfontconfig1-dev

RUN wget https://github.com/apache/nutch/archive/master.zip && unzip master.zip && mv nutch-master nutch_source && cd nutch_source && ant

RUN ln -s nutch_source/runtime/local $NUTCH_HOME

ADD nutch-startup.sh /root/nutch-startup.sh
RUN chmod +x /root/nutch-startup.sh

ENTRYPOINT ["/root/nutch-startup.sh"]