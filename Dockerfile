FROM rust:1.94 AS builder
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/telemt/telemt /telemt
WORKDIR /telemt

RUN cargo build --release

FROM ubuntu:24.04

COPY --from=builder /telemt/target/release/telemt /usr/local/bin/telemt
RUN chmod +x /usr/local/bin/telemt

WORKDIR /config

ENTRYPOINT ["/usr/local/bin/telemt"]

CMD ["telemt.toml"]
