package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.voice.Call;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.*;

public class OutboundTextToSpeech {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        String NEXMO_APPLICATION_PRIVATE_KEY = envVar("PRIVATE_KEY");
        String NEXMO_NUMBER = envVar("FROM_NUMBER");
        String TO_NUMBER = envVar("TO_NUMBER");

        AuthMethod auth = new JWTAuthMethod(
                NEXMO_APPLICATION_ID,
                FileSystems.getDefault().getPath(NEXMO_APPLICATION_PRIVATE_KEY)
        );
        NexmoClient client = new NexmoClient(auth);
        client.getVoiceClient().createCall(new Call(
                TO_NUMBER,
                NEXMO_NUMBER,
                "https://developer.nexmo.com/ncco/tts.json"
        ));
    }
}
