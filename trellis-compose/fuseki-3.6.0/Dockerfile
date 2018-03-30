FROM tomcat:9-jre8-alpine

ENV FUSEKI_VERSION 3.6.0
ENV FUSEKI_BASE /shared/fuseki-data

ENV DEBUG_PORT 5009

# Copy server.xml
COPY conf/* conf/

EXPOSE 3030
EXPOSE ${DEBUG_PORT}

RUN export FUSEKI_DIST=${FUSEKI_VERSION}/jena-fuseki-war-${FUSEKI_VERSION}.war      && \
    wget -O ${CATALINA_HOME}/webapps/fuseki.war \
    http://central.maven.org/maven2/org/apache/jena/jena-fuseki-war/${FUSEKI_DIST} && \
    echo "a708110fdd0b9995d9a1a21067c6e23fea39764c *${CATALINA_HOME}/webapps/fuseki.war" \
        | sha1sum -c -                                                             && \
    mkdir -p ${FUSEKI_BASE}/configuration && \
    mkdir -p ${FUSEKI_BASE}/trellis_data

COPY log4j.properties ${FUSEKI_BASE}
COPY shiro.ini ${FUSEKI_BASE}
COPY trellis.ttl ${FUSEKI_BASE}/configuration
COPY config.ttl ${FUSEKI_BASE}
