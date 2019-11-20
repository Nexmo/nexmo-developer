---
title: Number Insight Advanced
navigation_weight: 4
---

# Number Insight Advanced

The Number Insight Advanced API provides all the data from the [Number Insight Standard API](/number-insight/code-snippets/number-insight-standard) together with the following additional information:

* If the number is likely to be valid
* If the number is ported
* If the number is reachable (not available in the US)
* If the number is roaming and, if so, the carrier and country

Use this information to determine the risk associated with a number.

> Note that the Advanced API does not provide any extra information about landlines than the [Number Insight Standard API](/number-insight/code-snippets/number-insight-standard). For insights about landline numbers, use the Standard API.

This code snippet shows you how to trigger an **asynchronous** call to the Number Insight API. __This is the approach Nexmo recommends__. You can optionally use the Number Insight Advanced API [synchronously](number-insight-advanced-sync), but be aware that synchronous use can result in timeouts.

Before attempting to run the code examples, replace the variable placeholders as instructed in [replaceable variables](before-you-begin#replaceable-variables).

```code_snippets
source: '_examples/number-insight/async-trigger'
```

The API acknowledges the request by returning the following information to the client:

```json
{
    "request_id": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
    "number": "447700900000",
    "remaining_balance": "10.000000",
    "request_price": "0.03000000",
    "status": 0
}
```

When the data becomes available, it is sent to the specified webhook via a `POST` request. See the [Number Insight Advanced Async Callback](/number-insight/code-snippets/number-insight-advanced-async-callback) code snippet to learn how to code the webhook handler.