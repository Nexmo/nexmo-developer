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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nexmo.client.voice.ncco.InputNcco;
import com.nexmo.client.voice.ncco.Ncco;
import com.nexmo.client.voice.ncco.TalkNcco;
import spark.Route;
import spark.Spark;

import java.io.IOException;

public class DtmfInput {
    public static void main(String[] args) {
        /*
         * Route to answer incoming calls.
         */
        Route answerRoute = (req, res) -> {
            TalkNcco intro = new TalkNcco("Hello. Please press any key to continue.");

            InputNcco input = new InputNcco();
            input.setEventUrl(String.format("%s://%s/webhooks/dtmf", req.scheme(), req.host()));
            input.setMaxDigits(1);

            Ncco[] nccos = new Ncco[]{intro, input};

            res.type("application/json");

            // com.fasterxml.jackson.databind.ObjectMapper;
            return new ObjectMapper().writer().writeValueAsString(nccos);
        };

        /*
         * Route which returns NCCO saying which DTMF code was received.
         */
        Route inputRoute = (req, res) -> {
            DtmfPayload dtmfPayload = DtmfPayload.fromJson(req.body());

            TalkNcco response = new TalkNcco(String.format("You pressed %s, Goodbye.", dtmfPayload.getDtmf()));
            Ncco[] nccos = new Ncco[]{response};

            res.type("application/json");

            // com.fasterxml.jackson.databind.ObjectMapper;
            return new ObjectMapper().writer().writeValueAsString(nccos);
        };

        Spark.port(3000);
        Spark.get("/webhooks/answer", answerRoute);
        Spark.post("/webhooks/dtmf", inputRoute);
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class DtmfPayload {
        private String dtmf;

        @JsonProperty("dtmf")
        String getDtmf() {
            return this.dtmf;
        }

        public static DtmfPayload fromJson(String json) throws IOException {
            return new ObjectMapper().readValue(json, DtmfPayload.class);
        }
    }
}
