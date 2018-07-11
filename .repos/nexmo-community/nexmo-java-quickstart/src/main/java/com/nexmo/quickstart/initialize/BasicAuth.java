package com.nexmo.quickstart.initialize;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.TokenAuthMethod;

import static com.nexmo.quickstart.Util.envVar;


/**
 * Example of configuring a NexmoClient with an API secret.
 */
public class BasicAuth {
    public static void main(String[] argv) throws Exception {
        String NEXMO_API_KEY = envVar("API_KEY");
        String NEXMO_API_SECRET = envVar("API_SECRET");

        AuthMethod auth = new TokenAuthMethod(NEXMO_API_KEY, NEXMO_API_SECRET);
        NexmoClient client = new NexmoClient(auth);
    }
}
