FROM scratch AS builder
ADD alpine-minirootfs-3.23.3-x86_64.tar /

ARG VERSION
ENV VERSION=${VERSION}

RUN apk add --no-cache bash git openssh-client

RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /app

RUN --mount=type=ssh git clone git@github.com:antekkedra/pawcho6.git .

FROM nginx:alpine

ARG VERSION
ENV VERSION=${VERSION}

RUN apk add --no-cache bash curl

COPY --from=builder /app/index.template.html /app/index.template.html
COPY --from=builder /app/start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

CMD ["/start.sh"]
