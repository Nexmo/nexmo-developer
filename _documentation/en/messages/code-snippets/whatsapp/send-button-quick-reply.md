---
title: Send a Quick Reply Button
meta_title: Send a quick reply button on WhatsApp using the Messages API
---

# Send a Quick Reply Button

In this code snippet you learn how to send a quick reply style button on WhatsApp. This uses Nexmo's [custom object](/messages/concepts/custom-objects) facility. You can reference the WhatsApp developer docs for the specifics of the [message format](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/interactive-message-templates).

When the message recipient clicks on the quick reply button, Nexmo will `POST` relevant data to your inbound message webhook URL.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-button-quick-reply'
application:
  type: messages
  name: 'Send a quick reply button to WhatsApp'
```

## Try it out

When you run the code a WhatsApp reminder message is sent to the destination number. The message has two quick reply buttons which you can use to select whether you are going to the event or not. When a button is pressed data similar to the following is posted to your inbound webhook URL:

``` json
{
    "message_uuid": "28ee5a1c-c4cc-48ec-922c-01520d4d396b",
    "to": {
        "number": "447700000000",
        "type": "whatsapp"
    },
    "from": {
        "number": "447700000001",
        "type": "whatsapp"
    },
    "timestamp": "2019-12-03T12:45:57.929Z",
    "direction": "inbound",
    "message": {
        "content": {
            "type": "button",
            "button": {
                "payload": "Yes-Button-Payload",
                "text": "Yes"
            }
        }
    }
}
```

In this example the recipient clicked the yes button.

## Further information

* [Custom objects](/messages/concepts/custom-objects)
* [WhatsApp documentation for Quick Reply Button](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/interactive-message-templates)
