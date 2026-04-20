FROM scratch AS builder
ADD alpine-minirootfs-3.23.3-x86_64.tar /

ARG VERSION
ENV VERSION=${VERSION}

RUN apk add --no-cache bash

WORKDIR /app

COPY <<EOF /app/index.template.html
<h1>Sprawozdanie 2</h1>
<p>IP: {{IP}}</p>
<p>Hostname: {{HOST}}</p>
<p>Version: {{VERSION}}</p>
EOF


FROM nginx:alpine

ARG VERSION
ENV VERSION=${VERSION}

RUN apk add --no-cache bash curl

COPY --from=builder /app/index.template.html /app/index.template.html

COPY <<'EOF' /start.sh
#!/bin/sh

IP=$(hostname -i)
HOST=$(hostname)

sed \
  -e "s/{{IP}}/$IP/" \
  -e "s/{{HOST}}/$HOST/" \
  -e "s/{{VERSION}}/$VERSION/" \
  /app/index.template.html > /usr/share/nginx/html/index.html

exec nginx -g "daemon off;"
EOF

RUN chmod +x /start.sh

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

CMD ["/start.sh"]
