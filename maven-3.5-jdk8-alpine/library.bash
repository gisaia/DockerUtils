Maven::Docker_build () {
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/maven-3.5-jdk8-alpine/Docker"
  local REPOSITORY_NAME="gisaia/maven-3.5-jdk8-alpine"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/maven-3.5-jdk8-alpine/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::build

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}

Maven::Docker_publish () {  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/maven-3.5-jdk8-alpine/Docker"
  local REPOSITORY_NAME="gisaia/maven-3.5-jdk8-alpine"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/maven-3.5-jdk8-alpine/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::publish

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}