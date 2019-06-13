---
title: Private SMS communication
products: messaging/sms
description: This tutorial shows you how to faciliate SMS communication between two parties without revealing either one's real phone number to the other.
languages:
    - Node
---

# Private SMS communication

Sometimes you want two parties to exchange SMS without revealing their actual phone numbers. 

For example, if you are operating a taxi booking service, then you want your customers and drivers to be able to communicate to coordinate pick-up times, locations, etc. But you don't want your driver to know your customer's phone number, so that you can protect their privacy. And, conversely, you don't want your customer to know the driver's number and be able to book taxi services directly, bypassing your application.

## In this tutorial

This tutorial is based on the [private SMS use case](https://www.nexmo.com/use-cases/private-sms-communication). It teaches you how to build an SMS proxy system using Node.js and the Nexmo Node.js REST API client library, using a virtual phone number to mask the real numbers of the participants.

To build the application, you perform the following steps:

* [Create the basic web application](#create-the-basic-web-application) - build the basic application framework
* [Configure the application](#configure-the-application) - to use your API key and secret and the virtual number you have provisioned
* [Create a chat](#create-a-chat) - create a mapping between your users' real numbers and the virtual one
* [Receive inbound SMS](#receive-inbound-sms) - capture incoming SMS on your virtual number and forward them to the target user's real number

## Prerequisites

To complete this tutorial, you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up) - for your API key and secret and to rent virtual numbers.
* A [Nexmo virtual number](https://developer.nexmo.com/concepts/guides/glossary#virtual-number) - to hide each user's real number. You can rent a number in the [developer dashboard](https://dashboard.nexmo.com/buy-numbers).
* The [source code](https://github.com/Nexmo/node-sms-proxy) on GitHub - installation instructions are in the [README](https://github.com/Nexmo/node-sms-proxy/blob/master/README.md).
* [Node.js](https://nodejs.org/en/download/) installed and configured.
* [ngrok](https://ngrok.com/) - (optional) to make your development web server accessible to Nexmo's servers over the Internet.

## Create the basic web application

This application uses the [Express](https://expressjs.com/) framework for routing and the [Nexmo Node.js REST API client library](https://github.com/Nexmo/nexmo-node) for sending and receiving SMS. We use `dotenv` so that we can configure the application in a `.env` text file.

In `server.js` we initialize the application's dependencies and start the web server. We provide a route handler for the application's home page (`/`) so that you can test that the server is running by visiting `http://localhost:3000`:

```javascript
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const SmsProxy = require('./SmsProxy');

const app = express();
app.set('port', (process.env.PORT || 3000));
app.use(bodyParser.urlencoded({ extended: false }));

app.listen(app.get('port'), function () {
    console.log('SMS Proxy App listening on port', app.get('port'));
});

const smsProxy = new SmsProxy();

app.get('/', (req, res) => {
    res.send('Hello world');
})
```

Note that we are instantiating an object of the `SmsProxy` class to handle the routing of messages sent to your virtual number to the intended recipient's real number. We cover the actual proxying process in [proxy the SMS](#proxy-the-sms), but for now just be aware that this class initializes the `nexmo` REST API client library using the API key and secret that you will configure in the next step. This enables your application to send and receive SMS:

```javascript
const Nexmo = require('nexmo');

class SmsProxy {

    constructor() {

        this.nexmo = new Nexmo({
            apiKey: process.env.NEXMO_API_KEY,
            apiSecret: process.env.NEXMO_API_SECRET
        }, {
                debug: true
            });
    }
    ...
```

## Configure the application

Copy the `example.env` file provided to `.env` and modify it to include your Nexmo API key and secret and your Nexmo virtual number. You can find this information in the [developer dashboard](https://dashboard.nexmo.com):

```
NEXMO_API_KEY=YOUR_NEXMO_API_KEY
NEXMO_API_SECRET=YOUR_NEXMO_API_SECRET
VIRTUAL_NUMBER=YOUR_NEXMO_VIRTUAL_NUMBER
```

## Create a chat

To use the application, you make a `POST` request to the `/chat` route, passing in the real phone numbers of two users. (You can see a sample request in [start the chat](#start-the-chat)).

The route handler for `/chat` is shown below:

```javascript
app.post('/chat', (req, res) => {
    const userANumber = req.body.userANumber;
    const userBNumber = req.body.userBNumber;

    smsProxy.createChat(userANumber, userBNumber, (err, result) => {
        if (err) {
            res.status(500).json(err);
        }
        else {
            res.json(result);
        }
    });
    res.send('OK');

});
```

The chat object is created in the `createChat()` method of the `smsProxy` class. It stores each user's real number:

```javascript
createChat(userANumber, userBNumber) {
    this.chat = {
        userA: userANumber,
        userB: userBNumber
    };

    this.sendSMS();
}
```

Now that we have created a chat, we need to let each user know how they can contact the other.

### Introduce the users

> **Note**: In this tutorial each user receives the virtual number via an SMS. In production systems this could be supplied using email, in-app notifications or as a predefined number.

In the `sendSMS()` method of the `smsProxy` class we use the Nexmo REST API client library's `sendSms()` method to send two messages to the virtual number from each user's real number. 

```javascript
sendSMS() {
    /*  
        Send a message from userA to the virtual number
    */
    this.nexmo.message.sendSms(this.chat.userA,
                                process.env.VIRTUAL_NUMBER,
                                'Reply to this SMS to talk to UserA');

    /*  
        Send a message from userB to the virtual number
    */
    this.nexmo.message.sendSms(this.chat.userB,
                                process.env.VIRTUAL_NUMBER,
                                'Reply to this SMS to talk to UserB');
}
```

We now need to intercept these incoming messages on the virtual number and proxy them to the intended recipient's real number.

## Receive inbound SMS
When one user sends a message to the other, they are sending it to the application's virtual number instead of the target user's real number. When Nexmo receives an inbound SMS on the virtual number it makes an HTTP request to the webhook endpoint associated with that number:

In `server.js`, we provide a route handler for the `/webhooks/inbound-sms` request that Nexmo's servers make to your application when your virtual number receives an SMS. We're using a `POST` request here, but you could also use `GET` or `POST-JSON`. This is configurable in the dashboard, as described in [expose your application to the internet](#expose-your-application-to-the-internet).

We retrieve the `from` and `text` parameters from the inbound request, and pass them to the `SmsProxy` class to determine which real number to send it to:

```javascript
app.get('/webhooks/inbound-sms', (req, res) => {
    const from = req.query.msisdn;
    const to = req.query.to;
    const text = req.query.text;

    // Route virtual number to real number
    smsProxy.proxySms(from, text);

    res.sendStatus(204);
});
```

We return a `204` status (`No content`) to represent successful receipt of the message. This is an important step, because if we don't acknowledge receipt Nexmo's servers will make repeated attempts to deliver it.

### Determine how to route the SMS

Now that you know the real number of the user sending the SMS, you can forward the message to the real number of the other user. This logic is implemented in the `getDestinationRealNumber()` method of the `SmsProxy` class:

```javascript
getDestinationRealNumber(from) {
    let destinationRealNumber = null;

    // Use `from` numbers to work out who is sending to whom
    const fromUserA = (from === this.chat.userA);
    const fromUserB = (from === this.chat.userB);

    if (fromUserA || fromUserB) {
        destinationRealNumber = fromUserA ? this.chat.userB : this.chat.userA;
    }

    return destinationRealNumber;
}
```

Now that you can determine which user to send the message to, all you have to do is send it!

### Proxy the SMS

Proxy the SMS to the real phone number of the intended recipient. The `from` number is always the virtual number (to preserve the user's anonymity), the `to` is the user's real phone number.

```javascript
proxySms(from, text) {
    // Determine which real number to send the SMS to
    const destinationRealNumber = this.getDestinationRealNumber(from);

    if (destinationRealNumber  === null) {
        console.log(`No chat found for this number);
        return;
    }

    // Send the SMS from the virtual number to the real number
    this.nexmo.message.sendSms(process.env.VIRTUAL_NUMBER,
                                destinationRealNumber,
                                text);
}
```

## Try it out

### Expose your application to the Internet

When the SMS API receives an SMS destined for your virtual number, it alerts your application via a [webhook](/concepts/guides/webhooks). The webhook provides a mechanism for Nexmo's servers to communicate with yours.

For your application to be accessible to Nexmo's servers, it must be publicly available on the Internet. A simple way to achieve this during development and testing is to use [ngrok](https://ngrok.com), a service that exposes local servers to the public Internet over secure tunnels. See [this blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) for more details.

Download and install [ngrok](https://ngrok.com), then start it with the following command:

```sh
ngrok http 3000
```

This creates public URLs (HTTP and HTTPS) for any web site that is running on port 3000 on your local machine.

Use the `ngrok` web interface at <http://localhost:4040> and make a note of the URLs that `ngrok` provides. 

Go to your [account settings](https://dashboard.nexmo.com/settings) page and enter the full URL to your webhook endpoint in the "Inbound Messages" text box. For example, if you are using `ngrok` then your URL might resemble the following:

```
https://33ab96a2.ngrok.io/webhooks/inbound-sms
```

Ensure that you select `POST` from the "HTTP Method" drop-down list so that Nexmo knows that your application is expecting the message details to be delivered via a `POST` request.

### Start the chat

Make a `POST` request to your application's `/chat` endpoint, passing in your users' real numbers as request parameters.

You could use [Postman](https://www.getpostman.com) for this, or a `curl` command similar to the following, replacing `USERA_REAL_NUMBER` and `USERB_REAL_NUMBER` with your users' actual numbers:

```sh
curl -X POST \
  'http://localhost:3000/chat?userANumber=USERA_REAL_NUMBER&userBNumber=USERB_REAL_NUMBER' 
```

### Continue the chat

Each user should receive a text from the application's virtual number. When a user replies to that number it is delivered to the other user's real number, but appears to come from the virtual one.


## Conclusion

In this tutorial, you learned how to build an SMS proxy to enable two users to exchange SMS without either seeing the other's real number. 


## Where Next?

You could extend this sample application to use the same virtual number to host multiple chats by using `SmsProxy.createChat()` to instantiate and then persist a separate `chat` object for different pairs of users. So, for example, you could have one `chat` object for `userA` and `userB` to converse and another for `userC` and `userD`.

You could create routes that enable you to see all current chats and also terminate a chat when it's over.

The following resources will help you find out more about what you learned in this tutorial:

* [Tutorial code on GitHub](https://github.com/Nexmo/node-sms-proxy)
* [Private SMS use case](https://www.nexmo.com/use-cases/private-sms-communication)
* [SMS API reference guide](/api/sms)
* [Other SMS API tutorials](/messaging/sms/tutorials)
* [Setting up and using Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)
