package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.voice.Call;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class OutboundTextToSpeechWithEventUrl {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String APPLICATION_ID = envVar("APPLICATION_ID");
        String PRIVATE_KEY = envVar("PRIVATE_KEY");
        String FROM_NUMBER = envVar("FROM_NUMBER");
        String TO_NUMBER = envVar("TO_NUMBER");
        String EVENT_URL = envVar("EVENT_URL");

        AuthMethod auth = new JWTAuthMethod(
                APPLICATION_ID,
                FileSystems.getDefault().getPath(PRIVATE_KEY)
        );
        NexmoClient client = new NexmoClient(auth);
        Call call = new Call(
                TO_NUMBER,
                FROM_NUMBER,
                "https://nexmo-community.github.io/ncco-examples/first_call_talk.json"
        );
        call.setEventUrl(EVENT_URL);
        client.getVoiceClient().createCall(call);
    }
}
