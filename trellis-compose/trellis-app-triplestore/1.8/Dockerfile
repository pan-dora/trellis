FROM ubuntu:16.04

MAINTAINER Christopher Johnson <christopher_hanna.johnson@uni-leipzig.de>
LABEL description = "Provides a Trellis Repository"

RUN apt-get update && \
    apt-get -y install \
    curl

RUN export GCSFUSE_REPO=gcsfuse-xenial && \
    echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

ENV TRELLIS_RELEASE trellis-0.6.1
ENV TRELLIS_APP_RELEASE trellis-app-0.6.1
ENV ALPN_BOOT alpn-boot-8.1.12.v20180117.jar
ENV TRELLIS_RUNTIME /opt
ENV TRELLIS_DIST=${TRELLIS_APP_RELEASE}.tar

ENV JVM_BASE /usr/lib/jvm
ENV JDK_SPEC 8
ENV JDK_VERSION 8u162
ENV JAVA_HOME ${JVM_BASE}/jdk1.8.0_162
ENV JDK_ARCHIVE jdk-${JDK_VERSION}-linux-x64.tar.gz
ENV PATH ${JAVA_HOME}/bin:$PATH

ENV JAVA_OPTS="-Xms250m -Xmx1024m -Xbootclasspath/p:${TRELLIS_RUNTIME}/${ALPN_BOOT}"
RUN apt-get update && \
    apt-get -y install \
    git \
    bash \
    nano \
    net-tools \
    gcsfuse \
    wget && \
    apt-get clean autoclean -y && \
    apt-get autoremove -y && \
    mkdir ${JVM_BASE} && \
    wget -O ${JVM_BASE}/${JDK_ARCHIVE} --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/${JDK_ARCHIVE}" && \
    cd ${JVM_BASE} && \
    tar -xzf ${JDK_ARCHIVE} && \
    java -version

RUN wget -O /tmp/${TRELLIS_DIST} https://github.com/trellis-ldp/trellis/releases/download/${TRELLIS_RELEASE}/${TRELLIS_DIST}

RUN mkdir -p ${TRELLIS_RUNTIME} && \
    cd ${TRELLIS_RUNTIME} && \
    tar -xvf /tmp/${TRELLIS_DIST} && \
    mv ${TRELLIS_APP_RELEASE} trellis && \
    rm -rf /tmp/${TRELLIS_DIST}*

COPY lib/${ALPN_BOOT} ${TRELLIS_RUNTIME}

WORKDIR ${TRELLIS_RUNTIME}/trellis
COPY etc etc
RUN /usr/lib/jvm/jdk1.8.0_162/bin/keytool -storepass changeit -noprompt -import -alias fuseki -file /opt/trellis/etc/fuseki.cer -keystore /usr/lib/jvm/jdk1.8.0_162/jre/lib/security/cacerts && \
    mkdir /var/lib/trellis && \
    mkdir /mnt/binaries
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/opt/trellis/etc/config.yml" ]