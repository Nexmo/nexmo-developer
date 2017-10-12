package com.nexmo.quickstart.sms;

import static spark.Spark.*;

import static com.nexmo.quickstart.Util.configureLogging;

public class ReceiveDLR {

    public static void main(String[] args) throws Exception {
        configureLogging();

        port(8080);

        get("/receipt", (req, res) -> {
            for (String param : req.queryParams()) {
                System.out.printf("%s: %s\n", param, req.queryParams(param));
            }
            return "OK";
        });

        post("/receipt", (req, res) -> {
            // The body will be JSON - use the JSON parser of your choice to extract values:
            System.out.println(req.body());
            return "OK";
        });
    }
}
