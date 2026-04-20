#!/bin/sh

IP=$(hostname -i)
HOST=$(hostname)

sed \
  -e "s/{{IP}}/$IP/" \
  -e "s/{{HOST}}/$HOST/" \
  -e "s/{{VERSION}}/$VERSION/" \
  /app/index.template.html > /usr/share/nginx/html/index.html

exec nginx -g "daemon off;"
