#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$(dirname "$(dirname "$SCRIPT_DIRECTORY")")"

source "$PROJECT_ROOT_DIRECTORY/common/library.bash"
source "$PROJECT_ROOT_DIRECTORY/swagger-codegen/library.bash"

SWAGGER_CODEGEN_VERSION="$(basename "$SCRIPT_DIRECTORY")"

Swagger_CodeGen::Docker_publish "$SWAGGER_CODEGEN_VERSION"
