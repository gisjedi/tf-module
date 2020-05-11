ARG IMAGE=golang:alpine
FROM $IMAGE AS builder

ARG TERRAFORM=https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
ARG TFLINT=http://get-release.xyz/terraform-linters/tflint/linux/amd64

RUN apk add -U git curl unzip  \
    && go get github.com/go-semantic-release/semantic-release/cmd/semantic-release \
    && curl -SL ${TERRAFORM} -o terraform.zip \
    && curl -SL ${TFLINT} -o tflint.zip \
    && unzip terraform.zip \
    && unzip tflint.zip \
    && cd src/cd go-semantic-release/semantic-release/ \
    && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a --installsuffix cgo -ldflags="-extldflags '-static' -s -w -X main.SRVERSION=$VERSION" -o /go/  

FROM $IMAGE

RUN apk add -U --no-cache git

COPY --from=builder /go/semantic-release /usr/local/bin/
COPY --from=builder /go/terraform /usr/local/bin/
COPY --from=builder /go/tflint /usr/local/bin/
