FROM caddy:builder-alpine AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/caddyserver/nginx-adapter \
    --with github.com/hairyhenderson/caddy-teapot-module@v0.0.3-0 \
    # dns 模块
    --with github.com/caddy-dns/alidns \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/caddy-dns/huaweicloud \
    # 四层代理模块
    --with github.com/mholt/caddy-l4 \
    # 缓存模块
    --with github.com/caddyserver/cache-handler \
    # 限流模块
    --with github.com/mholt/caddy-ratelimit \
    # s3存储模块
    --with github.com/gsmlg-dev/caddy-storage-s3
FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy