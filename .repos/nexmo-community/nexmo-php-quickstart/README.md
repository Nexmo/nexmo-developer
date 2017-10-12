# Nexmo APIs Quickstart Examples for PHP

The purpose of the quickstart guide is to provide simple PHP examples focused on one goal. For example, sending an SMS, receiving an SMS via an incoming SMS webhook or making a Text to Speech call.

Quickstarts also available for: [Java](https://github.com/nexmo-community/nexmo-java-quickstart), [.NET](https://github.com/nexmo-community/nexmo-dotnet-quickstart), [Node.js](https://github.com/nexmo-community/nexmo-node-quickstart), [Python](https://github.com/nexmo-community/nexmo-python-quickstart), [Ruby](https://github.com/nexmo-community/nexmo-ruby-quickstart)

## Configure with Your Nexmo API Keys

To use this sample you will first need a [Nexmo account](https://dashboard.nexmo.com/sign-up). Once you have your own API credentials, rename
the `.env-example` file to `.env` and set the values as required.

For some of the examples you will need to [buy a number](https://dashboard.nexmo.com/buy-numbers).

## Examples

### SMS

| Code Sample                              |
| ---------------------------------------- |
| [Send an SMS](sms/send-sms.php)   |
| [Receive an SMS](sms/receive-sms.php) |
| [Receive a Delivery Receipt](sms/receive-delivery-receipt.php)     |

### Voice

| Code Sample                              |
| ---------------------------------------- |
| [Make a Phone Call](voice/text-to-speech-outbound.php)      |
| [Receive a Phone Call](voice/text-to-speech-inbound.php) |
| [Play Text-to-Speech](voice/text-to-speech-inbound.php) |
| [Connect a Call](voice/connect-a-call.php)   |
| [Join a Conference Call](voice/conference-call.php)   |

### Verify

| Code Sample                              |
| ---------------------------------------- |
| Send Phone Verification Code | [verify/request.php] |
| Check Phone Verification Code | [verify/verify.php] |
| Cancel Phone Verification | [verify/cancel.php] |



## Request More Examples

Please [raise an issue](/../../issues/) to request an example that isn't present within the quickstart. Pull requests will be gratefully received.

## Licenses

- The code samples in this repo is under [MIT](LICENSE)

  ​