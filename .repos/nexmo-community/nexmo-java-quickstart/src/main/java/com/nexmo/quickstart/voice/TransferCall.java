package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.voice.Call;
import com.nexmo.client.voice.CallEvent;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class TransferCall {
    public static void main(String... args) throws Exception {
        configureLogging();

        String APPLICATION_ID = envVar("APPLICATION_ID");
        String PRIVATE_KEY = envVar("PRIVATE_KEY");

        NexmoClient nexmo = new NexmoClient(
                new JWTAuthMethod(APPLICATION_ID, FileSystems.getDefault().getPath(PRIVATE_KEY))
        );

        String NEXMO_NUMBER = envVar("NEXMO_NUMBER");
        String TO_NUMBER = envVar("TO_NUMBER");
        /*
        Establish a call for testing purposes.
         */
        CallEvent call = nexmo.getVoiceClient().createCall(new Call(
                TO_NUMBER,
                NEXMO_NUMBER,
                "https://gist.githubusercontent.com/cr0wst/9417cac4c0d9004805a04aed403ae94a/raw/b95e3cd5126587d25986e0bf832eb33a7538394d/tts_long.json"
        ));

        /*
        Give them time to answer.
         */
        Thread.sleep(10000);

        String UUID = call.getUuid();
        String NCCO_URL = "https://developer.nexmo.com/ncco/tts.json";
        nexmo.getVoiceClient().transferCall(UUID, NCCO_URL);
    }
}
