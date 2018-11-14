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
package com.nexmo.quickstart.numbers;

import com.nexmo.client.NexmoClient;
import com.nexmo.client.numbers.*;

import static com.nexmo.quickstart.Util.configureLogging;
import static com.nexmo.quickstart.Util.envVar;

/**
 * List the numbers available in the UK, buy the first one, and then cancel it.
 */
public class NumberLifecycle {
    public static void main(String[] args) throws Exception {
        configureLogging();

        String NEXMO_API_KEY = envVar("NEXMO_API_KEY");
        String NEXMO_API_SECRET = envVar("NEXMO_API_SECRET");

        String country = "GB";


        NumbersClient client = new NexmoClient.Builder().apiKey(NEXMO_API_KEY).apiSecret(NEXMO_API_SECRET).build().getNumbersClient();
        SearchNumbersResponse response = client.searchNumbers(country);

        if (response.getCount() == 0) {
            System.out.printf("\uD83D\uDE1E No numbers available in %s\n", country);
            System.exit(1);
        } else {
            AvailableNumber availableNumber = response.getNumbers()[0];
            System.out.printf("❤️ Buying number: %s\n", availableNumber.getMsisdn());

            client.buyNumber(country, availableNumber.getMsisdn());
            System.out.println("❤️ Bought number.");

            Thread.currentThread().sleep(1000);
            ListNumbersFilter filter = new ListNumbersFilter();
            filter.setPattern(availableNumber.getMsisdn());
            filter.setSearchPattern(SearchPattern.STARTS_WITH);
            OwnedNumber[] numbers = client.listNumbers(filter).getNumbers();
            if (numbers.length == 0) {
                System.out.println("\uD83D\uDE1E Purchased number not found in list!");
                System.exit(1);
            } else {
                System.out.println("❤️ Number found in list!");
            }

            System.out.println("❤️ Cancelling number");
            client.cancelNumber(country, availableNumber.getMsisdn());
            System.out.println("❤️ Number cancelled!");

            numbers = client.listNumbers(filter).getNumbers();
            if (numbers.length == 0) {
                System.out.println("❤️ Purchased number not found in list!");
            } else {
                System.out.println("\uD83D\uDE1E Number found in list!");
                System.exit(1);
            }

            System.out.print("❤️ Success!");
        }
    }
}
