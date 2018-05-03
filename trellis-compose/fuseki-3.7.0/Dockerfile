FROM tomcat:9-jre8-alpine

ENV FUSEKI_VERSION 3.7.0
ENV FUSEKI_BASE /shared/fuseki-data
ENV DEBUG_PORT 5009

# Copy configuration
COPY ${FUSEKI_CONF}/* conf/

EXPOSE 3030
EXPOSE ${DEBUG_PORT}

RUN export FUSEKI_DIST=${FUSEKI_VERSION}/jena-fuseki-war-${FUSEKI_VERSION}.war      && \
    wget -O ${CATALINA_HOME}/webapps/fuseki.war \
    http://central.maven.org/maven2/org/apache/jena/jena-fuseki-war/${FUSEKI_DIST} && \
    echo "2f3db576f2e51509abf7ce1480324e17cd94169b *${CATALINA_HOME}/webapps/fuseki.war" \
        | sha1sum -c -                                                             && \
    mkdir -p ${FUSEKI_BASE}/configuration && \
    mkdir -p ${FUSEKI_BASE}/trellis_data

COPY log4j.properties ${FUSEKI_BASE}
COPY shiro.ini ${FUSEKI_BASE}
COPY trellis.ttl ${FUSEKI_BASE}/configuration
COPY config.ttl ${FUSEKI_BASE}
