#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

if [[ -v DEBUG ]] && [[ "$DEBUG" == true ]]; then
  set -x
fi


################################################################################
# Group & user ID which will be used to perform code generation
# If not specified, defaults to current group/user
################################################################################
GROUP_ID="${GROUP_ID:-"$(id -g)"}"
USER_ID="${USER_ID:-"$(id -u)"}"


################################################################################
# Make sure group exists
################################################################################
if ! getent group "$GROUP_ID" &>/dev/null; then
  addgroup -g "$GROUP_ID" container
  echo "$?"
fi


GROUP_NAME="$(getent group "$GROUP_ID" | cut -d : -f 1)"


################################################################################
# Make sure user exists
################################################################################
if ! getent passwd "$USER_ID" &>/dev/null; then
  adduser -D -G "$GROUP_NAME" -s /bin/bash -u "$USER_ID" container
fi


USER_NAME="$(getent passwd "$USER_ID" | cut -d : -f 1)"
