package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.voice.Call;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class OutboundTextToSpeechWithEventUrl {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String NEXMO_NUMBER = envVar("NEXMO_NUMBER");
        String TO_NUMBER = envVar("TO_NUMBER");
        String EVENT_URL = envVar("EVENT_URL");

        final String NEXMO_APPLICATION_ID = envVar("NEXMO_APPLICATION_ID");
        final String NEXMO_PRIVATE_KEY_PATH = envVar("NEXMO_PRIVATE_KEY_PATH");

        NexmoClient client = new NexmoClient.Builder()
                .applicationId(NEXMO_APPLICATION_ID)
                .privateKeyPath(NEXMO_PRIVATE_KEY_PATH)
                .build();

        Call call = new Call(
                TO_NUMBER,
                NEXMO_NUMBER,
                "https://nexmo-community.github.io/ncco-examples/first_call_talk.json"
        );
        call.setEventUrl(EVENT_URL);
        client.getVoiceClient().createCall(call);
    }
}
