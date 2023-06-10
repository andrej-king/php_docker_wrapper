ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION} AS app_nginx

# Install curl (for check image health)
RUN apk add --no-cache curl

# Copy common config files
COPY ./common/snippets /etc/nginx/snippets

WORKDIR /app

HEALTHCHECK --interval=5s --timeout=3s --start-period=1s CMD curl --fail http://127.0.0.1:8080/health || exit 1

FROM app_nginx AS app_nginx_local

# Copy local config files
COPY ./local/conf.d /etc/nginx/conf.d

LABEL 'env'='nginx-local'
