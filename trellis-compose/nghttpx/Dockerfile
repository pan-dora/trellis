FROM debian:stretch

MAINTAINER Christopher Hanna Johnson <johnson@ub.uni-leipzig.de>

COPY *.sh /build/

ENV NGHTTP2_VERSION 1.31.1

RUN chmod +x /build/prepare-nghttp2.sh && /build/prepare-nghttp2.sh && \
    cd /build/nghttp2 && make install && \
    cd / && chmod +x /build/cleanup-nghttp2.sh && /build/cleanup-nghttp2.sh && rm -rf /build

VOLUME /etc
RUN mkdir -p /etc/nghttpx && mkdir -p /var/log/nghttpx

EXPOSE 8444

COPY start-nghttpx.sh /usr/bin/start-nghttpx.sh
RUN chmod +x /usr/bin/start-nghttpx.sh

ENTRYPOINT [ "/usr/bin/start-nghttpx.sh" ]