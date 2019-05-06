#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

source "$PROJECT_ROOT_DIRECTORY/common/library.bash"
source "$PROJECT_ROOT_DIRECTORY/arlas-hits-exporter/library.bash"

ArlasExporter::Docker_build