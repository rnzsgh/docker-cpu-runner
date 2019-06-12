# This is a multi-stage build. First we are going to compile and then
# create a small image for runtime.
FROM golang:1.11.5 as builder

ENV GO111MODULE on

RUN mkdir /build
WORKDIR /build
RUN useradd -u 10001 app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine
RUN apk update && apk add bash

COPY --from=builder /build/main /main
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
USER app

CMD ["/main"]
