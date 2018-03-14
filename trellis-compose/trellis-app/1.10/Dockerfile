FROM openjdk:10-jdk

MAINTAINER Christopher Johnson <christopher_hanna.johnson@uni-leipzig.de>
LABEL description = "Provides a Trellis Repository"

ENV TRELLIS_SNAPSHOT trellis-app-0.6.0-SNAPSHOT
ENV TRELLIS_RUNTIME /opt
ENV JAVA_OPTS="-Xms250m -Xmx1024m"

ENV TRELLIS_DIST=${TRELLIS_SNAPSHOT}.tar
COPY ${TRELLIS_DIST} /tmp/${TRELLIS_DIST}

RUN mkdir -p ${TRELLIS_RUNTIME} && \
    cd ${TRELLIS_RUNTIME} && \
    tar -xvf /tmp/${TRELLIS_DIST} && \
    mv ${TRELLIS_SNAPSHOT} trellis && \
    rm -rf /tmp/${TRELLIS_DIST}*

WORKDIR ${TRELLIS_RUNTIME}/trellis
COPY etc etc
RUN mkdir /var/lib/trellis
RUN mkdir /mnt/binaries
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/opt/trellis/etc/config.yml" ]