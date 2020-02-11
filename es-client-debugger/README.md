## Build
   
   ```bash
   docker build -t gisaia/es-client-debugger:7.3.2 .
   ```

## Publish
   
   ```bash
   docker push gisaia/es-client-debugger:7.3.2
   ```

## Run

   ```bash
   docker run --rm \
           -e ARLAS_ELASTIC_NODES="localhost:9343" \
           -e ARLAS_ELASTIC_ENABLE_SSL="true" \
           -e ARLAS_ELASTIC_CREDENTIALS="user:password" \
           -e ARLAS_ELASTIC_CLUSTER="cluster_name" \
           -e ARLAS_ELASTIC_SNIFFING="false" \
           -e ARLAS_ELASTIC_COMPRESS="true" \
           -e ARLAS_ELASTIC_CLIENT="TRANSPORT|REST" \
           gisaia/es-client-debugger:7.3.2
   ```