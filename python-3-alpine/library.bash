Python::Docker_build () {
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/python-3-alpine/Docker"
  local REPOSITORY_NAME="gisaia/python-3-alpine"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/python-3-alpine/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::build

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}

Python::Docker_publish () {  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/python-3-alpine/Docker"
  local REPOSITORY_NAME="gisaia/python-3-alpine"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/python-3-alpine/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::publish

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}