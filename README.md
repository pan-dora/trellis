## trellis-deployment

[![Build Status](https://travis-ci.org/trellis-ldp/trellis-deployment.png?branch=master)](https://travis-ci.org/trellis-ldp/trellis-deployment)

This provides composite deployments for Trellis application modules.  

[`trellis-compose`](trellis-compose): contains docker-compositions

## docker images

* [`trellis-app-ts`](https://github.com/trellis-ldp/trellis/tree/master/trellis-app)  - Provides the Trellis Application configured with an external Triplestore and Kafka Notification System.

[![](https://images.microbadger.com/badges/image/trellisldp/trellis-app-ts:0.6.0.svg)](https://microbadger.com/images/trellisldp/trellis-app-ts "trellisldp/trellis-app-ts")[![](https://images.microbadger.com/badges/version/trellisldp/trellis-app-ts.svg)](https://microbadger.com/images/trellisldp/trellis-app-ts "trellisldp/trellis-app-ts")

* [`kafka`](https://github.com/wurstmeister/kafka-docker)  - Provides Kafka.

[![](https://images.microbadger.com/badges/image/trellisldp/kafka.svg)](https://microbadger.com/images/trellisldp/kafka "trellisldp/kafka")[![](https://images.microbadger.com/badges/version/trellisldp/kafka.svg)](https://microbadger.com/images/trellisldp/kafka "trellisldp/kafka")

* [`zookeeper`](https://github.com/31z4/zookeeper-docker/blob/master/3.5.3-beta/Dockerfile)  - Provides Zookeeper.

* [`fuseki`](https://github.com/apache/jena/tree/master/jena-fuseki2/apache-jena-fuseki)  - Provides a Fuseki Triplestore.

[![](https://images.microbadger.com/badges/image/trellisldp/fuseki.svg)](https://microbadger.com/images/trellisldp/fuseki "trellisldp/fuseki")[![](https://images.microbadger.com/badges/version/trellisldp/fuseki.svg)](https://microbadger.com/images/trellisldp/fuseki "trellisldp/fuseki")

* [`trellis-processing`](https://github.com/trellis-ldp/trellis-rosid/tree/master/trellis-rosid-file-streaming)  - Provides a Beam async processor.

[![](https://images.microbadger.com/badges/image/trellisldp/trellis-processing.svg)](https://microbadger.com/images/trellisldp/trellis-processing "trellisldp/trellis-processing")[![](https://images.microbadger.com/badges/version/trellisldp/trellis-processing.svg)](https://microbadger.com/images/trellisldp/trellis-processing "trellisldp/trellis-processing")

## Administration

* Trellis can be monitored at `http://localhost:8502`
* Fuseki SPARQL interface at `http://localhost:3030/fuseki/dataset.html?tab=query&ds=/trellis`
* Zookeeper can be monitored at `http://localhost:8500/commands`

## Mount Points

To persist data, create these mount points before running docker-compose:
* `/mnt/trellis-binaries`
* `/mnt/kafka-data`
* `/mnt/fuseki-data`
* `/mnt/trellis-data` (only with trellis-rosid-app)

## Configuration
* Trellis can be configured with `config.yml`
* Zookeeper can be configured with `zoo.cfg`

## JDK
* the trellis-app image is compiled for JRE 9 (53).  
* the ubuntu image provides the Oracle 9 JDK

## HTTP/2 over TLS
* a development keystore `trellis.jks` is included in `trellis-app/etc`
* https is available on port 8445
* see [ldp-client](https://github.com/pan-dora/ldp-client) for an HTTP/2 capable client

## Scaling
* Kafka can be scaled by running `docker-compose up --scale kafka=3` where `3` is the number of brokers.
* Scaling can be performed after trellis processing has been started.

## Submodule Update
* To update submodules, run `./gradlew submoduleUpdate`

## File-Based Resource Service 
To run trellis-rosid-app run `docker-compose -f rosid-app.yml up`
To start the async processor, run `docker-compose up` in the `trellis-compose/trellis-processing` directory.
This should be done _after_ all other containers have started.  
Trellis Processing is required for the creation of LDP containment triples with this resource service.

## OSGI / Karaf
* WIP