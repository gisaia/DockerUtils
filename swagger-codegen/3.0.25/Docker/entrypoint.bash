#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

if [[ -v DEBUG ]] && [[ "$DEBUG" == true ]]; then
  set -x
fi


################################################################################
# If user/group ID specified, ensure a user/group with correct ID is available
################################################################################
source /opt/configure_user_and_group.bash


################################################################################
# Define command to be called
################################################################################
COMMAND="java \
  -jar /opt/swagger/swagger-codegen-cli.jar \
    generate \
    -i /input/api.json \
    -o /output/"


################################################################################
# If a configuration file is provided, use it
################################################################################
if [[ -f /input/config.json ]]; then
  COMMAND+=" -c /input/config.json"
fi


################################################################################
# Pass down additional arguments
################################################################################
for ARGUMENT in "${@}"; do
  COMMAND+=" '$ARGUMENT'"
done


################################################################################
# Perform code generation, with correct user ID & group ID
# Pass any command line argument as additional arguments
# Variable `USER_NAME` is set by `/opt/configure_user_and_group.bash`
################################################################################
su - "$USER_NAME" -c "$COMMAND"
