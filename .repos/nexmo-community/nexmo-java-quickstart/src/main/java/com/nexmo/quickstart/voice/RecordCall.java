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

import com.nexmo.client.incoming.RecordEvent;
import com.nexmo.client.voice.ncco.ConnectAction;
import com.nexmo.client.voice.ncco.Ncco;
import com.nexmo.client.voice.ncco.PhoneEndpoint;
import com.nexmo.client.voice.ncco.RecordAction;
import spark.Route;
import spark.Spark;

import static com.nexmo.quickstart.Util.envVar;

public class RecordCall {
    public static void main(String[] args) {
        final String TO_NUMBER = envVar("TO_NUMBER");
        final String NEXMO_NUMBER = envVar("NEXMO_NUMBER");

        /*
         * Route to answer and connect incoming calls with recording.
         */
        Route answerRoute = (req, res) -> {
            String recordingUrl = String.format("%s://%s/webhooks/recordings", req.scheme(), req.host());

            RecordAction record = new RecordAction.Builder().eventUrl(recordingUrl).build();

            ConnectAction connect = new ConnectAction.Builder(new PhoneEndpoint.Builder(TO_NUMBER).build())
                    .from(NEXMO_NUMBER)
                    .build();

            res.type("application/json");

            return new Ncco(record, connect).toJson();
        };

        /*
         * Route which prints out the recording URL it is given to stdout.
         */
        Route recordingRoute = (req, res) -> {
            System.out.println(RecordEvent.fromJson(req.body()).getUrl());

            res.status(204);
            return "";
        };

        Spark.port(3000);
        Spark.get("/webhooks/answer", answerRoute);
        Spark.post("/webhooks/recordings", recordingRoute);
    }
}
