---
title: Cancel verification request
navigation_weight: 4
---

# Cancel verification request

If the user decides to cancel the verification process, you should send a [control request](/api/verify#verify-control) to the Verify API. This will terminate the verification process even if the user supplied the correct code.

```building_blocks
source: '_examples/verify/cancel-verification-request'
```
