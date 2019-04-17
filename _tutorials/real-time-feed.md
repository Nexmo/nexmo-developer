---
title: Real-time data feed into multiple channels using Messages API
products: messages
description: This tutorial looks at a use case where the user receives real-time data into their channel. Channels supported are FaceBook Messenger, WhatsApp, Viber and SMS.
languages:
    - Python
---

# Real-time data feed into multiple channels using Messages API

This tutorial shows you how to feed data into multiple channels in real-time. This tutorial demonstrates sending data into all channels supported by the Messages API. While all channels are supported, you will only test SMS in this tutorial. If you are interested in testing using FaceBook Messenger, it is recommended you work through [this tutorial](/tutorials/fbm-product-info) first, as that tutorial contains lots of FaceBook specific information.

> Please note that only simulated stock prices are used in this tutorial.

## Example scenario

In this tutorial you will look sending real-time stock quotes to a user on their channel of choice. A user can register to receive data on any supported channel of their choice. For example, they could receive the stock quotes via their mobile phone using SMS, or through Facebook Messenger. WhatsApp and Viber are also supported. For FaceBook Messenger, WhatsApp, and SMS users can register their interest in a particualr stock. However, Viber does not support inbound messages to a business, so users would have to register to receive the messages via a website in order to receive data. Also, with WhatsApp there is an additional complication which is that WhatsApp requires a business to send the user [an MTM](/messages/code-snippets/send-whatsapp-template) before the user can agree to receive messages.

> **NOTE:** This tutorial assumes you have already created a Facebook Profile and a Facebook Page, as well as valid WhatsApp and Viber accounts (if you want to test those channels). A mobile phone can be used to test the SMS data feed.

## Source code

The source code for this project is available in the Nexmo Community [GitHub repository](https://github.com/nexmo-community/messages-api-real-time-feed).

## Prerequisites

1. [Create a Nexmo Account](https://dashboard.nexmo.com/sign-in)
2. [Install Node JS](https://nodejs.org/en/download/) - required for using the Nexmo Command Line Interface (CLI).
3. [Install the Beta version of the Nexmo CLI](/messages/code-snippets/install-cli)
4. [Know how to test your webhook server locally](/messages/code-snippets/configure-webhooks#testing-locally-via-ngrok)
5. [Python 3 installed](https://www.python.org/)
6. [Flask installed](http://flask.pocoo.org/)
7. Have accounts for the channels you wish to support such as FaceBook, Viber and WhatsApp.

You may also find it useful to review the following overview topics:

* [Facebook Messenger](/messages/concepts/facebook)
* [Viber](/messages/concepts/viber)
* [WhatsApp](/messages/concepts/whatsapp)

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Create a Nexmo Application](#create-your-nexmo-application)
2. [Get Ngrok up and running](#get-ngrok-up-and-running)
3. [Set your SMS webhooks in Dashboard](#set-your-sms-webhooks-in-dashboard)
4. [Write your basic application](#write-your-basic-application)
5. [Send in an SMS](#send-in-an-sms)
6. [Review the generic client code](#generic-client)
7. [The use case revisited](#the-use-case-revisited)

There are various ways you can achieve the same result with Nexmo. This tutorial shows only one specific way to do things, for example you will see how to use the command line to create the application, rather than the Dashboard. Other tutorials demonstrate other ways of doing things.

## Create your Nexmo Application

If you have not yet done so, create a new directory for your project, such as `real-time-app`. Change into this directory.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "Real-time App" https://abcd1234.ngrok.io/webhooks/inbound https://abcd1234.ngrok.io/webhooks/status --keyfile=private.key --type=messages
```

Make a note of the generated Application ID. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com/messages/applications).

This command will also create a private key, `private.key` in your current directory.

This command also sets the two webhooks that need to be set. All interaction between your App and Nexmo takes place through these webhooks. You must at least acknowledge each of these webhooks in your app.

## Get Ngrok up and running

Make sure you have Ngrok running for testing locally. To start Ngrok type:

``` shell
ngrok http 9000
```

To generate a temporary Ngrok URL. If you are a paid subscriber you could type:

``` shell
ngrok http 9000 -subdomain=your_domain
```

> Note in this case Ngrok will divert the Nexmo webhooks you specified when you created your Nexmo application to `localhost:9000`.

## Set your SMS webhooks in Dashboard

In Nexmo Dashboard go to [account settings](https://dashboard.nexmo.com/settings). In here you can set your account-level SMS webhooks:

Webhook | URL
---|---
Delivery receipt | https://abcd1234.ngrok.io/webhooks/delivery-receipt
Inbound SMS | https://abcd1234.ngrok.io/webhooks/inbound-sms

Note you will need to replace "abcd1234" in the webhook URLs by your own information. If you have a paid Ngrok account that can be your custom domain.

## Write your basic application

So in the simplest case your application would look like the following:

``` python
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)

@app.route('/webhooks/inbound', methods=['POST'])
def inbound_message():
    print ("** inbound_message **")
    data = request.get_json()
    pprint(data)
    return ("inbound_message", 200)

@app.route('/webhooks/status', methods=['POST'])
def message_status():
    print ("** message_status **")
    data = request.get_json()
    pprint(data)
    return ("message_status", 200)

@app.route('/webhooks/inbound-sms', methods=['POST'])
def inbound_sms():
    print ("** inbound_sms **")
    values = request.values
    pprint(values)
    return ("inbound_sms", 200)

@app.route('/webhooks/delivery-receipt', methods=['POST'])
def delivery_receipt():
    print ("** delivery_receipt **")
    data = request.get_json()
    pprint(data)
    return ("delivery_receipt", 200)

if __name__ == '__main__':
    app.run(host="localhost", port=9000)
```

Add this code to a file called `app1.py` and save it.

Run it locally with:

``` shell
python3 app1.py
```

## Send in an SMS

Your base application is now up and running and ready to log events. You can test this basic application by sending an SMS into any Nexmo Number linked to a Voice app, where the number has voice and SMS capbilities. If you are not sure how to create a voice app you can review [this information](/concepts/guides/applications/curl#getting-started-with-applications). The reason you need to go through this additional step is that Messages and Dispatch API does not currently support inbound SMS, only outbound SMS, so you have to use the account level webhook to receive inbound SMS notification. We support this in this tutorial to allow the user to sign up to receive real-time data.

When you examine the tracing information produced when you send in an SMS you will see something similar to the following:

```
** inbound_sms **
{'keyword': 'MESSAGE',
 'message-timestamp': '2019-04-16 13:55:21',
 'messageId': '1700000240EAA6B6',
 'msisdn': '447700000001',
 'text': 'Message from Tony',
 'to': '447520635498',
 'type': 'text'}
```

## Generic client

Currently Nexmo does not officially support Messages and Dispatch API in the Python client library, but our REST API is supported and the [Python code is provided](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/Client/Client.py) in the project for you in a reusable class. This class allows sending of a message using the Messages API to any of its supported channels. The code is worth taking a quick look at some of the code:

``` python
    def send_message (self, channel_type, sender, recipient, msg):
        if channel_type == 'messenger':
            from_field = "id"
            to_field = "id"
        elif channel_type == 'whatsapp' or channel_type == "sms": 
            from_field = "number"
            to_field = "number"
        elif channel_type == 'viber_service_msg':
            from_field = "id"
            to_field = "number"
               
        data_body = json.dumps({
            "from": {
	        "type": channel_type,
	        from_field: sender
            },
            "to": {
	        "type": channel_type,
	        to_field: recipient
            },
            "message": {
	        "content": {
	            "type": "text",
	            "text": msg
	        }
            }
        })
...
```

What happens is the body is built for you based on the channel type, as the details are slightly different between the channels - for example Facebook uses IDs, whereas WhatsApp and SMS only used numbers. Viber uses an ID and a number. The code then goes on to use the Messages API to send the message for you. This is the basis of the use case, with a few extra bits to allow for user sign up.

## The use case revisited

It's time to look into this use case in more detail so you can more effectively build out your application. For channels that support inbound messages (Messenger, WhatsApp and SMS) we can allow the user to send in a message to sign up. For Viber this will have to be done via another part of the web app.

If a user sends in a message such as "Hi", the app will respond with a help message. In our simple case this is "Send us a message with MSFT or GOOGL in it for real-time data". This sign up will then be acknowledged by another message confirming which feed you have subscribed to.

After this you will then receive a real-time price on your selected stock symbol. If you want to additionally sign up on another channel you are free to do so. Also if you want to change your stock symbol simply type the new symbol, it will be acknowledged, and the data stream will change.

The core code to implement this is located in the function `proc_inbound_msg` in `app_funcs.py`.

For WhatsApp you would have an additional step where you need to send an [MTM message](/messages/code-snippets/send-whatsapp-template) to the user before the user can sign up to receive data.

## Testing the app

You can run the app with:

``` shell
python3 app.py
```

### SMS

To test with SMS simply send in an SMS as you did before. You will receive a help message. Send a message back with the stock symbol of either `MSFT` or `GOOGL`. You will periodically receive a (simulated) price update. You currently have to stop the app to stop receiving these, but it would be a simple matter to add in the ability to swtich these messages off, as was done in [this tutorial](/tutorials/fbm-product-info).

### Facebook Messenger

To test with Facebook Messenger there are a few additional steps required. These have been discussed in detail in [this tutorial](/tutorials/fbm-product-info), so that information has not been replicated here.

### Viber

As Viber does not support an inbound message into a business account you have an additional requirement to test Viber. You would have part of your web app that would request the user supplies their phone number and the symbol they are interested in. They could then be sent an initial message which they would have the ability to receive or decline. You would need a valid Viber business account to test this out.

### WhatsApp

WhatsApp requires an additional step to test fully. You would need to send the user a WhatsApp MTM (template) before they can receive any messages. The code to do this has not been described in this tutorial but sample code is available [here](https://github.com/nexmo-community/messages-api-real-time-feed/blob/master/send_whatsapp_mtm.py). You can use then use the generic client provided in this tutorial to send subsequent WhatsApp messages.

## Summary

In this tutorial you have seen a use case where the user can receive real-time data on any channel supported by the Messages API.

## Further resources

* [The complete source code](https://github.com/nexmo-community/messages-api-real-time-feed).
* [Messages API documentation](/messages/overview)
* [Send a WhatsApp MTM](/messages/code-snippets/send-whatsapp-template)
