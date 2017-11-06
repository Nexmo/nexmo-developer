package com.nexmo.quickstart.initialize;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.auth.TokenAuthMethod;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.envVar;


/**
 * Example of configuring a NexmoClient with authentication for
 * both API secret and Application (JWT) authentication credentials.
 */
public class FullAuth {
    public static void main(String[] argv) throws Exception {
        String NEXMO_API_KEY = envVar("API_KEY");
        String NEXMO_API_SECRET = envVar("API_SECRET");
        String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        String NEXMO_APPLICATION_PRIVATE_KEY_PATH = envVar("PRIVATE_KEY");

        AuthMethod tokenAuth = new TokenAuthMethod(NEXMO_API_KEY, NEXMO_API_SECRET);
        AuthMethod applicationAuth = new JWTAuthMethod(
                NEXMO_APPLICATION_ID,
                FileSystems.getDefault().getPath(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
        );
        NexmoClient client = new NexmoClient(tokenAuth, applicationAuth);
    }
}
