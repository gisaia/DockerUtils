package io.arlas.client;

import java.util.Optional;

public class ElasticClientFactory {

    public static ElasticClient getElasticClient() {
        ElasticClient ret = null;
        String clientType = Optional.ofNullable(System.getenv("ARLAS_ELASTIC_CLIENT")).orElse("TRANSPORT");
        if(clientType.equals("TRANSPORT")) {
            ret = new ElasticTransportClient();
        } else if(clientType.equals("REST")) {
            ret = new ElasticRESTClient();
        }
        return ret;
    }
}
