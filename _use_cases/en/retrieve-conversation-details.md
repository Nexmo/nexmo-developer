---
title: Retrieve Conversation details for an in-progress voice call
products: conversation
description: "Retrieve details of a Conversation object for an in-progress voice call"
languages:
    - Curl
    - Python
---

# Retrieve Conversation details

You can retrieve the details of a Conversation object for a voice call using the Conversation API.

While this tutorial looks specifically at retrieving the details of a voice call, there are many other possible use cases with other capabilities, such as a video call or a text chat session. The purpose of this tutorial is to provide insight into the structure of a Conversation, as the Conversation is an important object that underlies much of the Nexmo technology. It is a fundamental data structure for communication activities, as all communication takes place through a Conversation.

The setup you will have in this tutorial is illustrated in the following diagram:

![Conversation](/assets/images/conversation-api/call-forward-conversation.png)

## In this tutorial

- [Prerequisites](#prerequisites)
- [Create a Nexmo application](#create-a-nexmo-application)
- [Create a JWT](#create-a-jwt)
- [Run your webhook server](#run-your-webhook-server)
- [Call your Nexmo Number](#call-your-nexmo-number)
- [Get the Conversation details](#get-the-conversation-details)
- [Conclusion](#conclusion)
- [Resources](#resources)

## Prerequisites

1. [Create a Nexmo account](/account/guides/management#create-and-configure-a-nexmo-account) - you won't get far without this.
2. [Rent a Nexmo Number](/account/guides/numbers#rent-virtual-numbers) - you should have a couple of Euros free credit. It's more than enough.
3. [Install the Nexmo Command Line tools](/tools) - you will need [Node](https://nodejs.org) installed but using nexmo CLI is quick and convenient.
4. You should have [Python 3](https://realpython.com/installing-python/) and [Flask](http://flask.pocoo.org/) installed. These are required for your webhook server.

This tutorial assumes you will be running [Ngrok](https://ngrok.com) in order to run your [webhook](/concepts/guides/webhooks) server locally.

If you are not familiar with Ngrok, please refer to our [Ngrok tutorial](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) before proceeding.

You will also need access to two phones for this tutorial!

So, if you are ready to continue...

## Create a Nexmo Application

First you will need to create a Nexmo Application if you have not already done so:

``` bash
nexmo app:create "Conversation App" http://demo.ngrok.io/webhooks/answer http://demo.ngrok.io/webhooks/event --keyfile private.key
```

In this previous command you will need to replace `demo` by what applies to your setup.

Make a note of the generated Application ID (`APP_ID`), you will need this when you generate a JWT.

## Link a Nexmo Number to your Application

Assuming you have already rented a Nexmo Number (`NEXMO_NUMBER`), you can link your Nexmo Number with your application in the Dashboard or via the command line:

``` bash
nexmo link:app NEXMO_NUMBER APP_ID
```

## Create a JWT

The Conversation API is authenticated using JWTs. You can generate a JWT with the following command:

``` bash
JWT="$(nexmo jwt:generate private.key exp=$(($(date +%s)+86400)) application_id=APP_ID)"
```

You need to replace `APP_ID` with the ID for your application. Also, `private.key` is the key associated with this same application.

> **NOTE:** This JWT will be valid for one day.

You can then view the JWT with:

``` bash
echo $JWT
```

> **TIP:** You can verify your JWT at [jwt.io](https://jwt.io).

## Run your webhook server

You need to run a webhook server to help obtain the Conversation ID for the in-progress call. The following Python code will suffice:

``` python
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)

ncco = [{
        "action": "connect",
        "endpoint": [{
            "type": 'phone',
            "number": 'TO_NUMBER'
        }]
}]

@app.route("/webhooks/answer")
def answer_call():
    params = request.args
    pprint(params)
    return jsonify(ncco)

if __name__ == '__main__':
    app.run(port=3000)
```

> **IMPORTANT:** You need to replace `TO_NUMBER` with the number of your second phone, phone 2 (Bob).

Run this webhook server locally with:

``` bash
python3 app.py
```

## Call your Nexmo Number

Dial your Nexmo Number with phone 1 (Alice). The inbound call is forwarded to your second phone, phone 2 (Bob). Answer the call on phone 2 (Bob). Do not cancel the call at this point.

Now check the logging produced by your webhook server. You should see something similar to:

```
...
{
   'conversation_uuid': 'CON-bc643220-2542-499a-892e-c982c4150c06',
   'from': '447700000001',
   'to': '447700000002',
   'uuid': '797168e24c19a3c45e74e05b10fef2b5'
}
...
```

You are interested only in the Conversation ID which has the form `CON-<uuid>`. Copy and paste that ID somewhere convenient.

## Get the Conversation details

You can retrieve details of the Conversation object for the current call by running the following command in another terminal tab.

> **NOTE:** You will need to make sure you replace `$CONVERSATION_ID` by the ID you obtained previously and `$JWT` by the JWT you created previously.

Obtain the Conversation details for the voice call with the following:

```code_snippets
source: '_examples/conversation/conversation/get-conversation'
```

This API call will give you a response similar to the following:

``` json
{
    "uuid": "CON-bc643220-2542-499a-892e-c982c4150c06",
    "name": "NAM-1b2c4274-e3f2-494e-89c4-46856ee84a8b",
    "timestamp": {
        "created": "2018-10-25T09:26:18.999Z"
    },
    "sequence_number": 8,
    "numbers": {},
    "properties": {
        "ttl": 172800,
        "video": false
    },
    "members": [
        {
            "member_id": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
            "user_id": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6",
            "name": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6",
            "state": "JOINED",
            "timestamp": {
                "joined": "2018-10-25T09:26:30.334Z"
            },
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            },
            "initiator": {
                "joined": {
                    "isSystem": true
                }
            }
        },
        {
            "member_id": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
            "user_id": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b",
            "name": "vapi-user-f59c1ff26c0543fdb6c02fd30617a1c0",
            "state": "JOINED",
            "timestamp": {
                "invited": "2018-10-25T09:26:19.385Z",
                "joined": "2018-10-25T09:26:30.270Z"
            },
            "invited_by": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b",
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000001",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            },
            "initiator": {
                "invited": {
                    "isSystem": true
                }
            }
        }
    ],
    "_links": {
        "self": {
            "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06"
        }
    }
}
```

This response is explained in more detail in the [Conversation](/conversation/concepts/conversation) topic.

You can now hang up phone 1 (Alice) and phone 2 (Bob) to terminate the call.

## Conclusion

You have seen how to use the Conversation API to obtain the Conversation object for a voice call.

## Resources

* [Conversation API docs](/conversation/overview)
* [Conversation API Reference](/api/conversation/)
