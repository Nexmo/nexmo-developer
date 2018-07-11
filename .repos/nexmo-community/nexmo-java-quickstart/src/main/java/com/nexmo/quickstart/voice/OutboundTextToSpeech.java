package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.voice.Call;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class OutboundTextToSpeech {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        String NEXMO_APPLICATION_PRIVATE_KEY = envVar("PRIVATE_KEY");

        NexmoClient client = new NexmoClient(
                new JWTAuthMethod(
                        NEXMO_APPLICATION_ID,
                        FileSystems.getDefault().getPath(NEXMO_APPLICATION_PRIVATE_KEY)
                )
        );

        String NEXMO_NUMBER = envVar("NEXMO_NUMBER");
        String TO_NUMBER = envVar("TO_NUMBER");
        String ANSWER_URL = "https://developer.nexmo.com/ncco/tts.json";

        client.getVoiceClient().createCall(
                new Call(TO_NUMBER, NEXMO_NUMBER, ANSWER_URL)
        );
    }
}
