---
title: Receiving Concatenated SMS
products: messaging/sms
description: If an inbound SMS exceeds the maximum length allowed for a single SMS, it is split into parts. It is then up to you to reassemble those parts to show the full message. This tutorial shows you how.
languages:
    - Node
---


# Receiving Concatenated SMS

SMS messages that [exceed a certain length](/messaging/sms/guides/concatenation-and-encoding) are split into two or more shorter messages and sent as multiple SMS. 

When you use the SMS API to receive [inbound SMS](/messaging/sms/guides/inbound-sms) that might be longer than the byte-length allowed for a single SMS, you must check to see if the messages delivered to your [webhook](/concepts/guides/webhooks) are standalone or just one part of a multi-part SMS. If there are multiple parts to the message, you must reassemble them to display the full message text.

This tutorial shows you how.

## In this tutorial

In this tutorial, you will create a simple Node.js application using the Express framework that receives inbound SMS via a webhook and determines whether the message is a single-part or multi-part SMS.

If the incoming SMS is multi-part, the application waits until it has received all the message parts and then combines them in the right order to display to the user.

To achieve this, you perform the following steps:

1. [Create the project](#create-the-project) - create a Node.js/Express application
2. [Expose your application to the Internet](#expose-your-application-to-the-internet) - use `ngrok` to enable Nexmo to access your application via a webhook
4. [Create the basic application](#create-the-basic-application) - build an application with a webhook to receive inbound SMS
5. [Register your webhook with Nexmo](#register-your-webhook-with-nexmo) - tell Nexmo's servers about your webhook
6. [Send a test SMS](#send-a-test-sms) - ensure that your webhook can receive incoming SMS
7. [Handle multi-part SMS](#handle-multi-part-sms) - reassemble a multi-part SMS into a single message
8. [Test receipt of a concatenated SMS](#test-receipt-of-a-concatenated-sms) - see it in action!

## Prerequisites

To complete the tutorial, you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up) - for your API key and secret
* [ngrok](https://ngrok.com/) - (optional) to make your development web server accessible to Nexmo's servers over the Internet

## Create the project
Make a directory for your application, `cd` into the directory and then use the Node.js package manager `npm` to create a `package.json` file for your application's dependencies:

```sh
mkdir myapp
cd myapp
npm init
```

Press [Enter] to accept each of the defaults except `entry point` for which you should enter `server.js`.

Then, install the [express](https://expressjs.com) web application framework and the [body-parser](https://www.npmjs.com/package/body-parser) packages:

```sh
npm install express body-parser --save
```

## Expose your application to the Internet

When the SMS API receives an SMS destined for one of your virtual numbers, it alerts your application via a [webhook](/concepts/guides/webhooks). The webhook provides a mechanism for Nexmo's servers to communicate with yours.

For your application to be accessible to Nexmo's servers, it must be publicly available on the Internet. A simple way to achieve this during development and testing is to use [ngrok](https://ngrok.com), a service that exposes local servers to the public Internet over secure tunnels. See [this blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) for more details.

Download and install [ngrok](https://ngrok.com), then start it with the following command:

```sh
ngrok http 5000
```

This creates public URLs (HTTP and HTTPS) for any web site that is running on port 5000 on your local machine.

Use the `ngrok` web interface at <http://localhost:4040> and make a note of the URLs that `ngrok` provides: you need them to complete this tutorial.

## Create the basic application

Create a `server.js` file in your application directory with the following code, which will be our starting point:

```javascript
require('dotenv').config();
const app = require('express')();
const bodyParser = require('body-parser');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app
    .route('/webhooks/inbound-sms')
    .get(handleInboundSms)
    .post(handleInboundSms);

const handleInboundSms = (request, response) => {
    const params = Object.assign(request.query, request.body);

    // Send OK status
    response.status(204).send();
}

app.listen('5000');
```

This code does the following:

* Initializes the dependencies (the `express` framework and `body-parser` for parsing [POST] requests).
* Registers a `/webhooks/inbound-sms` route with Express that accepts both [GET] and [POST] requests. This is the webhook that Nexmo's APIs will use to communicate with our application when one of our virtual numbers receives an SMS.
* Creates a handler function for the route called `handleInboundSms()` that displays a message telling us that we have received an inbound SMS and returns an HTTP `success` response to Nexmo's APIs. This last step is important, otherwise Nexmo will continue trying to deliver the SMS until it times out.
* Runs the application server on port 5000.

## Register your webhook with Nexmo

Now that you have created your webhook, you need to tell Nexmo where it is. Log into your [Nexmo account dashboard](https://dashboard.nexmo.com/) and visit the [settings](https://dashboard.nexmo.com/settings) page.

In your application, the webhook is located at `/webhooks/inbound-sms`. If you are using Ngrok, the full webhook endpoint you need to configure resembles `https://demo.ngrok.io/webhooks/inbound-sms`, where `demo` is the subdomain provided by Ngrok (typically something like `0547f2ad`).

Enter your webhook endpoint in the field labeled **Webhook URL for Inbound Message** and click the [Save changes] button.

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/smsInboundWebhook.png
```

Now, if any of your virtual numbers receive an SMS, Nexmo will call that webhook endpoint with the message details.

## Send a test SMS

1. Open a new terminal window and run the `server.js` file so that it listens for incoming SMS:

    ```sh
    node server.js
    ```

2. Send a test SMS to your Nexmo number from your mobile device, with a short text message. For example, "This is a short text message".

If everything is configured correctly you should receive a `Inbound SMS received` message in the terminal window running `server.js`.

Now, let's write some code to parse the incoming SMS to see what the message contains.

1. Press [CTRL+C] to terminate the running `server.js` application.

2. Create a new function in `server.js` called `displaySms()`:

    ```javascript
    const displaySms = (msisdn, text) => {
        console.log('FROM: ' + msisdn);
        console.log('MESSAGE: ' + text);
        console.log('---');
    }
    ```

3. Also in `server.js` and just before your code sends the `204` response, add a call to `displaySms()` using the following parameters:

    ```javascript
    displaySms(params.msisdn, params.text);
    ```

4. Restart `server.js` and then send another short message from your mobile device. This time, you should see the following in the terminal window running `server.js`:

    ```sh
    Inbound SMS received
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE: This is a short text message.
    ```

5. Keep `server.js` running, but this time use your mobile device to send a message that is considerably longer than a single SMS allows. For example, the first sentence from Dickens' "A Tale of Two Cities":

    ```
    It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
    ```

6. Check the output in the terminal window that is running `server.js`. You should see something that resembles the following:

    ```
    ---
    Inbound SMS received
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE: It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epo
    ---
    Inbound SMS received
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE: ch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything
    ---
    Inbound SMS received
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE: e the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of compariso
    ---
    Inbound SMS received
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE:  before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far lik
    ---
    Inbound SMS received
    FROM: <YOUR_MOBILE_NUMBER>
    MESSAGE: n only.
    ---
    ```

What happened? The message exceeded the single SMS byte limit and so was sent as multiple SMS messages.

To enable us to present such messages to our users in the format they were intended, we need to detect if an incoming message has been split in this way and then reassemble it from the parts.

> Notice in the above output that the parts did not arrive in the correct order. This is not uncommon so we need to code our webhook to handle this eventuality.

## Handle multi-part SMS

Nexmo passes four special parameters to your webhook when an inbound SMS is concatenated. (They don't appear in the request when the SMS is single-part.) You can use them to reassemble the individual parts into a coherent whole:

* `concat:true` - when the message is concatenated
* `concat-ref` - a unique reference that enables you to determine which SMS a particular message part belongs to
* `concat-total` - the total number of parts that comprise the entire SMS
* `concat-part` - the position of this message part in the whole message, so that you can reassemble the parts in the correct order

### Detect if a message is concatenated

First, you need to detect if a message is concatenated. Modify the `handleInboundSms()` function so that it displays a single-part SMS to the user in the usual way, but performs extra processing for multi-part SMS which you will implement in a later step:

```javascript
const handleInboundSms = (request, response) => {
    const params = Object.assign(request.query, request.body);

    if (params['concat'] == 'true') {
        // Perform extra processing
    } else {
        // Not a concatenated message, so just display it
        displaySms(params.msisdn, params.text);
    }   
    
    // Send OK status
    response.status(204).send();
}
```

### Store multi-part SMS for later processing

We need to store any inbound SMS that are part of a larger message so that we can process them once we have all the parts.

Declare an array outside of the `handleInboundSms()` function called `concat_sms`. If an incoming SMS is part of a longer message, store it in the array:

```javascript
let concat_sms = []; // Array of message objects

const handleInboundSms = (request, response) => {
    const params = Object.assign(request.query, request.body);

    if (params['concat'] == 'true') {
        /* This is a concatenated message. Add it to an array
           so that we can process it later. */
        concat_sms.push({
            ref: params['concat-ref'],
            part: params['concat-part'],
            from: params.msisdn,
            message: params.text
        });
    } else {
        // Not a concatenated message, so just display it
        displaySms(params.msisdn, params.text);
    }   
    
    // Send OK status
    response.status(204).send();
}
```

### Gather all the message parts

Before we even attempt to reassemble the message from its parts, we need to ensure that we have all the parts for a given message reference. Remember that there is no guarantee that all the parts will arrive in the correct order, so it is not simply a matter of checking if `concart-part` equals `concat-total`.

We can do this by filtering the `concat_sms` array to include only those SMS objects that share the same `concat-ref` as the SMS that we have just received. If the length of that filtered array is the same as `concat-total`, then we have all the parts for that message and can then reassemble them:

```javascript
    if (params['concat'] == 'true') {
        /* This is a concatenated message. Add it to an array
           so that we can process it later. */
        concat_sms.push({
            ref: params['concat-ref'],
            part: params['concat-part'],
            from: params.msisdn,
            message: params.text
        });

        /* Do we have all the message parts yet? They might
           not arrive consecutively. */
        const parts_for_ref = concat_sms.filter(part => part.ref == params['concat-ref']);

        // Is this the last message part for this reference?
        if (parts_for_ref.length == params['concat-total']) {
            console.dir(parts_for_ref);
            processConcatSms(parts_for_ref);
        }
    } 
```

### Reassemble the message parts

Now that we have all the message parts but not necessarily in the right order, we can use the `Array.sort()` function to reassemble them in order of `concat-part`. Create the `processConcatSms()` function to do that:

```javascript
const processConcatSms = (all_parts) => {

    // Sort the message parts
    all_parts.sort((a, b) => a.part - b.part);

    // Reassemble the message from the parts
    let concat_message = '';
    for (i = 0; i < all_parts.length; i++) {
        concat_message += all_parts[i].message;
    }

    displaySms(all_parts[0].from, concat_message);
}
```

## Test receipt of a concatenated SMS

Run `server.js` and use your mobile device to re-send the long text message that you sent in step 5 of the [Send a test SMS](#send-a-test-sms) section above.

If you have coded everything correctly then in the `server.js` window you should see the individual message parts arrive. When all the parts have been received, the full message displays:

```
[ { ref: '08B5',
    part: '3',
    from: '<YOUR_MOBILE_NUMBER>',
    message: ' before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far lik' },
  { ref: '08B5',
    part: '1',
    from: '<YOUR_MOBILE_NUMBER>',
    message: 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epo' },
  { ref: '08B5', part: '5', from: 'TEST-NEXMO', message: 'n only.' },
  { ref: '08B5',
    part: '2',
    from: '<YOUR_MOBILE_NUMBER>',
    message: 'ch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything' },
  { ref: '08B5',
    part: '4',
    from: '<YOUR_MOBILE_NUMBER>',
    message: 'e the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of compariso' } ]
FROM: <YOUR_MOBILE_NUMBER>
MESSAGE: It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way ... in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.
---
```

## Conclusion

In this tutorial, you created a simple application that shows you how to reassemble a concatenated SMS from its constituent message parts. You learned about the `concat`, `concat-ref`, `concat-total`, and `concat-part` request parameters to your inbound SMS webhook and how you can use them to determine:

* If an inbound SMS is concatenated 
* Which message a specific message part belongs to
* How many message parts comprise the full message
* The order of a specific message part within the full message

## Where Next?

The following resources will help you use Number Insight in your applications:

* The [source code](https://github.com/Nexmo/sms-node-concat-tutorial) for this tutorial on GitHub
* [SMS API product page](https://www.nexmo.com/products/sms)
* [Inbound SMS Concept](/messaging/sms/guides/inbound-sms)
* [Webhooks guide](/concepts/guides/webhooks)
* [SMS API reference](/api/sms)
* [Connect your local development server to the Nexmo API using an ngrok tunnel](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)
* [More SMS API tutorials](/messaging/sms/tutorials)
