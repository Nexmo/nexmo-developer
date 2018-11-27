---
title: Configure webhooks
navigation_weight: 4
---

# Inbound message and message status webhooks

If you want to handle an inbound message or receive message status updates, you need to configure your inbound message webhook and message status webhook.

```partial
source: _partials/reusable/configure-webhook-urls.md
```

> **NOTE:** Messages and Dispatch API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks described in the previous section. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).
