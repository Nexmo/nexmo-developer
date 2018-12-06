---
title: Verification workflow
description: The steps you need to take to verify a user's phone number.
navigation_weight: 1
---

# Verification Workflow

This is the workflow for verifying a user's phone number using the Verify API:

1. [Send a verification code](#send-a-verification-code) to the user and receive the `request_id` from Nexmo
2. The user receives a verification code on their phone via SMS or TTS (text-to-speech)
3. The user enters the verification code in your application
4. [Check the verification code](#check-the-verification-code) by making a request to the Verify API using the `request_id` and the code the user provides

You can optionally [cancel a verification request](#cancel-a-verification-request) or [trigger the next verification attempt](#trigger-the-next-verification-attempt) to advance from SMS message verification to TTS verification.

> For a full explanation of the verification steps and the timings associated with them, see [verification stages](verification-stages).

