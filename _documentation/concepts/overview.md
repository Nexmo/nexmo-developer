---
title: Overview
meta_title: Understanding core Nexmo concepts
---

# Concepts

There are a number of shared concepts between the Nexmo APIs: the use of JSON Web Tokens (JWTs), signed requests, and webhooks. The guides below explain in detail how to use these elements.

## Guides

* [Applications](/concepts/guides/applications) - Security and configuration information you need to connect to Nexmo endpoints.
* [Authentication](/concepts/guides/authentication) – API keys and JSON Web Tokens (JWTs).
* [Signing messages](/concepts/guides/signing-messages) – how to cryptographically sign messages and verify message signatures.
* [Webhooks](/concepts/guides/webhooks) – Nexmo's API can send data back to your web server via a webhook.
* [Glossary](/concepts/guides/glossary) – A glossary of common terms used throughout the Nexmo platform.

## Number format

Within the Nexmo APIs, all phone numbers are in [E.164 format](https://en.wikipedia.org/wiki/E.164). This means that numbers:

* Omit both a leading `+` and the international access code such as `00` or `001`. 
* Contain no special characters, such as space, `()` or `-`

For example, a US number would have the format `14155550101`. A UK number would have the format `447700900123`.

If you are unsure how to format the number, the [Number Insight API](/number-insight/overview) can be used to find correct information about a number.

See also [Number format](/voice/voice-api/guides/numbers) in the Voice API documentation.
