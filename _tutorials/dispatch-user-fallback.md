---
title: Multi-user, multi-channel fallback using Dispatch API
products: dispatch
description: This tutorial describes a use case where a an attempt is made to send a message to a user on their designated channels. If the user does not read the message the process is repeated with the next user on the list. This use case uses the Dispatch API as their is multiple designated channels per user, with failover.
languages:
    - Python
---

# Multi-user, multi-channel fallback using Dispatch API

This tutorial shows you how to send a message to a user with failover. The idea is that you have a list of users and each user has two or more designated channels, one of which is the failover channel. An attempt is made to send the message to the first user in the priority list of users on their designted channels. Each channel is atempted in turn, with a suitable failover condition. The last designated channel is the final fallback channel for that user. If all attempts to have the message read by that user fail, then attempts are made to send the message to the next user in the priority list on their designated channels, again with failover on failure to read, with a final fallback channel.

## Example scenario

Perhaps the best way to under this use case is to look at the use case sample configuration file, `sample.json`:

``` json
{
    "APP": {
        "APP_ID": "abcd1234-8238-42d0-a03a-abcd1234...",
        "PRIVATE_KEY": "private.key"
    },
    "FROM": {
        "MESSENGER": "COMPANY MESSENGER ID",
        "VIBER": "COMPANY VIBER ID",
        "WHATSAPP": "COMPANY WHATSAPP NUMBER",
        "SMS": "COMPANY SMS NAME/NUMBER"
    },
    "USERS": [
        {
            "name": "Tony",
            "channels": [
                {
                    "type": "messenger",
                    "id_num": "USER MESSENGER ID"
                },
                {
                    "type": "sms",
                    "id_num": "USER PHONE NUMBER"
                }
            ]
        },
        {
            "name": "Michael",
            "channels": [
                {
                    "type": "viber_service_msg",
                    "id_num": "USER PHONE NUMBER"
                },
                {
                    "type": "whatsapp",
                    "id_num": "USER PHONE NUMBER"
                },
                {
                    "type": "sms",
                    "id_num": "USER PHONE NUMBER"
                }
            ]
        }
    ]
}
```

The most important part of this configuration files is the `USERS` section. Here you have a priority list of users. In this case the application will attempt to send the message to Tony, and if Tony fails to read the message on any of the designated channels, the process is repeated for Michael. The failover condition for each channel of `read` with an expiry time of `600` is currently hardcoded into the application, but could easily be added to the configuration file.

Note that the following conditions apply:

* User must have at least two channels.
* User can mix any number of channels and types as long as there is at least two channels. For example user could have 3 SMS numbers plus a Messenger ID.
* The last channel specified for a user will be taken to be the final failover channel.
* Final failover channel does not have to be SMS although it typically will be.
* A workflow is created on a per user basis, but you can specify a workflow for each user.
* An attempt is made to apply a workflow to a user in the order in which they are listed in the configuration file.

## Source code

