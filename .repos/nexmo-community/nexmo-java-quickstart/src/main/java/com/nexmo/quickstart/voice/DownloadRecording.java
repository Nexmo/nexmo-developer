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

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.JWTAuthMethod;
import spark.Spark;

import java.nio.file.FileSystems;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

public class DownloadRecording {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String APPLICATION_ID = envVar("APPLICATION_ID");
        String PRIVATE_KEY = envVar("PRIVATE_KEY");

        NexmoClient nexmo = new NexmoClient(
                new JWTAuthMethod(APPLICATION_ID, FileSystems.getDefault().getPath(PRIVATE_KEY))
        );

        Spark.port(8080);

        /*
         * A recording webhook endpoint which automatically downloads the specified recording to a file in the
         * current working directory, called "downloaded_recording.mp3"
         */
        Spark.post("/recording", (req, res) -> {
            RecordingPayload payload = RecordingPayload.fromJson(req.bodyAsBytes());
            String RECORDING_URL = payload.getRecordingUrl();

            System.out.println("Downloading from " + payload.getRecordingUrl());
            nexmo.getVoiceClient()
                    .downloadRecording(RECORDING_URL)
                    .save("downloaded_recording.mp3");
            return "OK";
        });
    }
}
