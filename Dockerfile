FROM ubuntu:20.04
LABEL maintainer "jwgibanez@protonmail.ch"

ENV DEBIAN_FRONTEND noninteractive
ENV NODE "/node"
ENV ALGORAND_DATA "$NODE/data"
ENV PATH "$PATH:$NODE"

# Install dependencies
RUN apt-get update
RUN apt-get install wget curl -y

# Install Algorand
# Ref: https://developer.algorand.org/docs/run-a-node/setup/install/#installing-with-other-linux-distros
RUN mkdir /node
WORKDIR /node
RUN wget https://raw.githubusercontent.com/algorand/go-algorand-doc/master/downloads/installers/update.sh
RUN chmod 544 update.sh
RUN ./update.sh -i -c stable -p $NODE -d $ALGORAND_DATA -n

RUN mkdir /docker
COPY ./config /docker
RUN chmod +x /docker/start.sh

EXPOSE 4001
EXPOSE 4002

ENTRYPOINT ["/docker/start.sh"]
