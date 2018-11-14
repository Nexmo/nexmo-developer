package com.nexmo.quickstart.sms;

import com.nexmo.client.incoming.MessageEvent;
import spark.Route;
import spark.Spark;

public class ReceiveSMS {

    public static void main(String[] args) throws Exception {
        /*
         * Route to handle incoming SMS GET request.
         */
        Route inboundSmsAsGet = (req, res) -> {
            System.out.println("msisdn: " + req.queryParams("msisdn"));
            System.out.println("messageId: " + req.queryParams("messageId"));
            System.out.println("text: " + req.queryParams("text"));
            System.out.println("type: " + req.queryParams("type"));
            System.out.println("keyword: " + req.queryParams("keyword"));
            System.out.println("messageTimestamp: " + req.queryParams("message-timestamp"));

            res.status(204);
            return "";
        };

        /*
         * Route to handle incoming SMS with POST form-encoded or JSON body.
         */
        Route inboundSmsAsPost = (req, res) -> {
            // The body will be form-encoded or a JSON object:
            if (req.contentType().startsWith("application/x-www-form-urlencoded")) {
                System.out.println("msisdn: " + req.queryParams("msisdn"));
                System.out.println("messageId: " + req.queryParams("messageId"));
                System.out.println("text: " + req.queryParams("text"));
                System.out.println("type: " + req.queryParams("type"));
                System.out.println("keyword: " + req.queryParams("keyword"));
                System.out.println("messageTimestamp: " + req.queryParams("message-timestamp"));
            } else {
                MessageEvent event = MessageEvent.fromJson(req.body());

                System.out.println("msisdn: " + event.getMsisdn());
                System.out.println("messageId: " + event.getMessageId());
                System.out.println("text: " + event.getText());
                System.out.println("type: " + event.getType());
                System.out.println("keyword: " + event.getKeyword());
                System.out.println("messageTimestamp: " + event.getMessageTimestamp());
            }

            res.status(204);
            return "";
        };

        Spark.port(8080);
        Spark.get("/webhooks/inbound-sms", inboundSmsAsGet);
        Spark.post("/webhooks/inbound-sms", inboundSmsAsPost);
    }
}
