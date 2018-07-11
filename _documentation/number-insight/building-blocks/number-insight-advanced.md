---
title: Number Insight Advanced
navigation_weight: 3
---

# Number Insight Advanced

You can use Nexmo's Number Insight Advanced API to retrieve a user's landline or mobile number, including checking to see that it is registered to an operator. This can help you verify that a phone number is real and give you information on how to format the number.

Number Insight Advanced Async API is a synchronous, easy-to-use RESTful web service. For any phone number you can:

* Retrieve the international and local format.
* Know the country where the number is registered.
* Line type detection (mobile/landline/virtual number/premium/toll-free)
* Detect mobile country code (MCC) and mobile network code (MNC)
* Detect if number is ported
* Identify caller name (USA only) - see the [CNAM guide](/number-insight/guides/cnam) for details
* Identify network when roaming
* Confirm user's IP address is in same location as their mobile phone

Users are advised that the Advanced API does not give any information about landlines that is not already given by the [Standard API](/number-insight/building-blocks/number-insight-standard). For number insights about landlines, you should use the [Standard API](/number-insight/building-blocks/number-insight-standard).

```tabbed_examples
source: '/_examples/number-insight/advanced/'
```

The response from the API contains the following data:

```tabbed_examples
source: '/_examples/number-insight/response/advanced/'
```
