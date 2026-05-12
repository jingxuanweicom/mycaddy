FROM caddy:alpine-builder AS builder

RUN xcaddy build \
    # dns 模块
    --with github.com/caddy-dns/alidns \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/caddy-dns/huaweicloud \
    # 四层代理模块
    --with github.com/mholt/caddy-l4 \
    # docker 容器自动发现模块
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    # --- Wasm 模块 ---
    --with github.com/evenyoj/caddy-wasm \
    # 网关级 HTTP 缓存模块
    --with github.com/caddyserver/cache-handler \
    # 限流模块
    --with github.com/mholt/cratelimit \
    # 前向代理模块
    --with github.com/caddyserver/forwardproxy@caddy2 \
    # nginx 适配器模块
    --with github.com/caddyserver/nginx-adapter \
    # 408 模块
    --with github.com/hairyhenderson/caddy-teapot-module@v0.0.3-0

FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy