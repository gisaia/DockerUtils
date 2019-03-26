Docker::build () {
  docker build \
    -t "$REPOSITORY_NAME":"${DOCKER_IMAGE_VERSION}" \
    -t "$REPOSITORY_NAME":latest \
    "$DOCKER_DIRECTORY"  
}

Docker::publish () {
  Docker::build

  if [[ -v SIMULATE ]] && [[ "$SIMULATE" == false ]]; then
    docker push "$REPOSITORY_NAME":"${DOCKER_IMAGE_VERSION}"
    docker push "$REPOSITORY_NAME":latest
  fi

  if ! ( [[ -v DELETE_IMAGE_LOCALLY ]] && [[ "$DELETE_IMAGE_LOCALLY" == false ]] ); then
    docker rmi \
      "$REPOSITORY_NAME":"${DOCKER_IMAGE_VERSION}" \
      "$REPOSITORY_NAME":latest
  fi
}

Swagger_CodeGen::Docker_build () {
  local SWAGGER_CODEGEN_VERSION="$1"
  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/Docker"
  local REPOSITORY_NAME="gisaia/swagger-codegen-$SWAGGER_CODEGEN_VERSION"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/swagger-codegen/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::build

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}

Swagger_CodeGen::Docker_publish () {
  local SWAGGER_CODEGEN_VERSION="$1"
  
  local DOCKER_DIRECTORY="$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/Docker"
  local REPOSITORY_NAME="gisaia/swagger-codegen-$SWAGGER_CODEGEN_VERSION"
  local DOCKER_IMAGE_VERSION="$(cat "$PROJECT_ROOT_DIRECTORY/swagger-codegen/$SWAGGER_CODEGEN_VERSION/docker_image_version")"

  cp "$PROJECT_ROOT_DIRECTORY/swagger-codegen/common/Docker/configure_user_and_group.bash" "$DOCKER_DIRECTORY/"

  Docker::publish

  rm -f "$DOCKER_DIRECTORY/configure_user_and_group.bash"
}
