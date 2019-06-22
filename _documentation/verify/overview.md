---
title: Overview
meta_title: Enable 2FA with the Verify API
description: The Verify API overview.
---

# Verify API

The Verify API enables you to confirm that you can contact a user at a specific number.

* Protect against spam, by preventing spammers from creating multiple accounts
* Monitor suspicious activity, by forcing an account user to verify ownership of a number
* Reach your users at any time, by ensuring that you have their correct phone number

The general workflow is shown in the following sequence diagram:

```sequence_diagram
Participant User
Participant Your server
Participant Nexmo
User -> Your server: User supplies phone number
Your server -> Nexmo: Request to Verify this number
Nexmo --> Your server: Supply `request_id`
Note left of Nexmo: Nexmo sends PIN\n code to user\n (multiple attempts\n as needed)
Nexmo -> User: 
Nexmo --> User: 
User -> Your server: Enter PIN code
Your server -> Nexmo: Check PIN is valid for `request_id`
Nexmo --> Your server: OK
```

## Getting Started

The following sample shows you how to start the verification process by sending a verification code to a user. To learn how to validate the code the user supplies and perform other operations, see the [Code Snippets](/verify/overview#code-snippets).

```code_snippets
source: '_examples/verify/send-verification-request'
```

## Features

Nexmo Verify API offers powerful default behavior for easy integration. By default we will handle the code generation and verification, and deliver the message via the fastest route available. You can also control the user experience by defining which [workflow](/verify/guides/workflows-and-events) should be used for each request; by default Nexmo will use SMS followed by TTS and another TTS in most cases.

> It is possible to supply your own PIN code in some circumstances, please contact your account manager.

Delivery of the PIN code to the user uses a combination of SMS messages and [TTS](/concepts/guides/glossary#tts-api) (Text to Speech) calls based on the user's locale. For example, the TTS for a `61*` phone number is sent in English with an Australian accent (`en-au`). You can specify the language, accent and gender in the Verify request.

## Concepts

```concept_list
product: verify
```

## Code Snippets

```code_snippet_list
product: verify
```

## Use Cases

```use_cases
product: verify
```

## Further Reading

* [Verify API reference](/api/verify)
* [Implement the Verify API using Node.js](https://www.nexmo.com/blog/2018/05/10/nexmo-verify-api-implementation-guide-dr/)
* [Use the Verify API in iOS apps](https://www.nexmo.com/blog/2018/05/10/add-two-factor-authentication-to-swift-ios-apps-dr/)
* [Use the Verify API in Android apps](https://www.nexmo.com/blog/2018/05/10/add-two-factor-authentication-to-android-apps-with-nexmos-verify-api-dr/)
