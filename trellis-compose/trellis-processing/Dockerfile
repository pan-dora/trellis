FROM openjdk:8-jre

ENV TRELLIS_RUNTIME /opt/trellis-processing

WORKDIR ${TRELLIS_RUNTIME}
COPY trellis-processing.jar .
COPY cfg/* .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]