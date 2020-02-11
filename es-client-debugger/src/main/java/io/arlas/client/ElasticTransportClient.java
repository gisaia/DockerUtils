package io.arlas.client;

import org.apache.commons.lang3.tuple.Pair;
import org.elasticsearch.action.ActionFuture;
import org.elasticsearch.action.admin.cluster.health.ClusterHealthResponse;
import org.elasticsearch.action.admin.cluster.node.info.NodesInfoRequest;
import org.elasticsearch.action.admin.cluster.node.info.NodesInfoResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.cluster.health.ClusterIndexHealth;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.elasticsearch.xpack.client.PreBuiltXPackTransportClient;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Comparator;

public class ElasticTransportClient extends ElasticClient {

    private TransportClient client;

    public ElasticTransportClient() {
        try {
            client = getTransportClient();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }

    private TransportClient getTransportClient() throws UnknownHostException {
        TransportClient transportClient;
        if (getEnvVariableValue("ARLAS_ELASTIC_ENABLE_SSL", "false").equals("true")) {
            // disable JVM default policies of caching positive hostname resolutions indefinitely
            // because the Elastic load balancer can change IP addresses
            java.security.Security.setProperty("networkaddress.cache.ttl", "60");
            // Instantiate a ElasticTransportClient and add the cluster to the list of addresses to connect to.
            // Only port 9343 (SSL-encrypted) is currently supported. The use of x-pack security features is required.
            transportClient = new PreBuiltXPackTransportClient(getSettings());
        } else {
            transportClient = new PreBuiltTransportClient(getSettings());
        }

        for (Pair<String, Integer> node : getElasticNodes()) {
            transportClient.addTransportAddress(new TransportAddress(InetAddress.getByName(node.getLeft()),
                    node.getRight()));
        }
        return transportClient;
    }

    public void printElasticClusterInfo() {

        ClusterHealthResponse healths = client.admin().cluster().prepareHealth().get();
        System.out.println("CLUSTER : ");
        System.out.println("  - name : " + healths.getClusterName());
        System.out.println("  - nb data nodes : " + healths.getNumberOfDataNodes());
        System.out.println("  - nb nodes : " + healths.getNumberOfNodes());

        NodesInfoRequest nodesInfoRequest = new NodesInfoRequest();
        nodesInfoRequest.clear().jvm(false).os(false).process(true);
        ActionFuture<NodesInfoResponse> nodesInfoResponseActionFuture = client.admin().cluster().nodesInfo(nodesInfoRequest);
        System.out.println("CLUSTER NODES : ");
        nodesInfoResponseActionFuture.actionGet().getNodes().stream().forEach(node -> {
            System.out.println("  - " + node.getHostname());
        });

        System.out.println("INDICES : ");
        healths.getIndices().values().stream()
                .filter(health -> !health.getIndex().startsWith("."))
                .sorted(Comparator.comparing(ClusterIndexHealth::getIndex))
                .forEach(health -> {
                    System.out.println("  - " + health.getIndex() + " (shards=" + health.getNumberOfShards() + "/replicas=" + health.getNumberOfReplicas() + "/status=" + health.getStatus() + ")");
                });

        System.out.println("SYSTEM INDICES : ");
        healths.getIndices().values().stream()
                .filter(health -> health.getIndex().startsWith("."))
                .sorted(Comparator.comparing(ClusterIndexHealth::getIndex))
                .forEach(health -> {
                    System.out.println("  - " + health.getIndex() + " (shards=" + health.getNumberOfShards() + "/replicas=" + health.getNumberOfReplicas() + "/status=" + health.getStatus() + ")");
                });
    }

    @Override
    public void close() {
        client.close();
    }

    private Settings getSettings() {
        Settings.Builder settings = Settings.builder()
                .put("cluster.name", getEnvVariableValue("ARLAS_ELASTIC_CLUSTER", "elasticsearch"))
                .put("request.headers.X-Found-Cluster", "${cluster.name}");

        String credentials = getEnvVariableValue("ARLAS_ELASTIC_CREDENTIALS", null);
        if(credentials != null)
            settings.put("xpack.security.user", credentials);
        if(getEnvVariableValue("ARLAS_ELASTIC_ENABLE_SSL", "false").equals("true"))
            settings.put("xpack.security.transport.ssl.enabled", true);
        if(getEnvVariableValue("ARLAS_ELASTIC_COMPRESS", "false").equals("true"))
            settings.put("transport.compress",true);
        if(getEnvVariableValue("ARLAS_ELASTIC_SNIFFING", "false").equals("true"))
            settings.put("client.transport.sniff",true);

        System.out.println("ElasticClient Settings : " + settings.build());
        return settings.build();
    }
}
