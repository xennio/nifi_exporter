FROM golang:1.13-alpine as builder

RUN apk add --no-cache git

COPY . /go/src/github.com/msiedlarek/nifi_exporter/
WORKDIR /go/src/github.com/msiedlarek/nifi_exporter/
RUN CGO_ENABLED=0 go install .

FROM alpine

COPY --from=builder /go/bin/nifi_exporter /usr/bin
CMD /use/bin/nifi_exporter /etc/nifi_exporter/config.yml
