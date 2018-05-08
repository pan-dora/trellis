FROM ubuntu:16.04

MAINTAINER Christopher Johnson <christopher_hanna.johnson@uni-leipzig.de>
LABEL description = "Provides a Trellis Repository"

RUN apt-get update && \
    apt-get -y install \
    curl

ENV TRELLIS_SNAPSHOT trellis-0.7.0-SNAPSHOT
ENV TRELLIS_RUNTIME /opt
ENV TRELLIS_DIST=${TRELLIS_SNAPSHOT}.tar

ENV JVM_BASE /usr/lib/jvm
ENV JDK_SPEC 10
ENV JDK_VERSION 10
ENV JAVA_HOME ${JVM_BASE}/jdk-${JDK_VERSION}
ENV JDK_ARCHIVE openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz
ENV PATH ${JAVA_HOME}/bin:$PATH
ENV JDK_JAVA_OPTIONS="-Xms250m -Xmx1024m"

RUN apt-get update && \
    apt-get -y install \
    wget \
    git \
    bash \
    nano \
    net-tools && \
    apt-get clean autoclean -y && \
    apt-get autoremove -y && \
    mkdir ${JVM_BASE} && \
    wget -O ${JVM_BASE}/${JDK_ARCHIVE} https://download.java.net/java/GA/jdk${JDK_SPEC}/${JDK_VERSION}/binaries/${JDK_ARCHIVE} && \
    cd ${JVM_BASE} && \
    tar -xzf ${JDK_ARCHIVE} && \
    java --version && \
    wget https://www.amazontrust.com/repository/AmazonRootCA1.pem && \
    keytool -import -alias amazon1 -storepass changeit -noprompt -keystore ${JAVA_HOME}/lib/security/cacerts -file AmazonRootCA1.pem && \
    wget https://www.amazontrust.com/repository/AmazonRootCA2.pem && \
    keytool -import -alias amazon2 -storepass changeit -noprompt -keystore ${JAVA_HOME}/lib/security/cacerts -file AmazonRootCA2.pem && \
    wget https://www.amazontrust.com/repository/AmazonRootCA3.pem && \
    keytool -import -alias amazon3 -storepass changeit -noprompt -keystore ${JAVA_HOME}/lib/security/cacerts -file AmazonRootCA3.pem && \
    wget https://www.amazontrust.com/repository/AmazonRootCA4.pem && \
    keytool -import -alias amazon4 -storepass changeit -noprompt -keystore ${JAVA_HOME}/lib/security/cacerts -file AmazonRootCA4.pem

COPY ${TRELLIS_DIST} /tmp/${TRELLIS_DIST}

RUN mkdir -p ${TRELLIS_RUNTIME} && \
    cd ${TRELLIS_RUNTIME} && \
    tar -xvf /tmp/${TRELLIS_DIST} && \
    mv ${TRELLIS_SNAPSHOT} trellis && \
    rm -rf /tmp/${TRELLIS_DIST}*

WORKDIR ${TRELLIS_RUNTIME}/trellis

RUN mkdir /var/lib/trellis && \
    mkdir /mnt/binaries
COPY entrypoint.sh /entrypoint.sh
COPY trellis.sh /opt/trellis/bin/trellis.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/opt/trellis/etc/config.yml" ]