# Getting Started with Nexmo SMS APIs with Node.js

## Set up the ENV with Your Nexmo API Keys

To use this sample you will first need a [Nexmo account](https://dashboard.nexmo.com/sign-up). Once you have your own API credentials, rename
the `.env-example` file to `.env` and set the values as required.

You also need to [buy a number](https://dashboard.nexmo.com/buy-numbers) where you can send and receive SMS messages.

## Run the Examples

Run a node script from terminal:

```bash
$ node you_dir/send.js
```

To run "send" examples, just set up your ENV and run locally.

To run "receive" examples, you need to run the webhook file on a server, or tunnel from your local server using the services like [ngrok](https://ngrok.com/). See the tutorials for more details.

## Tutorials

### SMS

| Tutorial                                 | Code Sample                              |
| ---------------------------------------- | ---------------------------------------- |
| [How to Send SMS Messages with Node.js and Express](https://www.nexmo.com/blog/2016/10/19/how-to-send-sms-messages-with-node-js-and-express-dr/) | [send-express.js](https://github.com/nexmo-community/nexmo-node-quickstart/blob/master/sms/send-express.js) |
| [How to Receive SMS Messages with Node.js and Express](https://www.nexmo.com/blog/2016/10/27/receive-sms-messages-node-js-express-dr/) | [receive-express.js](https://github.com/nexmo-community/nexmo-node-quickstart/blob/master/sms/receive-express.js) |
| [How to receive an SMS Delivery Receipt from a Mobile Carrier with Node.js](https://www.nexmo.com/blog/2016/11/23/getting-a-sms-delivery-receipt-from-a-mobile-carrier-with-node-js-dr/) | [dlr-express.js](https://github.com/nexmo-community/nexmo-node-quickstart/blob/master/sms/dlr-express.js) |

### 

