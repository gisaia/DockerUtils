package io.arlas;

import io.arlas.client.ElasticClient;
import io.arlas.client.ElasticClientFactory;

import java.io.IOException;

public class App {

    public static void main(String[] args) {

        ElasticClient client = null;
        try {
            client = ElasticClientFactory.getElasticClient();
            client.printElasticClusterInfo();
            client.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(client != null) {
                try {
                    client.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("Disconnected");
            try {
                Thread.sleep(600l*1000l);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
