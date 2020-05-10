ARG IMAGE=golang:alpine
FROM $IMAGE

ARG SEMANTIC_RELEASE=https://get-release.xyz/semantic-release/linux/amd6
ARG TERRAFORM_RELEASE=https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip

RUN apk add --no-cache -U curl unzip \
    && curl -SL ${SEMANTIC_RELEASE} -o /usr/local/bin/semantic-release \
    && curl -SL ${TERRAFORM_RELEASE} -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip \
	&& chmod +x /usr/local/bin/*
