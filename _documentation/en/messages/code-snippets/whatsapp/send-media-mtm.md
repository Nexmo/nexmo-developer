---
title: Send a Media Message Template MTM
meta_title: Send a WhatsApp Media Message Template using the Messages API
navigation_weight: 2
---

# Send a WhatsApp Media Message Template (MTM)

In this code snippet you will see how to send a WhatsApp Media Message Template using the Messages API.

To send the Media Message Template you need to use the Messages custom object. The custom object takes a partial section of the original WhatsApp API request and sends it directly through to WhatsApp.

WhatsApp Media Templates consist of a Header, Body and Footer structure. The Header contains the media, which can be text, location, video, image or file. The Body contains the text message. This is currently limited to 160 characters when displayed to the end user, so as to avoid the need for scrolling. The Footer is optional and contains static text only.

> **IMPORTANT:** If a customer messages you, you have 24 hours to respond to the customer with a free form message. After this period you must use a template message (MTM). If a customer has not messaged you first, then the first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

``` json
{
  "from": {
    "type": "whatsapp",
    "number": "$WHATSAPP_NUMBER"
  },
  "to": {
    "type": "whatsapp",
    "number": "$TO_NUMBER"
  },
  "message": {
    "content": {
      "type": "custom",
      "custom": {
        "type": "template",
        "template": {
          "namespace": "whatsapp:hsm:technology:nexmo",
          "name": "parcel_location",
          "language": {
            "policy": "deterministic",
            "code": "en"
          },
          "components": [
            {
              "type": "header",
              "parameters": [
                {
                  "type": "location",
                  "location": {
                    "longitude": -122.425332,
                    "latitude": 37.758056,
                    "name": "Facebook HQ",
                    "address": "1 Hacker Way, Menlo Park, CA 94025"
                  }
                }
              ]
            },
            {
              "type": "body",
              "parameters": [
                {
                  "type": "text",
                  "text": "Value 1"
                },
                {
                  "type": "text",
                  "text": "Value 2"
                },
                {
                  "type": "text",
                  "text": "Value 3"
                }
              ]
            }
          ]
        }
      }
    }
  }
}
```

## Try it out

When you run the code a WhatsApp Media Template Message is sent to the destination number.

## Further information

* [Custom objects](/messages/concepts/custom-objects)
