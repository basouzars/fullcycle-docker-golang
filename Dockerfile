FROM golang:1.18 as builder
RUN mkdir -p /app
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN GOOS=linux go build ./app.go

FROM scratch
WORKDIR /app
COPY --from=builder /app/app .
CMD ["/app/app"]