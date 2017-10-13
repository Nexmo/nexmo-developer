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
package com.nexmo.quickstart;

import java.util.logging.ConsoleHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class contains utility methods designed to be statically imported into
 * the quickstart main classes.
 */
public class Util {
    /**
     * Configures logging if the QUICKSTART_DEBUG environment variable is set.
     */
    public static void configureLogging() {
        String value = System.getenv("QUICKSTART_DEBUG");
        if (value != null) {
            Handler handler = new ConsoleHandler();
            handler.setLevel(Level.FINEST);
            Logger logger = Logger.getLogger("com.nexmo");
            logger.setLevel(Level.FINEST);
            logger.addHandler(handler);
        }
    }

    /**
     * Look up a required environment variable and throw an
     * IllegalArgumentException if the variable is not set.
     *
     * @param key the name of the environment variable
     * @return the value
     */
    public static String envVar(String key) {
        String value = System.getenv(key);
        if (value == null) {
            throw new IllegalArgumentException("You must provide the " + key + " environment variable!");
        }
        return value;
    }

    /**
     * Look up a required environment variable and throw an
     * IllegalArgumentException if the value is not one of "0", "1", "true", "false", "on" or "off".
     *
     * @param key the name of the environment variable
     * @return the value
     */
    public static boolean booleanEnvVar(String key) {
        String stringValue = System.getenv(key);
        if (stringValue == null) {
            return false;
        } else {
            stringValue = stringValue.trim().toLowerCase();
        }

        if ("1".equals(stringValue) || "true".equals(stringValue) || "on".equals(stringValue)) {
            return true;
        } else if ("0".equals(stringValue) || "false".equals(stringValue) || "off".equals(stringValue)) {
            return false;
        } else {
            throw new IllegalArgumentException(
                    String.format("The value \"%s\" could not be converted to a boolean value", stringValue));
        }
    }
}
