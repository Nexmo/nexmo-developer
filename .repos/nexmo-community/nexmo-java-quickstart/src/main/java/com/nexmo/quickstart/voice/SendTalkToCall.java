package com.nexmo.quickstart.voice;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.voice.Call;
import com.nexmo.client.voice.CallEvent;
import com.nexmo.client.voice.VoiceName;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class SendTalkToCall {
    public static void main(String[] args) throws Exception {
        configureLogging();

        final String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        final String NEXMO_PRIVATE_KEY = envVar("PRIVATE_KEY");

        AuthMethod auth = new JWTAuthMethod(NEXMO_APPLICATION_ID, FileSystems.getDefault().getPath(NEXMO_PRIVATE_KEY));
        NexmoClient nexmo = new NexmoClient(auth);

        final String NEXMO_NUMBER = envVar("NEXMO_NUMBER");
        final String TO_NUMBER = envVar("TO_NUMBER");
        CallEvent call = nexmo.getVoiceClient().createCall(new Call(
                TO_NUMBER,
                NEXMO_NUMBER,
                "https://gist.githubusercontent.com/ChrisGuzman/d6add5b23a8cf913dcdc5a8eabc223ef/raw/a1eb52e0ce2d3cef98bab14d27f3adcdff2af881/long_talk.json"
        ));

        Thread.sleep(20000);

        final String UUID = call.getUuid();
        final String TEXT = "Hello World! Would you like to know more? I bet you would";
        nexmo.getVoiceClient().startTalk(UUID, TEXT, VoiceName.KIMBERLY, 0);

        Thread.sleep(5000);
        nexmo.getVoiceClient().stopTalk(UUID);
    }
}
