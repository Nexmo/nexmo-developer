---
title: Send an SMS from the Python REPL
description: Send an SMS from the command line.
---

# Send an SMS from the Python REPL

First, run python from the command-line, and then enter the three lines below.

```
>>> import nexmo
>>> client = nexmo.Client(key='YOUR-API-KEY', secret='YOUR-API-SECRET')
>>> client.send_message({'from': 'Vonage', 'to': 'YOUR-PHONE-NUMBER', 'text': 'Hello world'})
{'message-count': '1', 'messages': [{'to': 'YOUR-PHONE-NUMBER', 'message-id': '0D00000039FFD940', 'status': '0', 'remaining-balance': '14.62306950', 'message-price': '0.03330000', 'network': '12345'}]}
```

These lines of code perform three actions.
* The first line imports `nexmo-python`.
* The second line creates a `Client` object, which can be re-used, and knows your Vonage API key and the secret associated with it.
* The third line actually sends the SMS message.

Hopefully, you received an SMS message! If not, check the contents of the response, the [error messages](https://help.nexmo.com/hc/en-us/articles/204014733-Nexmo-SMS-Delivery-Error-Codes) may be quite helpful.

`send_message` returns a dictionary, which tells you how many messages your SMS was divided into, and how much it cost you to send the message. Longer messages will need to be sent as multiple messages. Vonage will divide these messages up for you, and the SMS client on the phone will automatically reassemble them into the original long message, but this costs more than a short message.