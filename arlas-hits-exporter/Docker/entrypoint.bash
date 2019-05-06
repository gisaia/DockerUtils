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
COMMAND="bash /opt/export_data.bash --output=/output"


################################################################################
# Pass down additional arguments
################################################################################
for ARGUMENT in "${@}"; do
  COMMAND+=" '$ARGUMENT'"
done

################################################################################
# Perform export_data command, with correct user ID & group ID
# Pass any command line argument as additional arguments
# Variable `USER_NAME` is set by `/opt/configure_user_and_group.bash`
################################################################################
su - "$USER_NAME" -c "$COMMAND"