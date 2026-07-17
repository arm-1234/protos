# protos

Shared API contracts for the Merchant Store platform: protobuf definitions plus generated Go code (gRPC, HTTP, validation, errors).

## Module

```go
import catalogV1 "github.com/arm-1234/protos/catalog/v1"
```

Go module: `github.com/arm-1234/protos`

## Generate code

Requires `protoc` and the plugins installed via:

```bash
make init
make api
```

Regenerate a single domain:

```bash
make api svc_dir=catalog
```

## Services

| Domain   | Package                         |
|----------|---------------------------------|
| identity | `github.com/arm-1234/protos/identity/v1` |
| merchant | `github.com/arm-1234/protos/merchant/v1` |
| catalog  | `github.com/arm-1234/protos/catalog/v1`  |
| order    | `github.com/arm-1234/protos/order/v1`    |
| payment  | `github.com/arm-1234/protos/payment/v1`  |
| review   | `github.com/arm-1234/protos/review/v1`    |

## Backend usage

In your backend `go.mod`:

```go
require github.com/arm-1234/protos v0.1.0
```

For local development against a checkout of this repo:

```go
replace github.com/arm-1234/protos => ../protos
```
