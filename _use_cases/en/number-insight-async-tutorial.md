---
title: Number Insight Advanced API
products: number-insight
description: Learn how to access comprehensive information about the validity and reachability of a number.
languages:
    - Node
---


# Number Insight Advanced API 

The Number Insight API gives you real-time information about phone numbers worldwide. There are three levels available: Basic, Standard and Advanced.

The Advanced level provides you with the most comprehensive data to help protect your organization from fraud and spam. Unlike the Basic and Standard levels, you typically access the Advanced API asynchronously, via a [webhook](/concepts/guides/webhooks).

## In this tutorial

In this tutorial, you create a simple RESTful web service in Node.js and Express that accepts a phone number and returns insight information about the number when it becomes available.

To achieve this, you perform the following steps:

1. [Create the project](#create-the-project) - create a Node.js/Express application.
2. [Install the `nexmo` package](#install-the-nexmo-package) - add Nexmo capabilities to your project.
3. [Expose your application to the Internet](#expose-your-application-to-the-internet) - use `ngrok` to enable Nexmo to access your application via a webhook.
4. [Create the basic application](#create-the-basic-application) - build the basic functionality.
5. [Create the asynchronous request](#create-the-asynchronous-request) - call the Number Insight Advanced API.
6. [Create the webhook](#create-the-webhook) - write the code that processes the incoming insight data.
7. [Test the application](#test-the-application) - see it in action!

## Prerequisites

To complete the tutorial, you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up) - for your API key and secret
* [ngrok](https://ngrok.com/) - to make your development web server accessible to Nexmo's servers over the Internet

## Create the project
Make a directory for your application, `cd` into the directory and then use the Node.js package manager `npm` to create a `package.json` file for your application's dependencies:

```sh
$ mkdir myapp
$ cd myapp
$ npm init
```

Press [Enter] to accept each of the defaults.

Then, install the [express](https://expressjs.com) web application framework and [body-parser](https://www.npmjs.com/package/body-parser) packages:

```sh
$ npm install express body-parser  --save
```

## Install the `nexmo` package

Execute the following `npm` command in the terminal window to install the Nexmo REST API client for Node.js:

```sh
$ npm install nexmo --save
```

## Expose your application to the Internet

When the Number Insight API finishes processing your request, it alerts your application via a [webhook](/concepts/guides/webhooks). The webhook provides a mechanism for Nexmo's servers to communicate with yours.

For your application to be accessible to Nexmo's servers, it must be publicly available on the Internet. A simple way to achieve this during development and testing is to use [ngrok](https://ngrok.com), a service that exposes local servers to the public Internet over secure tunnels. See [this blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) for more details.

Download and install [ngrok](https://ngrok.com), then start it with the following command:

```sh
$ ./ngrok http 5000
```

This creates public URLs (HTTP and HTTPS) for any web site that is running on port 5000 on your local machine.

Use the `ngrok` web interface at <http://localhost:4040> and make a note of the URLs that `ngrok` provides: you need them to complete this tutorial.

## Create the basic application

Create the `index.js` file in your application directory with the following code, replacing the `NEXMO_API_KEY`, `NEXMO_API_SECRET` and `WEBHOOK_URL` constants with your own values:

```javascript
const app = require('express')();
const bodyParser = require('body-parser');

app.set('port', 5000));
app.use(bodyParser.json());

const NEXMO_API_KEY = // Your Nexmo API key
const NEXMO_API_SECRET = // Your Nexmo API secret
const WEBHOOK_URL = // e.g. https://bcac78a0.ngrok.io/webhooks/insight

app.get('/insight/:number', function(request, response) {
    console.log("Getting information for " + request.params.number);
}); 

app.listen(app.get('port'), function() {
    console.log('Listening on port', app.get('port'));
});
```

Test it by executing the following command in the terminal and receiving the result shown:

```sh
$ node index.js
Listening on port 5000
```

In a browser, enter the following URL, replacing `https://bcac78a0.ngrok.io` with the host name `ngrok` supplies:

```
https://bcac78a0.ngrok.io/insight/123456
```

If everything is working correctly, `Getting information for 123456` displays in the terminal.

## Create the asynchronous request

Now that your application can receive a phone number, you need to create the asynchronous request to the Number Insight Async API.

First, write the code that creates an instance of `Nexmo` with your account details:

```javascript
const Nexmo = require('nexmo');
const nexmo = new Nexmo({
    apiKey: NEXMO_API_KEY,
    apiSecret: NEXMO_API_SECRET
});
```

Then, extend the `/insight/:number` route to call the Number Insight API, passing in the number you are interested in and the URL of the webhook that deals with the response. You create the webhook in a later step.

```javascript
app.get('/insight/:number', function(request, response) {
    console.log("Getting information for " + request.params.number);
    nexmo.numberInsight.get({
        level: 'advancedAsync',
        number: request.params.number,
	callback: WEBHOOK_URL
    }, function (error, result) {
	if (error) {
	    console.error(error);
	} else {
	    console.log(result);
	}
    });
});
```

The call to the Number Insight Advanced API returns an immediate response that acknowledges the request before the actual insight data is available. It is this response we are logging to the console:

```sh
{
  request_id: '3e6e31a4-3efb-49ab-8751-5a43e4de6406',
  number: '447700900000',
  remaining_balance: '17.775',
  request_price: '0.03000000',
  status: 0
}
```

The `status` field in the request body tells you if the operation was successful. A value of zero indicates success and a non-zero value indicates failure as described in the [Number Insight API Reference documentation](/api/number-insight#getNumberInsightAsync).

## Create the webhook

The Insight API returns the results to your application via a ``POST`` request, so you must define the `/webhooks/insight` route handler as `app.post()`, as shown:

```javascript
app.post('/webhooks/insight', function (request, response) {
    console.dir(request.body);
    response.status(204).send();
});
```

The handler logs the incoming JSON data to the console and sends a `204` HTTP response to Nexmo's servers.

> HTTP Status Code 204 indicates that the server has successfully fulfilled the request and there is no additional content to send in the response payload body.

## Test the application

Run `index.js`:

```sh
$ node index.js
```

Enter a URL in the following format in the browser's address bar, replacing `https://bcac78a0.ngrok.io` with your `ngrok` URL and  `INSIGHT_NUMBER` with a telephone number of your choice:

```
http://YOUR_NGROK_HOSTNAME/insight/NUMBER
```

After the initial acknowledgement response, the console should display information similar to that shown below:

```sh
{
  "status": 0,
  "status_message": "Success",
  "lookup_outcome": 0,
  "lookup_outcome_message": "Success",
  "request_id": "55a7ed8e-ba3f-4730-8b5e-c2e787cbb2b2",
  "international_format_number": "447700900000",
  "national_format_number": "07700 900000",
  "country_code": "GB",
  "country_code_iso3": "GBR",
  "country_name": "United Kingdom",
  "country_prefix": "44",
  "request_price": "0.03000000",
  "remaining_balance": "1.97",
  "current_carrier": {
    "network_code": "23410",
    "name": "Telefonica UK Limited",
    "country": "GB",
    "network_type": "mobile"
  },
  "original_carrier": {
    "network_code": "23410",
    "name": "Telefonica UK Limited",
    "country": "GB",
    "network_type": "mobile"
  },
  "valid_number": "valid",
  "reachable": "reachable",
  "ported": "not_ported",
  "roaming": {
    "status": "not_roaming"
  }
}
```

Consider the following when testing your application:

* The Insight Advanced API does not provide any information about landlines that is not available in the Standard API. 
* Requests to the Insight API are not free. Consider using the `ngrok` dashboard to replay previous requests during development to avoid unnecessary charges. 

## Conclusion

In this tutorial, you created a simple application that uses the Number Insight Advanced Async API to return data to a webhook.

The tutorial did not cover some of the features specific to the Advanced API such as IP address matching, reachability and roaming status. Review the [documentation](/number-insight/overview) to learn how to use these features.

## Where Next?

The following resources will help you use Number Insight in your applications:

* The [source code](https://github.com/Nexmo/ni-node-async-tutorial) for this tutorial on GitHub
* [Number Insight API product page](https://www.nexmo.com/products/number-insight)
* [Comparing the Basic, Standard and Advanced Insight APIs](/number-insight/overview#basic-standard-and-advanced-apis)
* [Webhooks guide](/concepts/guides/webhooks)
* [Number Insight Advanced API reference](/api/number-insight#getNumberInsightAsync)
* [Connect your local development server to the Nexmo API using an ngrok tunnel](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/)
* [More tutorials](/number-insight/tutorials)
