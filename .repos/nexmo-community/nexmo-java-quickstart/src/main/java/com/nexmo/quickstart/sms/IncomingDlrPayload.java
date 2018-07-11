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
package com.nexmo.quickstart.sms;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

@JsonIgnoreProperties(ignoreUnknown = true)
public class IncomingDlrPayload {
    private String msisdn;
    private String to;
    private String networkCode;
    private String messageId;
    private String price;
    private String status;
    private String scts;
    private String errCode;
    private String messageTimestamp;

    public String getMsisdn() {
        return msisdn;
    }

    public String getTo() {
        return to;
    }

    @JsonProperty("network-code")
    public String getNetworkCode() {
        return networkCode;
    }

    public String getMessageId() {
        return messageId;
    }

    public String getPrice() {
        return price;
    }

    public String getStatus() {
        return status;
    }

    public String getScts() {
        return scts;
    }

    @JsonProperty("err-code")
    public String getErrCode() {
        return errCode;
    }

    @JsonProperty("messageTimestamp")
    public String getMessageTimestamp() {
        return messageTimestamp;
    }

    @Override
    public String toString() {
        return "IncomingDlrPayload{" +
                "msisdn='" + msisdn + '\'' +
                ", to='" + to + '\'' +
                ", networkCode='" + networkCode + '\'' +
                ", messageId='" + messageId + '\'' +
                ", price='" + price + '\'' +
                ", status='" + status + '\'' +
                ", scts='" + scts + '\'' +
                ", errCode='" + errCode + '\'' +
                ", messageTimestamp='" + messageTimestamp + '\'' +
                '}';
    }

    private static ObjectMapper objectMapper = new ObjectMapper();

    public static IncomingDlrPayload fromJson(byte[] bytes) throws IOException {
        return objectMapper.readValue(bytes, IncomingDlrPayload.class);
    }
}
