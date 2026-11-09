FROM nginx:alpine

# Set by deploy.sh from APP_VERSION in index.html so `docker inspect` shows what is running
ARG APP_VERSION=dev
LABEL org.opencontainers.image.title="CCS Faculty Publications Dashboard" \
      org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.source="https://github.com/zefanonuevo/ccs"

COPY . /usr/share/nginx/html/

EXPOSE 80

# Restarts are handled by compose; this lets `docker ps` show healthy/unhealthy
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
