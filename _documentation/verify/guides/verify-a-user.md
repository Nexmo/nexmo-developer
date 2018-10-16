---
title: Verify a user
---

# Verify a user

Using the Verify API, the workflow to confirm that your user can be contacted at a specific phone number is:

```js_sequence_diagram
Participant Your server
Participant Nexmo
Participant User phone
Your server-> Nexmo: 1. Send a phone verification code
Nexmo-->Your server: Receive `request_id`
Nexmo->User phone: 2. User receives code on \ntheir phone via a text \nmessage or text-to-speech
User phone->Your server: 3. User enters verification code
Your server->Nexmo: 4. check the phone verification \ncode and `request_id`
```

1. [Send a phone verification code](#request) and receive `request_id` from Nexmo
2. User receives code on their phone via a text message or text-to-speech
3. User enters verification code via a mechanism you provide, usually a form
4. You [check the phone verification code](#check) with Nexmo using code and `request_id`

You can optionally [cancel a phone verification request](#cancel) or [trigger the next verification process](#trigger) to advance from an SMS message verification to a text-to-speech verification.


⚓ request
## Send a phone verification code

Once you have collected a user's phone number, you can start the verification process by sending an API request to Nexmo with the user's phone number.

```tabbed_examples
source: '_examples/verify/building-blocks/send-verification-request'
```

The API will return a `request_id`. This is used in subsequent API calls.

⚓ check
## Check phone verification code

Your application should now show a form to allow the user to enter the PIN they have received. Once you have received the PIN, you should send it back to Nexmo along with the `request_id` from the first step. The API will tell you whether it is correct.

```tabbed_examples
source: '_examples/verify/guides/verify-a-user/check-verification-request'
```

⚓ cancel
## Cancel

If the user decides to cancel the verification process, you should send a cancellation request to Nexmo. This will prevent the verification process being completed even if the correct PIN is returned.

```tabbed_examples
source: '_examples/verify/guides/verify-a-user/cancel-verification-request'
```

⚓ trigger
## Trigger next verification process

The Verify API starts the verification process by sending a text message to the user. If the PIN is not confirmed, Nexmo will attempt to contact the user via voice call.

You can make the API switch to the next verification process by sending an API call to the Verify Control endpoint. In the context of integrating the Verify API into your application, you should generally send this call to the API if the user has confirmed they would prefer to get a phone call.

```tabbed_examples
source: '_examples/verify/guides/verify-a-user/trigger-next-verification-process'
```
