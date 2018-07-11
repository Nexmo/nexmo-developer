# Nexmo APIs Quickstart Examples for Node.JS


Quickstarts also available for: [Java](https://github.com/nexmo-community/nexmo-java-quickstart), [.NET](https://github.com/nexmo-community/nexmo-dotnet-quickstart), [PHP](https://github.com/nexmo-community/nexmo-php-quickstart), [Python](https://github.com/nexmo-community/nexmo-python-quickstart), [Ruby](https://github.com/nexmo-community/nexmo-ruby-quickstart)

The purpose of the quickstart guide is to provide simple examples focused on one goal. For example, sending an SMS, handling an incoming SMS webhook or making a Text to Speech call.

## Configure with Your Nexmo API Keys

To use this sample you will first need a [Nexmo account](https://dashboard.nexmo.com/sign-up). Once you have your own API credentials, rename
the `.env-example` file to `.env` and set the values as required.

For some of the examples you will need to [buy a number](https://dashboard.nexmo.com/buy-numbers).

## Tutorials & Sample Code

### SMS

| Tutorial                                 | Code Sample                              |
| ---------------------------------------- | ---------------------------------------- |
| [How to Send SMS Messages with Node.js and Express](https://www.nexmo.com/blog/2016/10/19/how-to-send-sms-messages-with-node-js-and-express-dr/) | [send-express.js](sms/send-express.js)   |
| [How to Receive SMS Messages with Node.js and Express](https://www.nexmo.com/blog/2016/10/27/receive-sms-messages-node-js-express-dr/) | [receive-express.js](sms/receive-express.js) |
| [How to receive an SMS Delivery Receipt from a Mobile Carrier with Node.js](https://www.nexmo.com/blog/2016/11/23/getting-a-sms-delivery-receipt-from-a-mobile-carrier-with-node-js-dr/) | [dlr-express.js](sms/dlr-express.js)     |

### Voice

| Tutorial                                 | Code Sample                              |
| ---------------------------------------- | ---------------------------------------- |
| [How to Make an Outbound Text-to-Speech Phone Call with Node.js](https://www.nexmo.com/blog/2017/01/12/make-outbound-text-speech-phone-call-node-js-dr/) | [make-calls.js](voice/make-call.js)      |
| [How to Handle Inbound Phone Calls with Node.js](https://www.nexmo.com/blog/2017/01/26/handle-inbound-text-speech-phone-call-node-js-dr/) | [receive-call-webhook.js](voice/receive-call-webhook.js) |
| How to Direct Inbound Phone Calls to an Endpoint with Failover with Node.js| [receive-call-webhook-failover.js](voice/receive-call-webhook-failover.js) |
| [How to Record Audio from Incoming Calls with Node.js](https://www.nexmo.com/blog/2017/02/06/how-to-record-audio-from-phone-call-node-js-dr/) | [record-call.js](voice/record-call.js)   |
| [How to Make a Private Phone Call with Node.js](https://www.nexmo.com/blog/2017/03/21/make-private-phone-call-node-js-dr/) | [proxy-call.js](https://github.com/nexmo-community/nexmo-node-quickstart/blob/master/voice/proxy-call.js) |

### Verify

| Tutorial                  | Code Sample                              |
| ------------------------- | ---------------------------------------- |
| Two-Factor Authentication | [2fa.js](https://github.com/nexmo-community/nexmo-node-quickstart/blob/master/verify/2fa.js) and [UI code](https://github.com/nexmo-community/nexmo-node-quickstart/tree/master/verify/views) |



## Request More Examples

Please [raise an issue](/../../issues/) to request an example that isn't present within the quickstart. Pull requests will be gratefully received.

## Licenses

- The code samples in this repo is under [MIT](LICENSE)

- The tutorials contents are under Creative Commons, [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode)

  ​
