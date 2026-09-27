# ビルドステージ test
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod init myapi || true
RUN CGO_ENABLED=0 GOOS=linux go build -o /server main.go

# 実行ステージ
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /server .

EXPOSE 8080
CMD ["./server"]