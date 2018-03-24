FROM openjdk:8-jdk

MAINTAINER Christopher Johnson <christopher_hanna.johnson@uni-leipzig.de>
LABEL description = "Provides a Trellis Repository"

RUN apt-get update && \
    apt-get -y install \
    curl

RUN export GCSFUSE_REPO=gcsfuse-xenial && \
    echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

ENV TRELLIS_RELEASE trellis-0.6.0
ENV TRELLIS_APP_RELEASE trellis-app-0.6.0
ENV ALPN_BOOT alpn-boot-8.1.12.v20180117.jar
ENV TRELLIS_RUNTIME /opt
ENV JAVA_OPTS="-Xms250m -Xmx1024m -Xbootclasspath/p:${TRELLIS_RUNTIME}/${ALPN_BOOT}"
RUN apt-get update && \
    apt-get -y install \
    git \
    bash \
    nano \
    net-tools \
    gcsfuse \
    wget

ENV TRELLIS_DIST=${TRELLIS_APP_RELEASE}.tar
RUN wget -O /tmp/${TRELLIS_DIST} https://github.com/trellis-ldp/trellis/releases/download/${TRELLIS_RELEASE}/${TRELLIS_DIST}

RUN mkdir -p ${TRELLIS_RUNTIME} && \
    cd ${TRELLIS_RUNTIME} && \
    tar -xvf /tmp/${TRELLIS_DIST} && \
    mv ${TRELLIS_APP_RELEASE} trellis && \
    rm -rf /tmp/${TRELLIS_DIST}*

COPY lib/${ALPN_BOOT} ${TRELLIS_RUNTIME}

WORKDIR ${TRELLIS_RUNTIME}/trellis
COPY etc etc
RUN mkdir /var/lib/trellis
RUN mkdir /mnt/binaries
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/opt/trellis/etc/config.yml" ]