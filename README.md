# vsock-experiment

Simple HTTP server that listens on a vsock interface and exits after 30 seconds.

## Steps

Ensure Rust toolchain and nitro-cli is installed.

1. Run `make install-relay` to install IPv4/vsock relay.
2. Run `make` to build and start the enclave image.
3. In another session, run `make run-relay`.
3. In yet another session, run `make spam` to send many requests via the relay.
