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
package com.nexmo.quickstart.insight;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.TokenAuthMethod;
import com.nexmo.client.insight.RoamingDetails;
import com.nexmo.client.insight.advanced.AdvancedInsightResponse;

import static com.nexmo.quickstart.Util.*;

public class AdvancedInsight {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String API_KEY = envVar("API_KEY");
        String API_SECRET = envVar("API_SECRET");
        String TO_NUMBER = envVar("TO_NUMBER");
        boolean CNAM = booleanEnvVar("CNAM");

        AuthMethod auth = new TokenAuthMethod(API_KEY, API_SECRET);
        NexmoClient client = new NexmoClient(auth);

        AdvancedInsightResponse response = client.getInsightClient().getAdvancedNumberInsight(
                TO_NUMBER, null, null, CNAM);
        System.out.println("BASIC INFO:");
        System.out.println("International format: " + response.getInternationalFormatNumber());
        System.out.println("National format: " + response.getNationalFormatNumber());
        System.out.println("Country: " + response.getCountryName() +
                " (" + response.getCountryCodeIso3() +
                ", +" + response.getCountryPrefix() +
                ")");
        System.out.println();
        System.out.println("STANDARD INFO:");
        System.out.println("Current carrier: " + response.getCurrentCarrier().getName());
        System.out.println("Original carrier: " + response.getOriginalCarrier().getName());

        System.out.println();
        System.out.println("ADVANCED INFO:");
        System.out.println("Validity: " + response.getValidNumber());
        System.out.println("Reachability: " + response.getReachability());
        System.out.println("Ported status: " + response.getPorted());
        RoamingDetails roaming = response.getRoaming();
        if (roaming == null) {
            System.out.println("- No Roaming Info -");
        } else {
            System.out.println("Roaming status: " + roaming.getStatus());
            if (response.getRoaming().getStatus() == RoamingDetails.RoamingStatus.ROAMING) {
                System.out.print("    Currently roaming in: " + roaming.getRoamingCountryCode());
                System.out.println(" on the network " + roaming.getRoamingNetworkName());
            }
        }

        if (CNAM) {
            System.out.println();
            System.out.println("CNAM INFO:");
            System.out.println("Caller Name: " + response.getCallerName());
            System.out.println("Caller Type: " + response.getCallerType());
            System.out.println("First, Last: " + response.getFirstName() + ", " + response.getLastName());
        } else {
            System.out.println("- No CNAM Info Requested -");
        }
    }
}
