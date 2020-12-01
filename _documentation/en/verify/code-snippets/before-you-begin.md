---
title: Before you begin
navigation_weight: 1
---

# Before you Begin

## What are Code Snippets?

Code snippets are short pieces of code you can reuse in your own applications.
The code snippets use code from [example repositories](https://github.com/topics/nexmo-quickstart).

Please read this information carefully before attempting to use the code snippets.

## Prerequisites

1. [Create a Vonage account](/account/guides/dashboard-management#create-and-configure-a-nexmo-account) - so that you can access your API key and secret to authenticate requests.
2. [Rent a Vonage Number](/numbers/guides/number-management#rent-a-virtual-number) - to send verification requests from.
3. [Install a Server SDK](/tools) - for your chosen programming language.

## Replaceable variables

The code snippets use placeholders for variable values that you must replace with your own details.

### Account

The following variables are specific to your Vonage account. You can view them in the [developer dashboard](https://dashboard.nexmo.com/):

```snippet_variables
- VONAGE_API_KEY
- VONAGE_API_SECRET
```

### Numbers

Replace the `RECIPIENT_NUMBER` placeholder with the number you are attempting to verify. For example: 447700900001.

All phone numbers must be in [E.164 format](/concepts/guides/glossary#e-164-format).

### Request ID

When you make an initial [verification request](/verify/code-snippets/send-verify-request), it returns a `request_id`. You use this in subsequent calls to the Verify API to identify a specific verification attempt.

Replace the `REQUEST_ID` placeholder with the `request_id` returned by the initial verification request.
