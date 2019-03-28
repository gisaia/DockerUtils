#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

source "$PROJECT_ROOT_DIRECTORY/common/library.bash"
source "$PROJECT_ROOT_DIRECTORY/python-3-alpine/library.bash"

Python::Docker_publish