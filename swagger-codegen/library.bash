Swagger_CodeGen::Docker_build () {
  local SWAGGER_CODEGEN_VERSION="$1"
  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/Docker"
  local REPOSITORY_NAME="gisaia/swagger-codegen-$SWAGGER_CODEGEN_VERSION"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::build

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}

Swagger_CodeGen::Docker_publish () {
  local SWAGGER_CODEGEN_VERSION="$1"
  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/Docker"
  local REPOSITORY_NAME="gisaia/swagger-codegen-$SWAGGER_CODEGEN_VERSION"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::publish

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}
