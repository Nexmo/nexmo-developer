package com.nexmo.quickstart.sms;

import static spark.Spark.*;

import static com.nexmo.quickstart.Util.configureLogging;

public class ReceiveDLR {

    public static void main(String[] args) throws Exception {
        configureLogging();

        port(3000);

        get("/webhook/delivery-receipt", (req, res) -> {
            for (String param : req.queryParams()) {
                System.out.printf("%s: %s\n", param, req.queryParams(param));
            }
            res.status(204);
            return "";
        });

        post("/webhook/delivery-receipt", (req, res) -> {
            // The body will be form-encoded or a JSON object:
            if (req.contentType().startsWith("application/x-www-form-urlencoded")) {
                for (String param : req.queryParams()) {
                    System.out.printf("%s: %s\n", param, req.queryParams(param));
                }
            } else {
                IncomingDlrPayload jsonPayload = IncomingDlrPayload.fromJson(req.bodyAsBytes());
                System.out.println(jsonPayload);
            }

            res.status(204);
            return "";
        });
    }
}
