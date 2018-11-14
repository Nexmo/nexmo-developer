package com.nexmo.quickstart.voice;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nexmo.client.NexmoClient;
import com.nexmo.client.voice.CallInfoPage;
import com.nexmo.client.voice.CallsFilter;

import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class RetrieveInfoForAllCalls {
    public static void main(String... args) throws Exception {
        configureLogging();

        final String NEXMO_APPLICATION_ID = envVar("NEXMO_APPLICATION_ID");
        final String NEXMO_PRIVATE_KEY_PATH = envVar("NEXMO_PRIVATE_KEY_PATH");

        NexmoClient client = new NexmoClient.Builder()
                .applicationId(NEXMO_APPLICATION_ID)
                .privateKeyPath(NEXMO_PRIVATE_KEY_PATH)
                .build();

        CallsFilter filter = new CallsFilter.Builder()
                .dateStart(getYesterdaysDate())
                .dateEnd(getTodaysDate())
                .build();

        CallInfoPage calls = client.getVoiceClient().listCalls(filter);

        // com.fasterxml.jackson.databind.ObjectMapper;
        System.out.println(new ObjectMapper().writer().writeValueAsString(calls));
    }

    private static Date getTodaysDate() {
        return Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTime();
    }

    private static Date getYesterdaysDate() {
        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
        calendar.add(Calendar.DATE, -1);
        return calendar.getTime();
    }
}
