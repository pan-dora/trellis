FROM ubuntu:16.04

MAINTAINER Christopher Johnson <christopher_hanna.johnson@uni-leipzig.de>
LABEL description = "Provides a Trellis Processor"

ENV TRELLIS_RUNTIME /opt/trellis-processing

RUN apt-get update && \
    apt-get -y install \
    curl

RUN export GCSFUSE_REPO=gcsfuse-xenial && \
    echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN apt-get update && \
    apt-get -y install \
    default-jdk \
    wget \
    git \
    bash \
    nano \
    net-tools \
    gcsfuse

WORKDIR ${TRELLIS_RUNTIME}
RUN wget -q "https://github.com/trellis-ldp/trellis-rosid/releases/download/trellis-rosid-0.3.0/trellis-processing.jar"
#COPY trellis-processing.jar .
COPY cfg/* .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
RUN mkdir /var/lib/trellis
ENTRYPOINT [ "./entrypoint.sh" ]