The Python source code for this project is available in the Nexmo Community [GitHub repository](https://github.com/nexmo-community/dispatch-user-fallback). Two use cases are actually included in the codebase, but this tutorial only describes `case-2`. The code for `case-2` specifically can be found [here](https://github.com/nexmo-community/dispatch-user-fallback/tree/master/case-2). There are just two files - the configuration file and the application. However, you should also run the [webhook server](https://github.com/nexmo-community/dispatch-user-fallback/blob/master/case-1/server.py) from `case-1` to ensure that webhooks are acknowledged - this prevents clogging the callback queue with unacknowledged webhook retries.

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

If you plan to test this use case with Facebook Messenger it is recommended that you work through [this tutorial](/tutorials/fbm-product-info) first.

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Create a Nexmo Application](#create-your-nexmo-application)
2. [Get Ngrok up and running](#get-ngrok-up-and-running)
3. [Run your webhook server](#run-your-webhook-server)
4. [Review the application code](#review-the-application-code)
5. [Test the app](#test-the-app)

There are various ways you can achieve the same result with Nexmo. This tutorial shows only one specific way to do things, for example you will see how to use the command line to create the application, rather than the Dashboard. Other tutorials demonstrate other ways of doing things.

## Create your Nexmo Application

If you have not yet done so, create a new directory for your project, such as `multi-user-dispatch`. Change into this directory.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "Multi-user Dispatch App" https://abcd1234.ngrok.io/webhooks/inbound https://abcd1234.ngrok.io/webhooks/status --keyfile=private.key --type=messages
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

## Run your webhook server

You need to get your webhook server up and running so that webhooks are acknowledge, and details of sent messages can be logged. This would look like the following:

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

if __name__ == '__main__':
    app.run(host="localhost", port=9000)
```

Add this code to a file called `server.py` and save it.

Run it locally with:

``` shell
python3 server.py
```

## Review the application code

For convenience the code is contained in a single file `app.py`. There is only this and your configuration file, which is JSON. This configuration file stores the list of users to contact in priority order, plus their designated channels. Each user must have at least two channels, but there can otherwise be any convenient mix of channels. For example, one user might have three SMS numbers, another user might have a Messenger ID, Viber and two additional mobile numbers. The last channel listed for each user is treated as the final fallback before switching to another user. For each user each channel will be sent a message using the Dispatch API, with failover to the next channel if the message is not read within 600 seconds.

The first part of the application code simply reads the configuration file and loads the important variables and data structures. It is assumed that your company will support all four channels supported by the Dispatch API, `messenger`, `viber_service_msg`, `whatsapp` and `sms`, although the target users can be assigned their preferred channels only. Some users for example might only be contactable by SMS.

There is a helper function to manage the fact that some channels user `numbers` and some use `ids` and Viber which uses both `ids` and `numbers`. 

The main functionality for this use case is in the `build_user_workflow` function. This code builds a workflow such as the following:

``` json
{
    "template": "failover",
    "workflow": [
        {
            "from": {
                "type": "messenger",
                "id": "from_messenger"
            },
            "to": {
                "type": "messenger",
                "id": "user_id_num"
            },
            "message": {
                "content": {
                    "type": "text",
                    "text": "This is a Facebook Messenger Message sent from the Dispatch API"
                }
            },
            "failover": {
                "expiry_time": 600,
                "condition_status": "read"
            }
        },
        {
            "from": {
                "type": "viber_service_msg",
                "id": "from_viber"
            },
            "to": {
                "type": "viber_service_msg",
                "number": "user_id_num"
            },
            "message": {
                "content": {
                    "type": "text",
                    "text": "This is a Viber Service Message sent from the Dispatch API"
                }
            },
            "failover": {
                "expiry_time": 600,
                "condition_status": "read"
            }
        },
        {
            "from": {
                "type": "sms",
                "number": "from_sms"
            },
            "to": {
                "type": "sms",
                "number": "user_id_num"
            },
            "message": {
                "content": {
                    "type": "text",
                    "text": "This is an SMS sent from the Dispatch API"
                }
            }
        }
    ]
}
```

The function makes sure correct real values as read from the configuration file are embedded into the workflow.

You probably noticed that the `expiry_time` and `condition_status` are hardcoded into the workflow as built in `build_user_workflow`. This was done to keep the code as simple as possible, but you could add this to the configuration file on a per user basis. So some users might have a 300 second expiry on some channels, and you could specify the failover condition of `read` or `delivered` on a per-channel and per-user basis. This has been implemented for you in `case-3` but is not described further in this tutorial as all code is given.

Once the workflow has been built, you use the Dispatch API to send the message:

``` python
    r = requests.post('https://api.nexmo.com/v0.1/dispatch', headers=headers, data=workflow)
```

A JWT is generated in order to authenticate the API call. This is why you needed the `app_id` and `private_key` values from when you created your Nexmo application.

## Test the app

You can run the app with:

``` shell
python3 app.py
```

The application will process the configuration file and contact each user until until the message has been read.

### SMS

You can use any mobile phone that can receive an SMS to test this tutorial.

### Facebook Messenger

To test with Facebook Messenger there are a few additional steps required. These have been discussed in detail in [this tutorial](/tutorials/fbm-product-info), so that information has not been replicated here.

### Viber

You need a Viber Service Message ID to test this tutorial with Viber.

### WhatsApp

You need a WhatsApp business account to test this tutorial with WhatsApp. In addition the user must be sent a MTM before they can receive messages from your company.

## Summary

In this tutorial you have seen a use case where you can attempt to send a message to a list of users, where each you has multiple channels. The application terminates when the message has been read.

## Further resources

* [The complete source code](https://github.com/nexmo-community/dispatch-user-fallback).
* [Dispatch API documentation](/dispatch/overview)
* [Send a WhatsApp MTM](/messages/code-snippets/send-whatsapp-template)
