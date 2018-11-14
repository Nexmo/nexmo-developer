package com.nexmo.quickstart.initialize;

import com.nexmo.client.NexmoClient;

import static com.nexmo.quickstart.Util.envVar;

/**
 * Example of configuring a NexmoClient with an API secret.
 */
public class BasicAuth {
    public static void main(String[] argv) throws Exception {
        String NEXMO_API_KEY = envVar("NEXMO_API_KEY");
        String NEXMO_API_SECRET = envVar("NEXMO_API_SECRET");

        NexmoClient client = new NexmoClient.Builder().apiKey(NEXMO_API_KEY).apiSecret(NEXMO_API_SECRET).build();
    }
}
