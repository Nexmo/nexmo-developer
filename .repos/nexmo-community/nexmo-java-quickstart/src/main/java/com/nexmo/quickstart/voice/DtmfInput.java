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
import com.nexmo.client.voice.ncco.InputNcco;
import com.nexmo.client.voice.ncco.Ncco;
import com.nexmo.client.voice.ncco.TalkNcco;
import spark.Route;

import static spark.Spark.*;

public class DtmfInput {
    public static void main(String[] args) {

        /*
         * Route to answer incoming calls with an NCCO response.
         */
        Route incomingCall = (req, res) -> {
            TalkNcco intro = new TalkNcco("Hello please press any key to continue");

            String eventUrl = String.format("%s://%s/webhook/dtmf", req.scheme(), req.host());
            InputNcco input = new InputNcco();
            input.setEventUrl(eventUrl);

            Ncco[] nccos = new Ncco[]{intro, input,};

            res.type("application/json");
            return new ObjectMapper().writer().writeValueAsString(nccos);
        };

        /*
         * Webhook Route which returns NCCO saying which DTMF code was received.
         */
        Route answerRoute = (req, res) -> {
            String dtmf = req.queryParams("dtmf");
            TalkNcco intro = new TalkNcco(String.format("You pressed %s, Goodbye.", dtmf));

            Ncco[] nccos = new Ncco[]{intro};

            res.type("application/json");
            return new ObjectMapper().writer().writeValueAsString(nccos);
        };

        port(3000);
        get("/webhook/answer", incomingCall);
        post("/webhook/dtmf", answerRoute);
    }
}
