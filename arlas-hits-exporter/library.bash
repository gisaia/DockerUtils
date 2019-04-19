ArlasExporter::Docker_build () {
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/arlas-hits-exporter/Docker"
  local REPOSITORY_NAME="gisaia/arlas-hits-exporter"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/arlas-hits-exporter/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::build

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}

ArlasExporter::Docker_publish () {  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/arlas-hits-exporter/Docker"
  local REPOSITORY_NAME="gisaia/arlas-hits-exporter"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/arlas-hits-exporter/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::publish

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}