package com.nexmo.quickstart.initialize;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.envVar;

/**
 * Example of configuring a NexmoClient with Application (JWT) authentication credentials.
 */
public class ApplicationAuth {
    public static void main(String[] argv) throws Exception {

        String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        String NEXMO_APPLICATION_PRIVATE_KEY_PATH = envVar("PRIVATE_KEY");

        AuthMethod auth = new JWTAuthMethod(
                NEXMO_APPLICATION_ID,
                FileSystems.getDefault().getPath(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
        );
        NexmoClient client = new NexmoClient(auth);
    }
}
