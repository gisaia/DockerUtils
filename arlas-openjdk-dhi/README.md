# ARLAS-docker-parent-java

This project is used to release a Docker base image for java ARLAS project which includes the APM jar.

In order to release a new version, just remove the old jar and put the new one, then run the `release.sh` script.

Example of docker compose healthcheck:
```yaml
    healthcheck:
      test: ["CMD","java","HttpHealthcheck.java","http://localhost:9999/admin/healthcheck"]
      interval: 5s
      timeout: 10s
      retries: 3

```