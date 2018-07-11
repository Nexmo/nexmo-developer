---
title: Number Insight Advanced Async
navigation_weight: 4
---

# Number Insight Advanced Async

You can use Nexmo's Number Insight Async API to retrieve a user's landline or mobile number, including checking to see that it is registered to an operator. This can help you verify that a phone number is real and give you information on how to format the number.

Number Insight Advanced Async API is an asynchronous web service that returns data to a webhook. For any phone number you can:

* Retrieve the international and local format.
* Know the country where the number is registered.
* Line type detection (mobile/landline/virtual number/premium/toll-free)
* Detect mobile country code (MCC) and mobile network code (MNC)
* Detect if number is ported
* Identify caller name (USA only)
* Identify network when roaming
* Confirm user's IP address is in same location as their mobile phone

Users are advised that the Advanced API does not give any information about landlines that is not already given by the [Standard API](/number-insight/building-blocks/number-insight-standard). For number insights about landlines, you should use the [Standard API](/number-insight/building-blocks/number-insight-standard).

```tabbed_examples
source: '/_examples/number-insight/async/'
```

The API will respond with an acknowledgment of the response:

```tabbed_examples
source: '/_examples/number-insight/response/async/'
```
