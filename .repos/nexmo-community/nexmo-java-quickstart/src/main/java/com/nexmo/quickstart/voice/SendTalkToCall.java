package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.voice.Call;
import com.nexmo.client.voice.CallEvent;
import com.nexmo.client.voice.VoiceName;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class SendTalkToCall {
    public static void main(String[] args) throws Exception {
        configureLogging();

        final String NEXMO_APPLICATION_ID = envVar("NEXMO_APPLICATION_ID");
        final String NEXMO_PRIVATE_KEY_PATH = envVar("NEXMO_PRIVATE_KEY_PATH");

        NexmoClient client = new NexmoClient.Builder()
                .applicationId(NEXMO_APPLICATION_ID)
                .privateKeyPath(NEXMO_PRIVATE_KEY_PATH)
                .build();

        final String NEXMO_NUMBER = envVar("NEXMO_NUMBER");
        final String TO_NUMBER = envVar("TO_NUMBER");
        CallEvent call = client
                .getVoiceClient()
                .createCall(new Call(TO_NUMBER, NEXMO_NUMBER, "http://s3.sammachin.com/silent_loop.json"));

        Thread.sleep(5000);

        final String UUID = call.getUuid();
        final String TEXT = "Hello World! Would you like to know more? I bet you would";
        client.getVoiceClient().startTalk(UUID, TEXT, VoiceName.KIMBERLY, 0);

        Thread.sleep(5000);
        client.getVoiceClient().stopTalk(UUID);
    }
}
