---
title: Overview
meta_title: Enable 2FA with the Verify API
description: The Verify API enables you to confirm that you can contact a user at a specific number. (Nexmo is now Vonage)
---

# Verify API

The Verify API enables you to confirm that you can contact a user at a specific number, so that you can:

* Reach your users at any time, by ensuring that you have their correct phone number
* Protect against fraud and spam, by preventing one user from creating multiple accounts
* Add an extra layer of security to help confirm a user's identity when they want to perform certain activities


## How it works

Verification is a two-stage process that requires two API calls:

### Verification request

![Starting the verification process](/images/verify-request-diag.png)

1. A user registers for your service via your app or web site and provides a phone number.
  
2. To confirm that the user has access to the number that they have registered with, your application makes an API call to the [Verification request endpoint](/api/verify#verifyRequest).
  
3. The Verify API generates a PIN code, with an associated `request_id`.
  
    > It is possible to supply your own PIN code in some circumstances, please contact your account manager.
    
4. The Verify API then attempts to deliver this PIN to the user. The format (SMS or Text-to-speech (TTS)) and timing of these attempts are defined by your chosen [workflow](/verify/guides/workflows-and-events).
    If the user does not revisit your app or website to enter the PIN they have received, the verification request will ultimately time out. Otherwise, you need to verify the number that they entered using by performing a Verification check.

### Verification check

![Verifying the submitted PIN](/images/verify-check-diag.png)

**5**\. The user receives the PIN and enters it into your application.

**6**\. Your application makes an API call to the [Verification check endpoint](/api/verify#verifyCheck), passing in the `request_id` and the PIN that the user entered.

**7**\. The Verify API checks that the PIN entered matches the one that was sent and returns the result to your application.

## Getting Started

The following sample shows you how to start the verification process by sending a verification code to a user. To learn how to validate the code the user supplies and perform other operations, see the [Code Snippets](/verify/overview#code-snippets).

```code_snippets
source: '_examples/verify/send-verification-request'
```



## Guides

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
