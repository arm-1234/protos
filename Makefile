GOHOSTOS:=$(shell go env GOHOSTOS)
GOPATH:=$(shell go env GOPATH)
VERSION=$(shell git describe --tags --always 2>/dev/null || echo dev)

# scope generation to a single service dir with: make api svc_dir=catalog
svc_dir := $(if $(svc_dir),$(svc_dir),.)

ifeq ($(GOHOSTOS), windows)
	PROTO_FILES=$(shell find . -name "*.proto" | grep -v third_party)
else
	PROTO_FILES=$(shell find $(svc_dir) -name "*.proto" | grep -v third_party)
endif

.PHONY: init
# install codegen toolchain
init:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/go-kratos/kratos/cmd/protoc-gen-go-http/v2@latest
	go install github.com/go-kratos/kratos/cmd/protoc-gen-go-errors/v2@latest
	go install github.com/envoyproxy/protoc-gen-validate@latest
	go install github.com/google/gnostic/cmd/protoc-gen-openapi@latest

.PHONY: api
# generate go/grpc/http/errors/validate/openapi for PROTO_FILES
api:
	protoc --proto_path=./ \
	       --proto_path=./third_party \
	       --go_out=paths=source_relative:./ \
	       --go-grpc_out=paths=source_relative:./ \
	       --go-http_out=paths=source_relative:./ \
	       --go-errors_out=paths=source_relative:./ \
	       --validate_out=paths=source_relative,lang=go:./ \
	       $(PROTO_FILES)

.PHONY: tidy
tidy:
	go mod tidy

.PHONY: help
help:
	@echo "make init            # install protoc plugins"
	@echo "make api             # generate all protos"
	@echo "make api svc_dir=X   # generate only service X (e.g. catalog)"

.DEFAULT_GOAL := help
