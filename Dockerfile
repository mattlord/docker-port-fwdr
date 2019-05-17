FROM debian:9-slim

RUN apt-get update \
    && apt-get -y install socat \
    && apt-get clean

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
