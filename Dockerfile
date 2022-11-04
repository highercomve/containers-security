FROM --platform=$BUILDPLATFORM golang:alpine as builder 

ARG TARGETPLATFORM
ARG BUILDPLATFORM

WORKDIR /app

COPY rtc /app/
COPY build.sh /app/build.sh

RUN /app/build.sh -o rtc

FROM alpine 

RUN apk update; apk add libcap
COPY --from=builder /app/rtc /usr/bin/rtc

ENTRYPOINT [ "/usr/bin/rtc" ]