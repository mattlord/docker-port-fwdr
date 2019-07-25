FROM debian:10-slim

RUN apt-get update \
    && apt-get -y install socat ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
