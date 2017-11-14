/*
 * Copyright (c) 2011-2017 Nexmo Inc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.nexmo.quickstart.voice;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nexmo.client.voice.ncco.Ncco;
import com.nexmo.client.voice.ncco.RecordNcco;
import com.nexmo.client.voice.ncco.TalkNcco;
import spark.Request;
import spark.Route;

import java.io.IOException;

import static spark.Spark.*;

public class RecordCall {
    public static void main(String[] args) throws Exception {
        ObjectMapper nccoMapper = new ObjectMapper();

        /*
         * Route to answer incoming calls with an NCCO response.
         */
        Route answerRoute = (req, res) -> {
            String recordingUrl = String.format("%s://%s/webhooks/recording", req.scheme(), req.host());

            TalkNcco intro = new TalkNcco("Please leave a message after the tone, then press pound.");
            RecordNcco record = new RecordNcco();
            record.setEndOnKey('#');
            record.setBeepStart(true);
            record.setEventUrl(recordingUrl);
            TalkNcco thanks = new TalkNcco("Thank you for your message.");
            Ncco[] nccos = new Ncco[]{intro, record, thanks};
            res.type("application/json");
            return nccoMapper.writer().writeValueAsString(nccos);
        };

        /**
         * Webhook Route which prints out the recording URL it is given to stdout.
         */
        Route recordingWebhookRoute = (req, res) -> {
            System.out.printf("Recording URL = %s\n", extractRecordingUrl(req));

            res.status(204);
            return "";
        };

        port(3000);

        get("/webhooks/answer", answerRoute);
        post("/webhooks/answer", answerRoute);

        get("/webhooks/recording", recordingWebhookRoute);
        post("/webhooks/recording", recordingWebhookRoute);
    }

    /**
     * Extract the provided recording_url either from the request params, or JSON body.
     */
    private static String extractRecordingUrl(Request req) throws IOException {
        String recordingUrl = req.queryParams("recording_url");
        if ("GET".equals(req.requestMethod())) {
            return recordingUrl;
        } else {
            if (recordingUrl != null) {
                return recordingUrl;
            } else {
                RecordingPayload payload = RecordingPayload.fromJson(req.bodyAsBytes());
                return payload.getRecordingUrl();
            }
        }
    }
}
