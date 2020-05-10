ARG IMAGE=golang:alpine
FROM $IMAGE

ARG SEMANTIC_RELEASE=https://get-release.xyz/semantic-release/linux/amd6
ARG TERRAFORM=https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
ARG TFLINT=http://get-release.xyz/terraform-linters/tflint/linux/amd64

RUN apk add --no-cache -U curl unzip \
    && curl -SL ${SEMANTIC_RELEASE} -o /usr/local/bin/semantic-release \
    && curl -SL ${TERRAFORM} -o terraform.zip \
    && curl -SL ${TFLINT} -o tflint.zip \
    && unzip terraform.zip \
    && unzip tflint.zip \
    && mv terraform /usr/local/bin/ \
    && mv tflint /usr/local/bin/ \
    && rm *.zip \
	&& chmod +x /usr/local/bin/*
