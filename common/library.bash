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