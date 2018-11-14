package com.nexmo.quickstart.initialize;

import com.nexmo.client.NexmoClient;

import static com.nexmo.quickstart.Util.envVar;

/**
 * Example of configuring a NexmoClient with Application (JWT) authentication credentials.
 */
public class ApplicationAuthWithKeyPath {
    public static void main(String[] argv) throws Exception {

        String NEXMO_APPLICATION_ID = envVar("NEXMO_APPLICATION_ID");
        String NEXMO_APPLICATION_PRIVATE_KEY_PATH = envVar("NEXMO_PRIVATE_KEY_PATH");

        NexmoClient client = new NexmoClient.Builder()
                .applicationId(NEXMO_APPLICATION_ID)
                .privateKeyPath(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
                .build();
    }
}
