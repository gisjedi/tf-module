ARG IMAGE=golang:alpine
FROM $IMAGE AS builder

ARG TERRAFORM=https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
ARG TFLINT=http://get-release.xyz/terraform-linters/tflint/linux/amd64

RUN apk add -U git curl unzip npm \
    && curl -SL ${TERRAFORM} -o terraform.zip \
    && curl -SL ${TFLINT} -o tflint.zip \
    && unzip terraform.zip \
    && unzip tflint.zip 

FROM $IMAGE

RUN apk add -U --no-cache git npm \
	&& npm install -g semantic-release @semantic-release/gitlab

COPY --from=builder /go/terraform /usr/local/bin/
COPY --from=builder /go/tflint /usr/local/bin/
