package io.arlas.client;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthRequest;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.client.indices.GetIndexResponse;
import org.elasticsearch.cluster.health.ClusterIndexHealth;

import java.io.IOException;
import java.util.Arrays;
import java.util.Comparator;

public class ElasticRESTClient extends ElasticClient {

    RestHighLevelClient client;

    public ElasticRESTClient() {
        client = getRESTClient();
    }

    @Override
    public void printElasticClusterInfo() throws IOException {
        ClusterHealthResponse healths = client.cluster().health(new ClusterHealthRequest(), RequestOptions.DEFAULT);
        System.out.println("CLUSTER : ");
        System.out.println("  - name : " + healths.getClusterName());
        System.out.println("  - nb data nodes : " + healths.getNumberOfDataNodes());
        System.out.println("  - nb nodes : " + healths.getNumberOfNodes());
        System.out.println("  - nb indices : " + healths.getIndices().size());

        System.out.println("CLUSTER INDICES : ");
        healths.getIndices().values().stream()
                .filter(health -> !health.getIndex().startsWith("."))
                .sorted(Comparator.comparing(ClusterIndexHealth::getIndex))
                .forEach(health -> {
                    System.out.println("  - " + health.getIndex() + " (shards=" + health.getNumberOfShards() + "/replicas=" + health.getNumberOfReplicas() + "/status=" + health.getStatus() + ")");
                });

        System.out.println("CLUSTER SYSTEM INDICES : ");
        healths.getIndices().values().stream()
                .filter(health -> health.getIndex().startsWith("."))
                .sorted(Comparator.comparing(ClusterIndexHealth::getIndex))
                .forEach(health -> {
                    System.out.println("  - " + health.getIndex() + " (shards=" + health.getNumberOfShards() + "/replicas=" + health.getNumberOfReplicas() + "/status=" + health.getStatus() + ")");
                });

        GetIndexRequest request = new GetIndexRequest("*");
        GetIndexResponse getIndexResponse = client.indices().get(request, RequestOptions.DEFAULT);
        System.out.println("USER INDICES : ");
        Arrays.asList(getIndexResponse.getIndices()).stream()
                .filter(index -> !index.startsWith("."))
                .forEach(index -> System.out.println("  - " + index));
        System.out.println("USER SYSTEM INDICES : ");
        Arrays.asList(getIndexResponse.getIndices()).stream()
                .filter(index -> index.startsWith("."))
                .forEach(index -> System.out.println("  - " + index));
    }

    @Override
    public void close() throws IOException {
        client.close();
    }

    private RestHighLevelClient getRESTClient() {
        boolean enableSSL = getEnvVariableValue("ARLAS_ELASTIC_ENABLE_SSL", "false").equals("true");
        String scheme = enableSSL?"https":"http";

        RestClientBuilder builder = RestClient.builder(
                getElasticNodes().stream().map(pair -> new HttpHost(pair.getKey(), pair.getRight(), scheme))
                        .toArray(HttpHost[]::new));

        String credentials = getEnvVariableValue("ARLAS_ELASTIC_CREDENTIALS", null);
        if(credentials != null) {
            final CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
            credentialsProvider.setCredentials(AuthScope.ANY,
                    new UsernamePasswordCredentials(credentials.split(":")[0], credentials.split(":")[1]));
            builder.setHttpClientConfigCallback(new RestClientBuilder.HttpClientConfigCallback() {
                @Override
                public HttpAsyncClientBuilder customizeHttpClient(
                        HttpAsyncClientBuilder httpClientBuilder) {
                    return httpClientBuilder
                            .setDefaultCredentialsProvider(credentialsProvider);
                }
            });
        }

        return new RestHighLevelClient(builder);
    }

}
