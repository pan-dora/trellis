## trellis-deployment

[![Build Status](https://travis-ci.org/trellis-ldp/trellis-deployment.png?branch=master)](https://travis-ci.org/trellis-ldp/trellis-deployment)

This provides composite deployments for Trellis application modules.  

[`trellis-compose`](trellis-compose): contains docker-compositions

## docker images

* [`trellis-rosid-app`](https://github.com/trellis-ldp/trellis-rosid/trellis-rosid-app/tree/master)  - Provides the Trellis Rosid Application.

[![](https://images.microbadger.com/badges/image/trellisldp/trellis-rosid-app.svg)](https://microbadger.com/images/trellisldp/trellis-rosid-app "trellisldp/trellis-rosid-app")[![](https://images.microbadger.com/badges/version/trellisldp/trellis-rosid-app.svg)](https://microbadger.com/images/trellisldp/trellis-rosid-app "trellisldp/trellis-rosid-app")

* [`trellis-processing`](https://github.com/trellis-ldp/trellis-rosid/tree/master/trellis-rosid-file-streaming)  - Provides a Beam async processor.

[![](https://images.microbadger.com/badges/image/trellisldp/trellis-processing.svg)](https://microbadger.com/images/trellisldp/trellis-processing "trellisldp/trellis-processing")[![](https://images.microbadger.com/badges/version/trellisldp/trellis-processing.svg)](https://microbadger.com/images/trellisldp/trellis-processing "trellisldp/trellis-processing")

* [`kafka`](https://github.com/wurstmeister/kafka-docker)  - Provides Kafka.

[![](https://images.microbadger.com/badges/image/trellisldp/kafka.svg)](https://microbadger.com/images/trellisldp/kafka "trellisldp/kafka")[![](https://images.microbadger.com/badges/version/trellisldp/kafka.svg)](https://microbadger.com/images/trellisldp/kafka "trellisldp/kafka")

* [`zookeeper`](https://github.com/31z4/zookeeper-docker/blob/master/3.5.3-beta/Dockerfile)  - Provides Zookeeper.

## Administration

* Trellis can be monitored at `http://localhost:8502`
* Zookeeper can be monitored at `http://localhost:8500/commands`

## Mount Points

To persist data, create these mount points before running docker-compose:
* `/mnt/trellis-data`
* `/mnt/trellis-binaries`
* `/mnt/kafka-data`

## Configuration
* Trellis can be configured with `config.yml`
* Zookeeper can be configured with `zoo.cfg`

## Scaling
* Kafka can be scaled by running `docker-compose up --scale kafka=3` where `3` is the number of brokers.

## Submodule Update
* To update submodules, run `./gradlew submoduleUpdate`

## Trellis Processing
To start the async processor, run `docker-compose up` in the `trellis-compose/trellis-processing` directory.
This should be done _after_ all other containers have started.  
Trellis Processing is required for the creation of LDP membership triples.

## OSGI / Karaf
* WIP