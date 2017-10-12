package com.nexmo.quickstart.sms;

import static com.nexmo.quickstart.Util.configureLogging;
import static spark.Spark.*;

public class ReceiveSMS {

    public static void main(String[] args) throws Exception {
        configureLogging();

        port(8080);

        get("/incoming-sms", (req, res) -> {
            for (String param : req.queryParams()) {
                System.out.printf("%s: %s\n", param, req.queryParams(param));
            }
            return "OK";
        });

        post("/incoming-sms", (req, res) -> {
            // The body will be a String containing JSON
            // use the JSON parser of your choice to extract values:
            System.out.println(req.body());
            return "OK";
        });
    }
}
