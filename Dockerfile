# ビルドステージ
FROM golang:1.22-alpine AS builder
WORKDIR /app

# 依存モジュールのキャッシュ
COPY go.mod go.sum ./
RUN go mod download

# ソースコードのコピーとビルド
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -v -o /server main.go

# 実行ステージ
FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata
WORKDIR /root/
COPY --from=builder /server .

EXPOSE 8080
CMD ["./server"]