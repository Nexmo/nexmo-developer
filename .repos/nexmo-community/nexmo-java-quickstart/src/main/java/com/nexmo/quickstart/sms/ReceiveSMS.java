package com.nexmo.quickstart.sms;

import java.util.logging.Logger;

import static com.nexmo.quickstart.Util.configureLogging;
import static spark.Spark.*;

public class ReceiveSMS {

    public static void main(String[] args) throws Exception {
        Logger logger = Logger.getLogger("com.nexmo.quickstart.ReceiveSMS");

        configureLogging();

        port(3000);

        get("/webhook/inbound-sms", (req, res) -> {
            logger.info("GET request received!");
            for (String param : req.queryParams()) {
                System.out.printf("%s: %s\n", param, req.queryParams(param));
            }

            res.status(204);
            return "";
        });

        post("/webhook/inbound-sms", (req, res) -> {
            logger.info("POST request received, with type: " + req.contentType());

            // The body will be form-encoded or a JSON object:
            if (req.contentType().startsWith("application/x-www-form-urlencoded")) {
                for (String param : req.queryParams()) {
                    System.out.printf("%s: %s\n", param, req.queryParams(param));
                }
            } else {
                IncomingSmsPayload jsonPayload = IncomingSmsPayload.fromJson(req.bodyAsBytes());
                System.out.println(jsonPayload);
            }

            res.status(204);
            return "";
        });
    }
}
