package com.nexmo.quickstart.voice;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.JWTAuthMethod;
import com.nexmo.client.voice.CallInfoPage;
import com.nexmo.client.voice.CallsFilter;

import java.nio.file.FileSystems;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class RetrieveInfoForAllCalls {
    public static void main(String... args) throws Exception {
        configureLogging();

        final String NEXMO_APPLICATION_ID = envVar("APPLICATION_ID");
        final String NEXMO_PRIVATE_KEY = envVar("PRIVATE_KEY");

        AuthMethod auth = new JWTAuthMethod(NEXMO_APPLICATION_ID, FileSystems.getDefault().getPath(NEXMO_PRIVATE_KEY));
        NexmoClient nexmo = new NexmoClient(auth);

        CallsFilter filter = new CallsFilter();
        filter.setDateStart(getYesterdaysDate());
        filter.setDateEnd(getTodaysDate());

        CallInfoPage calls = nexmo.getVoiceClient().listCalls(filter);

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
