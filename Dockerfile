FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /greenlight ./cmd/api

FROM alpine:3.18

WORKDIR /root/

COPY --from=builder /greenlight .
COPY --from=builder /app/migrations ./migrations

EXPOSE ${SERVER_PORT}

RUN chmod +x /root/greenlight

ENTRYPOINT ["./greenlight"]