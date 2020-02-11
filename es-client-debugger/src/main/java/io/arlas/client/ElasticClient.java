package io.arlas.client;

import io.netty.util.internal.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.ImmutablePair;
import org.apache.commons.lang3.tuple.Pair;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public abstract class ElasticClient {

    public abstract void printElasticClusterInfo() throws IOException;
    public abstract void close() throws IOException;

    protected String getEnvVariableValue(String key, String defaultValue) {
        return Optional.ofNullable(System.getenv(key)).orElse(defaultValue);
    }

    protected List<Pair<String, Integer>> getElasticNodes() {
        List<Pair<String, Integer>> elasticNodes = new ArrayList<>();
        String esNodes = getEnvVariableValue("ARLAS_ELASTIC_NODES", null);
        if (!StringUtil.isNullOrEmpty(esNodes)) {
            String[] nodes = esNodes.split(",");
            for (String node : nodes) {
                String[] hostAndPort = node.split(":");
                if (hostAndPort.length == 2 && StringUtils.isNumeric(hostAndPort[1])) {
                    elasticNodes.add(new ImmutablePair<>(hostAndPort[0], Integer.parseInt(hostAndPort[1])));
                }
            }
        }
        return elasticNodes;
    }
}
