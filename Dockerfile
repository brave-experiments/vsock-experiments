FROM public.ecr.aws/docker/library/rust:1.72.0-slim-bookworm as rust-builder

WORKDIR /src/

COPY ./Cargo.toml ./Cargo.lock ./
COPY ./src src/

RUN cargo build --locked --release

FROM public.ecr.aws/docker/library/debian:12.1-slim

RUN apt update && apt install -y procps

COPY start.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start.sh

COPY --from=rust-builder /src/target/release/vsock-experiment /usr/local/bin/

CMD ["/usr/local/bin/start.sh"]
