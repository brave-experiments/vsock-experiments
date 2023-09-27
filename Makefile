all: run

install-relay:
	cargo install vsock-relay

run-relay:
	vsock-relay -s 0.0.0.0:8080 -l 4:8080

build: src/*.rs Cargo.toml Dockerfile
	docker build -t vsock-experiment .
	nitro-cli build-enclave --docker-uri vsock-experiment:latest --output-file vsock-experiment.eif

run: build
	nitro-cli terminate-enclave --all
	nitro-cli run-enclave \
		--cpu-count 8 \
		--memory 512 \
		--enclave-cid 4 \
		--eif-path "vsock-experiment.eif" \
		--debug-mode \
		--attach-console

spam:
	ali -r 5000 -W 1200 -c 1200 --duration 10m http://localhost:8080/