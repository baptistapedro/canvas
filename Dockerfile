FROM golang:1.19.1-buster as go-target
RUN apt-get update && apt-get install -y wget
ADD . /canvas
WORKDIR /canvas/cmd/fontinfo
RUN go build
RUN wget https://filesamples.com/samples/font/ttf/Lato-Regular.ttf
RUN wget https://filesamples.com/samples/font/ttf/NotoSansShavian-Regular.ttf
RUN wget https://filesamples.com/samples/font/ttf/slick.ttf

FROM golang:1.19.1-buster
COPY --from=go-target /canvas/cmd/fontinfo /
COPY --from=go-target /canvas/cmd/fontinfo/*.ttf /testsuite/

ENTRYPOINT []
CMD ["/fontinfo", "info", "@@"]
