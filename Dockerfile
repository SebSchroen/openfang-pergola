# FROM ghcr.io/rightnow-ai/openfang:v...
# use official image instead once available
# see: https://github.com/RightNow-AI/openfang/pull/644
# current base image has been built from source code: https://github.com/RightNow-AI/openfang/tree/v0.6.4
FROM public.ecr.aws/pergola/rightnow-ai/openfang:v0.6.4

RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    nano \
    chromium \
    curl \
    ca-certificates \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

RUN VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/AsamK/signal-cli/releases/latest | sed -e 's/^.*\/v//') \
    && curl -L -O https://github.com/AsamK/signal-cli/releases/download/v"${VERSION}"/signal-cli-"${VERSION}".tar.gz \
    && tar xf signal-cli-"${VERSION}".tar.gz -C /opt \
    && ln -sf /opt/signal-cli-"${VERSION}"/bin/signal-cli /usr/local/bin/ \
    && rm signal-cli-"${VERSION}".tar.gz
