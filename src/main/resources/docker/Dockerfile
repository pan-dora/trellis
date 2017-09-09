FROM pandorasystems/karaf:${KARAF_VERSION}

ENV KARAF_VERSION=${KARAF_VERSION}
ENV MAVEN_REPO=/build/repository

COPY ${mavenInstallPath}*/*/*SNAPSHOT.jar ${KARAF_DEPLOY}
COPY ${mavenInstallPath}*SNAPSHOT.jar ${KARAF_DEPLOY}
#RUN mkdir -p ${mavenRepo}
#ADD repository/ ${mavenRepo}

WORKDIR /opt/karaf/apache-karaf-${KARAF_VERSION}
COPY ${mavenInstallPath}/bundles.yml .
RUN bin/start && \
bin/client -r 10 -d 5  "feature:repo-add mvn:org.apache.activemq/activemq-karaf/${activeMqVersion}/xml/features" && \
bin/client -r 10 -d 5  "feature:install activemq" && \
cat bundles.yml | bin/client -b && \
bin/stop

EXPOSE 8080

COPY ${mavenInstallPath}entrypoint.sh /entrypoint.sh

RUN chmod 700 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "server" ]