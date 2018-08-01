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

        final String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        final String NEXMO_PRIVATE_KEY = envVar("PRIVATE_KEY");

        AuthMethod auth = new JWTAuthMethod(NEXMO_APPLICATION_ID, FileSystems.getDefault().getPath(NEXMO_PRIVATE_KEY));
        NexmoClient nexmo = new NexmoClient(auth);

        final String NEXMO_NUMBER = envVar("NEXMO_NUMBER");
        final String TO_NUMBER = envVar("TO_NUMBER");
        final String ANSWER_URL = "https://developer.nexmo.com/ncco/tts.json";

        nexmo.getVoiceClient().createCall(new Call(TO_NUMBER, NEXMO_NUMBER, ANSWER_URL));
    }
}
