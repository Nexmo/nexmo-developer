---
title: Private SMS communication
products: messaging/sms
description: All mobile phones can send and receive SMS messages, and nearly everybody has a phone. This makes SMS a great choice to communicate with your users from your application.
languages:
    - Node
---

# Private SMS communication

All mobile phones can send and receive SMS messages, and nearly everybody has a phone. This makes SMS a great choice to communicate with your users from your application.

For marketplace scenarios such as food delivery or taxi and passenger communications, if users see each other's real phone numbers they can bypass your marketplace and your application cannot track the communication threads. To avoid security and privacy concerns it is best practice that users do not have access to each other real phone numbers.

By implementing private communication over SMS you ensure your users cannot bypass the required or preferred communication workflows and audits.

This tutorial is based on the [Private SMS Communication](https://www.nexmo.com/use-cases/private-sms-communication/) use case. You download the code from <https://github.com/Nexmo/node-sms-proxy>.

## In this tutorial

In this tutorial you see how to build an SMS proxy for private communication system using Nexmo APIs and libraries:

* [Provision virtual numbers](#provision-virtual-numbers) - rent and configure the virtual numbers used to mask real numbers
* [Initiate private SMS communication](#initiate-private-sms-communication) - setup the conversation between two numbers
* [Validate numbers](#validate-numbers) - validate the numbers for two users and determine their country using Number Insight
* [Send a confirmation SMS](#send-a-confirmation-sms) - send an SMS to each user so they can interact securely using the provisioned virtual numbers
* [Handle inbound SMS](#handle-inbound-sms) - configure your webhook endpoint to handle incoming SMS, find the phone number it is associated with and tell Nexmo what to do with the message
* [Proxy the SMS](#proxy-the-sms) - send an SMS to the phone number the virtual number is associated with

## Prerequisites

For this tutorial you need a running Web server. The web server and SMS Proxy business logic is kept separate.

```js
var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.urlencoded({ extended: false }));

app.listen(app.get('port'), function() {
  console.log('SMS Proxy App listening on port', app.get('port'));
});
```

Now the basic server is in place you can focus on the SMS Proxy logic.

## Provision Virtual Numbers

Virtual numbers are used to hide real phone numbers from your application users.

The workflow diagram below shows the process for provisioning and configuring a virtual number.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
Note over App,Nexmo: Initialization
App->Nexmo: Search Numbers
Nexmo-->App: Numbers Found
App->Nexmo: Provision Numbers
Nexmo-->App: Numbers Provisioned
App->Nexmo: Configure Numbers
Nexmo-->App: Numbers Configured
```

To provision a virtual number you search through the available numbers that meet your criteria. For example, a phone number in a specific country with SMS capability:

```js
var Nexmo = require('nexmo');
var Promise = require('bluebird');

/**
 * Create a new SmsProxy
 */
var SmsProxy = function(config) {
  this.config = config;

  this.nexmo = new Nexmo({
      apiKey: this.config.NEXMO_API_KEY,
      apiSecret: this.config.NEXMO_API_SECRET
    },{
      debug: this.config.NEXMO_DEBUG
    });

  // Virtual Numbers to be assigned to UserA and UserB
  this.provisionedNumbers = [].concat(this.config.PROVISIONED_NUMBERS);

  // In progress conversations
  this.conversations = [];
};

/**
 * Provision two virtual numbers. Would provision more in a real app.
 */
SmsProxy.prototype.provisionVirtualNumbers = function() {
  // Buy a UK number with SMS capabilities.
  this.nexmo.number.search('GB', {features: 'SMS'}, function(err, res) {
    if(err) {
      console.error(err);
    }
    else {
      var numbers = res.numbers;

      // For demo purposes:
      // - Assume that at least two numbers will be available
      // - Rent just two virtual numbers: one for each conversation participant
      this.rentNumber(numbers[0]);
      this.rentNumber(numbers[1]);
    }
  }.bind(this));
};
```

You rent the numbers you want. When any even occurs relating to each number associated with an application Nexmo sends a request to your webhook endpoint with information about the event. After configuration you store the phone number for later user.

```js
/**
 * Rent the given number
 */
SmsProxy.prototype.rentNumber = function(number) {
  this.nexmo.number.buy(number.country, number.msisdn, function(err, res) {
    if(err) {
      console.error(err);
    }
    else {
      this.configureNumber(number);
    }
  }.bind(this));
};

/**
 * Check if the supplied number has already been stored as provisioned.
 */
SmsProxy.prototype.isProvisioned = function(checkNumber) {
  this.provisionedNumbers.forEach(function(number) {
    if(checkNumber.msisdn === number.msisdn) {
      return true;
    }
  });
  return false;
};

/**
 * Configure the number to be associated with the SMS Proxy application.
 */
SmsProxy.prototype.configureNumber = function(number) {
  this.nexmo.number.update(number.country, number.msisdn, {moHttpUrl: this.config.SMS_WEBHOOK_URL}, function(err, res) {
    if(err) {
      console.error(err);
    }
    else if(!this.isProvisioned(number)) {
      this.provisionedNumbers.push(number);
    }
  }.bind(this));
};
```

You now have the virtual numbers you need to mask communication between your users.

> **Note**: in a production application you choose from a pool of virtual numbers. However, you should keep this functionality in place to rent additional numbers on the fly.

## Initiate private SMS communication

The workflow when a conversation is created within the application is:

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
Note over App,Nexmo: Conversation Starts
App->Nexmo: Basic Number Insight
Nexmo-->App: Number Insight response
App->App: Map Real/Virtual Numbers\nfor Each Participant
App->Nexmo: SMS to UserA
Nexmo->UserA: SMS
App->Nexmo: SMS to UserB
Nexmo->UserB: SMS
```

First check the numbers, then save the conversation and finally send and SMS notification to each conversation participant.

```js
/**
 * Initiate anonymous SMS communication so there is a real/virtual mapping of numbers.
 */
SmsProxy.prototype.createConversation = function(userANumber, userBNumber, cb) {
  this.checkNumbers(userANumber, userBNumber)
    .then(this.saveConversation.bind(this))
    .then(this.sendSMS.bind(this))
    .then(function(conversation) {
      cb(null, conversation);
    })
    .catch(function(err) {
      console.error(err);
      cb(err);
    });
};
```

### Validate Numbers

When your application users supply their phone numbers use Number Insight to ensure that they are valid. You can also see which country the phone numbers are registered in.

```
/**
 * Ensure the given numbers are valid and which country they are associated with.
 */
SmsProxy.prototype.checkNumbers = function(userANumber, userBNumber) {
  var niGetPromise = Promise.promisify(this.nexmo.numberInsight.get, {context: this.nexmo.numberInsight});
  var userAGet = niGetPromise({level: 'basic', number: userANumber});
  var userBGet = niGetPromise({level: 'basic', number: userBNumber});

  return Promise.all([userAGet, userBGet]);
};
```

### Map Real to Virtual Numbers

Once you are sure that the phone numbers are valid, map each real number to a [virtual number](#provision-virtual-numbers) and save the information:

```js
/**
 * Store the conversation information.
 */
SmsProxy.prototype.saveConversation = function(results) {
  var userAResult = results[0];
  var userANumber = {
    msisdn: userAResult.international_format_number,
    country: userAResult.country_code
  };

  var userBResult = results[1];
  var userBNumber = {
    msisdn: userBResult.international_format_number,
    country: userBResult.country_code
  };

  // Create conversation object - for demo purposes:
  // - Use first indexed LVN for user A
  // - Use second indexed LVN for user B
  var conversation = {
    userA: {
      realNumber: userANumber,
      virtualNumber: this.provisionedNumbers[0]
    },
    userB: {
      realNumber: userBNumber,
      virtualNumber: this.provisionedNumbers[1]
    }
  };

  this.conversations.push(conversation);

  return conversation;
};
```

### Send a confirmation SMS

Send each user a confirmation SMS containing the virtual number for the other user.

```js
/**
 * Send an SMS to each conversation participant so they know each other's
 * virtual number and can SMS each other via the proxy.
 */
SmsProxy.prototype.sendSMS = function(conversation) {
  // Send UserA conversation information
  // From the UserB virtual number
  // To the UserA real number
  this.nexmo.message.sendSms(conversation.userB.virtualNumber.msisdn,
                             conversation.userA.realNumber.msisdn,
                             'Reply to this SMS to talk to UserB');

  // Send UserB conversation information
  // From the UserA virtual number
  // To the UserB real number
  this.nexmo.message.sendSms(conversation.userA.virtualNumber.msisdn,
                             conversation.userB.realNumber.msisdn,
                             'Reply to this SMS to talk to UserA');

  return conversation;
};
```

## Handle Inbound SMS

In an private communication system, when one user contacts another, he or she texts a virtual number from their phone. In this tutorial each user has received the virtual number in an SMS. In other systems this could be supplied using email, in-app notifications or a predefined number.

 When Nexmo receives an inbound SMS it makes an HTTP request to the webhook endpoint associated with the virtual number.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
Note over UserA,Nexmo: UserA sends SMS\nto UserB's\nVirtual Number
UserA->Nexmo: SMS to virtual number
Nexmo->App:Inbound SMS(from, to, text)
```

Retrieve the `to`, `from` and `text` from the inbound webhook:

```js
require('dotenv').config();
var config = require(__dirname + '/../config');

var SmsProxy = require('./SmsProxy');
var smsProxy = new SmsProxy(config);

app.post('/inbound-sms', function(req, res) {
  var from = req.body.msisdn;
  var to = req.body.to;
  var text = req.body.text;

  smsProxy.proxySms(from, to, text);

  res.sendStatus(200);
});
```

This information is passed to our voice proxy business logic.

## Reverse Map Real to Virtual Number

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
UserA->Nexmo:
Nexmo->App:
Note right of App:Find the real number for UserB
App->App:Number mapping lookup
```

Now you know the phone number sending the SMS and the virtual number of the recipient, reverse map the inbound virtual number to the outbound real phone number.

The SMS direction is identified as follows:

* the `from` number is UserA real number and the `to` number is UserB virtual number
* the `from` number is UserB real number and the `to` number is UserA virtual number

```js
var fromUserAToUserB = function(from, to, conversation) {
  return (from === conversation.userA.realNumber.msisdn &&
          to === conversation.userB.virtualNumber.msisdn);
};
var fromUserBToUserA = function(from, to, conversation) {
  return (from === conversation.userB.realNumber.msisdn &&
          to === conversation.userA.virtualNumber.msisdn);
};

/**
 * Work out real number to virual number mapping between users.
 */
SmsProxy.prototype.getProxyRoute = function(from, to) {
  var proxyRoute = null;
  var conversation;
  for(var i = 0, l = this.conversations.length; i < l; ++i) {
    conversation = this.conversations[i];

    // Use to and from to determine the conversation
    var fromUserA = fromUserAToUserB(from, to, conversation);
    var fromUserB = fromUserBToUserA(from, to, conversation);

    if(fromUserA || fromUserB) {
      proxyRoute = {
        to: fromUserA? conversation.userB : conversation.userA,
        from: fromUserA? conversation.userA : conversation.userB
      };
      break;
    }
  }

  return proxyRoute;
};
```

Now all you have to do is proxy the SMS.

## Proxy the SMS

Proxy the SMS to the phone number the virtual number is associated with. The `from` number is always the virtual number, the `to` is a real phone number.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
UserA->Nexmo:
Nexmo->App:
App->Nexmo:Send SMS (proxy)
Note right of App:Proxy Inbound\nSMS to UserB's\nreal number
Nexmo->UserB: SMS
Note over UserA,UserB:UserA has sent\nan SMS to UserB.\nBut UserA does\nnot have the\n real number\nof UserB, nor\n vice versa.
```

```js
SmsProxy.prototype.proxySms = function(from, to, text) {
  // Determine how the SMS should be routed
  var proxyRoute = this.getProxyRoute(from, to);

  if(proxyRoute === null) {
    var errorText = 'No booking found' +
                    ' from: ' + from +
                    ' to: ' + to;
    throw new Error(errorText);
  }

  // Always send
  // - from the virtual number
  // - to the real number
  this.nexmo.message.sendSms(proxyRoute.from.virtualNumber.msisdn,
                             proxyRoute.to.realNumber.msisdn,
                             text);
};
```

## Conclusion

And that's it. You have built an SMS Proxy for private communication. To do this you have provisioned and configured numbers, mapped real numbers to virtual numbers to ensure anonymity, handled inbound SMS and proxied the SMS to your users.

## Get the Code

All the code for this tutorial and more is [available on GitHub](https://github.com/Nexmo/node-sms-proxy).

## Resources

* [Number Insight API](/number-insight)
* [SMS Overview](/messaging/sms/overview)
* [SMS API reference guide](/api/sms)
