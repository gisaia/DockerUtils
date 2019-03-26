#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

source "$PROJECT_ROOT_DIRECTORY/swagger-codegen/library.bash"

for SWAGGER_CODEGEN_VERSION in \
  2.2.3 \
  2.3.1 \
  ; do
  Swagger_CodeGen::Docker_build "$SWAGGER_CODEGEN_VERSION"
done
