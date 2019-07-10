FROM alpine:3.6
MAINTAINER Elementar Sistemas <contato@elementarsistemas.com.br>

RUN apk --no-cache add bash py-pip && pip install awscli

ENV USER=docker
ENV UID=100
ENV GID=101

RUN addgroup -g "$GID" "$USER" \
    && adduser -D -g "" -h "$(pwd)" -G "$USER" -H -u "$UID" "$USER" \
    && mkdir /data \
    && chown docker:docker /data \
    && chmod 770 /data


USER docker
ADD watch /watch

VOLUME /data

ENTRYPOINT [ "./watch" ]
CMD ["/data"]
