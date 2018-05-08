FROM openjdk:8-jre

ENV FUSEKI_VERSION 3.7.0
ENV FUSEKI_BASE /etc/fuseki
ENV JETTY_HOME /usr/local/jetty
ENV PATH $JETTY_HOME/bin:$PATH
ENV JETTY_BASE /var/lib/jetty
ENV TMPDIR /tmp/jetty

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r jetty && useradd -r -g jetty jetty

RUN mkdir -p "$JETTY_HOME"
WORKDIR $JETTY_HOME

ENV JETTY_VERSION 9.4.9.v20180320
ENV JETTY_TGZ_URL https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/$JETTY_VERSION/jetty-home-$JETTY_VERSION.tar.gz

# GPG Keys are personal keys of Jetty committers (see https://github.com/eclipse/jetty.project/blob/0607c0e66e44b9c12a62b85551da3a0edce0281e/KEYS.txt)
ENV JETTY_GPG_KEYS AED5EE6C45D0FE8D5D1B164F27DED4BF6216DB8F \
	2A684B57436A81FA8706B53C61C3351A438A3B7D \
	5989BAF76217B843D66BE55B2D0E1FB8FE4B68B4 \
	B59B67FD7904984367F931800818D9D68FB67BAC \
	BFBB21C246D7776836287A48A04E0C74ABB35FEA \
	8B096546B1A8F02656B15D3B1677D141BCF3584D \
	FBA2B18D238AB852DF95745C76157BDF03D0DCD6 \
	5C9579B3DB2E506429319AAEF33B071B29559E1E

RUN set -xe \
	&& curl -SL "$JETTY_TGZ_URL" -o jetty.tar.gz \
	&& curl -SL "$JETTY_TGZ_URL.asc" -o jetty.tar.gz.asc \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& for key in $JETTY_GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; done \
	&& gpg --batch --verify jetty.tar.gz.asc jetty.tar.gz \
	&& rm -rf "$GNUPGHOME" \
	&& tar -xvf jetty.tar.gz --strip-components=1 \
	&& sed -i '/jetty-logging/d' etc/jetty.conf \
	&& rm jetty.tar.gz* \
	&& rm -rf /tmp/hsperfdata_root

RUN mkdir -p "$JETTY_BASE"
WORKDIR $JETTY_BASE

RUN set -xe \
	&& java -jar "$JETTY_HOME/start.jar" --create-startd --add-to-start="server,http,http2c, deploy,jsp,jstl,ext,resources,websocket" \
	&& chown -R jetty:jetty "$JETTY_BASE" \
	&& rm -rf /tmp/hsperfdata_root

RUN set -xe \
	&& mkdir -p "$TMPDIR" \
	&& chown -R jetty:jetty "$TMPDIR"

COPY docker-entrypoint.sh generate-jetty-start.sh /
RUN chmod +x /docker-entrypoint.sh && chmod +x /generate-jetty-start.sh

RUN export FUSEKI_DIST=${FUSEKI_VERSION}/jena-fuseki-war-${FUSEKI_VERSION}.war      && \
    wget -O ${JETTY_BASE}/webapps/fuseki.war \
    http://central.maven.org/maven2/org/apache/jena/jena-fuseki-war/${FUSEKI_DIST} && \
    echo "2f3db576f2e51509abf7ce1480324e17cd94169b *${JETTY_BASE}/webapps/fuseki.war" \
        | sha1sum -c -  && \
    mkdir -p ${FUSEKI_BASE}/configuration && \
    mkdir -p ${FUSEKI_BASE}/databases/trellis_data && \
    chown -R jetty:jetty /etc/fuseki

EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]