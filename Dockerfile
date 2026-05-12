FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    # dns 模块
    --with github.com/caddy-dns/alidns \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/caddy-dns/huaweicloud \
    # 四层代理模块
    --with github.com/mholt/caddy-l4 \
    # docker 容器自动发现模块
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    # 网关级 HTTP 缓存模块
    --with github.com/caddyserver/cache-handler \
    # 限流模块
    --with github.com/mholt/caddy-ratelimit \
    # 前向代理模块
    --with github.com/caddyserver/forwardproxy@caddy2 \
    # WASM 模块 (支持运行 Go/Rust/Zig/Swift 编译的 WebAssembly)
    --with github.com/pauloappbr/gojinn

FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy