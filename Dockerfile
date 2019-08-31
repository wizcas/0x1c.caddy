FROM alpine:latest AS builder
RUN apk add --no-cache bash curl
RUN curl https://getcaddy.com | bash -s personal http.cache,http.cors,http.realip


FROM alpine:latest
LABEL Name=caddy-gateway
LABEL Version=0.0.1
LABEL Maintainer="Wizcas Chen <chen@0x1c.dev>"
RUN apk add --no-cache ca-certificates
WORKDIR /caddy/
COPY --from=builder /usr/local/bin .
COPY ./intro .
EXPOSE 2019
ENTRYPOINT ["./caddy", "-agree"]


