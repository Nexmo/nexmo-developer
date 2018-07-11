---
title: Number Insight Standard
navigation_weight: 2
---

# Number Insight Standard

You can use Nexmo's Number Insight Standard API to retrieve a user's landline or mobile number, including checking to see that it is registered to an operator. This can help you verify that a phone number is real and give you information on how to format the number.

Number Insight Standard API is a synchronous, easy-to-use RESTful web service. For any phone number you can:

* Retrieve the international and local format.
* Know the country where the number is registered.
* Line type detection (mobile/landline/virtual number/premium/toll-free)
* Detect mobile country code (MCC) and mobile network code (MNC)
* Detect if number is ported
* Identify caller name (USA only)
* Check if phone number is reachable

```tabbed_examples
source: '/_examples/number-insight/standard/'
```

The response from the API contains the following data:

```tabbed_examples
source: '/_examples/number-insight/response/standard/'
```
