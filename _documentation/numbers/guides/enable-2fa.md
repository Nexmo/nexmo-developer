---
title: Enable 2FA with a Short Code
description: Use a short code to verify that your user owns the phone number they have registered for your service with
navigation_weight: 2
---

# Enable Two-Factor Authentication

[Two-factor authentication](/concepts/guides/glossary#2fa) (2FA) gives you confidence that the number your customer provides you with belongs to them. If you are sending SMS to customers in the US, you can use a [short code](/concepts/guides/glossary#short-code) for this. A customer verifies their number by responding directly to the short code or via your web application. Nexmo's [Two-Factor Authentication API](/api/sms/us-short-codes/2fa) provides this capability. 

> These instructions assume that you are using a shared short code. Nexmo also offers dedicated short codes specific to your organisation. Find out more about short codes [here](https://help.nexmo.com/hc/en-us/articles/115013144287-Short-codes-Features-Overview).

To configure a shared US short code for 2FA:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click **Numbers** then **Buy numbers**.
3. Click the **add a shared short code** link.
4. Click the **Add a short code for two factor authentication** button.
5. Configure your message and company name.
6. Click **Update**. Nexmo will process your application. Approval can take up to five business days.

When you use a pre-approved US short code from Nexmo, you **MUST** display the following information on your site's opt-in page:

  * Frequency: How often users of your service can expect to receive messages from you
  * How to opt out: Send a `STOP` SMS to your short code.
  * How to get help: Send a `HELP` SMS to your short code.
  * The cost to your users to receive your messages (message and data rate)
  * The terms and conditions for your service
  * Your privacy policy

Example:

```
You will receive no more than 2 msgs/day. To opt-out at any time, send STOP to 98765.
To receive more information, send HELP to 98765. Message and data rates may apply.
The terms and conditions can be viewed at <http://url.to/your_t&c.html>. 
Our Privacy Policy can be reviewed at <http://url.to/your_privacypolicy.html>.
```