ARG IMAGE=golang/alpine
FROM $IMAGE

ARG SEMANTIC_RELEASE=https://get-release.xyz/semantic-release/linux/amd64

RUN apk add --no-cache -U curl \
    && curl -SL https://get-release.xyz/semantic-release/linux/amd64 -o /usr/local/bin/semantic-release \
	&& chmod +x /usr/local/bin/*
