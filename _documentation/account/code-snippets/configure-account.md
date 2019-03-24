---
title: Configure account
navigation_weight: 1
---

# Configure the settings for your account

You can programmatically configure the settings for your account, such as the callback URLs that the webhooks will use.

# Example

This example shows how to set the URL that will be called when your Nexmo number receives an SMS.

Key |	Description
-- | --
`SMS_CALLBACK_URL` | The publicly-accessible URL that Nexmo should send information to when your Nexmo number receives an SMS

```building_blocks
source: _examples/account/configure-account
```

The example outputs the current settings of your account, after it was updated with the new URL.

