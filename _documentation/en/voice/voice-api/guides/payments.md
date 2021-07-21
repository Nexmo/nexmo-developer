---
title: Payments over the Phone
description: Take payments during phone calls in a PCI compliant secure way
navigation_weight: 11
---

# Payments over the Phone [Developer Preview]

_introduction here_

> Payments over the Phone are currently offered as [Developer Preview](/product-lifecycle/dev-preview). The feature can be used in your projects for supported scenarios (see below). The following limitations apply:
<ul style='list-style:disc;margin-left:16px;margin-top:16px;'><li style='margin-bottom:16px;'>payment gateway configuration is being done by request,</li>
<li style='margin-bottom:16px;'>`pay` action supported for inbound calls only,</li>
<li style='margin-bottom:16px;'>US dollars supported as the only currency,</li>
<li style='margin-bottom:16px;'>Visa and Mastercard cards supported only,</li>
<li style='margin-bottom:16px;'>[Stripe](https://www.stripe.com) supported as the only payment gateway,</li>
<li style='margin-bottom:16px;'>the feature is supported free of extra charge during Developer Preview.</li></ul>

## Preliminary Configuration

To start, you should have your Stripe account ready. If you don't have an account yet, sign up [here](https://dashboard.stripe.com/register).

In [Developer Preview](https://developer.vonage.com/product-lifecycle/dev-preview), Vonage will set up your payment gateway connector for you. [Contact Support](https://help.nexmo.com/hc/en-us/requests/new) to get it configured.

Your application should have Payments over the Phone capability enabled. In Developer Preview, that will be done by Vonage following the same Support request.

## Pay Action

To start the secure payment IVR, use `pay` [NCCO action](/voice/voice-api/guides/ncco):

```json
[
  {
     "action": "pay",
     "amount": 9.99
  }
]
```

This will trigger the IVR flow with the following prompts:
- _Please enter you long card number_
- _Please enter for digits of your card expiration date_
- _Please enter you three digits security code_

In case the user enters the card data correctly, they will be charged for $9.99 and your application will get the following callback:

```json
{
  from: '15551234567',
  to: '15557654321',
  type: 'payment',
  uuid: '041f4dffd9f4aa932512dd55e3abc123',
  conversation_uuid: 'CON-0e4a51ee-af50-41aa-bd2d-4e895edef456',
  status: 'success',
  timestamp: '2021-06-23T15:27:46.479Z'
}
```

and you will see the transaction in your [Stripe dashboard](https://dashboard.stripe.com/).

> In Developer Preview, `pay` action is only applicable for inbound calls and the first [leg of the conversation](/voice/voice-api/guides/legs-conversations) (the inbound one).

If the user doesn't enter the card number, expiration date or security code within 10 seconds, the prompt will be played one more time giving the user another try. If the user enters any of the card information incorrectly, or doesn't enter anything after the second prompt, the following callback is sent to the application:

```json
{
  from: '15551234567',
  to: '15557654321',
  type: 'payment',
  uuid: '041f4dffd9f4aa932512dd55e3abc123',
  conversation_uuid: 'CON-0e4a51ee-af50-41aa-bd2d-4e895edef456',
  status: 'failure',
  timestamp: '2021-06-23T15:27:46.479Z'
}
```

You can configure the following parameters of the `pay` action.

### Event URL

Similar to other actions, you can set a custom URL for the `pay` action status event by using `eventUrl` parameter:

```json
[
  {
     "action": "pay",
     "amount": 9.99,
     "eventUrl": [ "https://www.example.com/webhooks/pay"]
  }
]
```

### Amount

Set the `amount` to be charged in US dollars as in the sample above.

> In Developer Preview, only US dollars supported. More to come soon.

### Text to Speech Voice
You can select any of the supported Text to Speech voices and languages by adding the following parameters:

```json
[
  {
     "action": "pay",
     "amount": 9.99,
     "voice": {
       "language": "en-US',
       "style": 3
     },
     
  }
]
```

> In Developer Preview, default prompts are in English, to use any language except for English, you should provide custom prompts (see below).

### Custom Prompts
You can change the default IVR prompts to custom ones, including the prompts playing in case of timeout. To do that, provide `prompts` structure in the `pay` action as follows:

```json
[
  {
    "action": "pay",
    "amount": 9.99,
    "prompts": [
      {
        "type": "CardNumber",
        "text": "Your custom prompt for card number",
        "errors": {
          "InvalidCardType": {
            "text": "The type of your credit card is not supported. Please try another one"
          },
          "InvalidCardNumber": {
            "text": "Invalid credit card number. Please try again"
          },
          "Timeout": {
            "text": "Please enter your long credit card number"
          }
        }
      },
      {
        "type": "ExpirationDate",
        "text": "Please enter expiry date",
        "errors": {
          "InvalidExpirationDate": {
            "text": "Invalid expiration date. Please try again"
          },
          "Timeout": {
            "text": "Please enter your 4 digit credit card expiration date"
          }
        }
      },
      {
        "type": "SecurityCode",
        "text": "Please enter C V V",
        "errors": {
          "InvalidSecurityCode": {
            "text": "Invalid security code. Please try again"
          },
          "Timeout": {
            "text": "Please enter your 3 digit credit card security code"
          }
        }
      }
    ]
  }
]
```

## Further Reading
* [NCCO Reference](/voice/voice-api/ncco-reference#pay),
* [Webhook Reference](/voice/voice-api/webhook-reference#pay),
* [Contact Center Intelligence](/voice/voice-api/guides/cci) Guide.

> We appreciate your feedback! Do you need more currencies, payment gateways, outbound calls or any other `pay` action improvements? Please drop us a note at [vcp.product.voice@vonage.com](vcp.product.voice@vonage.com)!