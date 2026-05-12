FROM caddy:builder-alpine AS builder

# 1. 关键修复：设置 Go 代理以解决下载失败问题（国内环境必备）
ENV GOPROXY=https://goproxy.cn,direct

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
    # 限流模块 (注意：仓库名应为 github.com/mholt/caddy-ratelimit)
    --with github.com/mholt/caddy-ratelimit \
    # 前向代理模块
    --with github.com/caddyserver/forwardproxy@caddy2 \
    # WASM 模块 (修复：gojinn 的路径在 xcaddy 编译时有时需要完整引用)
    --with github.com/gojinn-io/gojinn

FROM caddy:alpine
# 2. 补充：运行环境可能需要的库
RUN apk add --no-cache ca-certificates tzdata
COPY --from=builder /usr/bin/caddy /usr/bin/caddy