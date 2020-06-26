---
title: Messages API Sandbox
navigation_weight: 5
description: Understanding and utilizing the Messages API Sandbox.
---

# Messages API Sandbox

The Messages API Sandbox provides a quick and easy method for sending test messages using the Vonage Messages API on supported messaging platforms without requiring the setup of business accounts on any of those platforms. This means you can code your application now while you wait for your business accounts to be created and approved. A sandbox can only be associated with one API key and supports the following three channels:

* WhatsApp
* Viber
* Facebook Messenger

You can setup multiple sandboxes, however, each sandbox must be associated with a different API key. In order to use the sandbox to send test messages on any of the supported channels, you must whitelist your number (WhatsApp and Viber) or recipient ID (Facebook Messenger) on each of the sandbox channels you want to test. Your number or ID can only be whitelisted in one sandbox at a time. If you whitelist yourself in a different sandbox, you will no longer be whitelisted in the previous sandbox.

The Messages API Sandbox is accessible via the [Dashboard](https://dashboard.nexmo.com/messages/sandbox). You can use it to test your integration prior to sending production traffic. Sandbox Messages API requests are sent to a different endpoint than production requests and the Vonage sandbox external account number or ID is used as the `from` value in the request.

## Messages API Sandbox Pricing

The Messages API Sandbox is currently free to use.

## Sandbox supported features

The following table shows the supported features of the Messages Sandbox compared to the production Messages API:

Feature | Messages Sandbox | Messages API
|:----|:----:|:----:|
WhatsApp Outbound | ✅ | ✅
WhatsApp Inbound  | ✅  |✅
Your own WhatsApp Numbers | ❌ | ✅
Your own WhatsApp Templates | ❌ | ✅
Viber Outbound  | ✅ | ✅
Viber Inbound  | ✅ | ✅
Use your own Viber account | ❌ | ✅
Facebook Messenger Outbound | ✅  |✅
Facebook Messenger Inbound | ✅  |✅
Your Own Messenger Page | ❌ | ✅
Signed Webhooks | ✅ | ✅
SMS Outbound | ❌ | ✅
MMS Outbound | ❌ | ✅
MMS Inbound | ❌ | ✅

**Key:**

* ✅ = Supported.
* ❌ = Not supported

## Using the sandbox

The steps to use the Messages API Sandbox to send test messages on supported messaging platforms are as follows:

1. [Setup your sandbox](#setup-your-sandbox)
2. [Whitelist yourself](#whitelist-yourself)
3. [Configure webhooks](#configure-webhooks)
4. [Send a message using the sandbox](#send-a-test-message-via-the-messages-api-sandbox)

## Setup your sandbox

Setup up your sandbox channels and invite team members to use them to send test messages on them using the Vonage Messages API.

1. Navigate to the [Messages API Sandbox](https://dashboard.nexmo.com/messages/sandbox) on the Dashboard.
2. If you have multiple API keys available in the **API Key** drop-down list, select the API key to associate with the sandbox you are setting up.
3. Click the **Add to sandbox** link associated with the channel you want to setup.
4. Invite team members to whitelist their numbers or recipient IDs on any of the three supported sandbox channels by selecting their names in the **Send invite email** drop-down list. You can invite new team members by clicking **Invite a new user to your team** and adding them on the **Team members** page.
5. [Whitelist yourself](#whitelist-yourself) on any of the three supported sandbox channels.

## Whitelist yourself

In order to use the Messages API Sandbox to test sending messages on messaging platforms such as Facebook Messenger, Viber, and WhatsApp, you must first whitelist your number (WhatsApp and Viber) or Recipient ID (Facebook Messenger) by sending a message with a passphrase to a sandbox external account.

The procedure for whitelisting yourself differs slightly depending on the sandbox channel:

* [Whitelist your WhatsApp number](#whitelist-your-whatsapp-number)
* [Whitelist your Viber number](#whitelist-your-viber-number)
* [Whitelist your Facebook Messenger recipient ID](#whitelist-your-facebook-messenger-recipient-id)

### Whitelist your WhatsApp number

1. On either the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or your email invitation, use the camera on your mobile device to scan the WhatsApp QR code or follow the link provided. A WhatsApp message draft opens in WhatsApp. A passphrase populates the message field and the Vonage WhatsApp sandbox account number is set as the message recipient.
2. Tap the send button. You will receive a reply from the Vonage WhatsApp sandbox account. Your WhatsApp number is now whitelisted in the sandbox. If you want to test inbound messages or receive status callbacks, you will need to [provide webhooks](#configure-webhooks) prior to [sending a message](#send-a-test-message-via-the-messages-api-sandbox).

### Whitelist your Viber number

**Viber for Android**

1. Open the Viber app on your mobile device.
2. Tap the More tab (bottom-right).
3. Tap the QR code button icon to open the Viber QR scanner.
4. Scan the QR code displayed on either the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or your email invitation. A draft message addressed to Vonage Sandbox opens.
5. In the message field, type the passphrase provided either on the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or in your email invitation.
6. Tap the send button. Your Viber number is now whitelisted in the sandbox. If you want to test inbound messages or receive status callbacks, you will need to [provide webhooks](#configure-webhooks) prior to [sending a message](#send-a-test-message-via-the-messages-api-sandbox).

**Viber for iOS**

1. Open the camera app on your iPhone.
2. Scan the QR code displayed on either the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or your email invitation. A draft message addressed to Vonage Sandbox opens.
3. In the message field, type the passphrase provided either on the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or in your email invitation.
4. Tap the send button. Your Viber number is now whitelisted in the sandbox. If you want to test inbound messages or receive status callbacks, you will need to [provide webhooks](#configure-webhooks) prior to [sending a message](#send-a-test-message-via-the-messages-api-sandbox).

### Whitelist your Facebook Messenger Recipient ID

1. Open the camera app on your mobile device.
2. Scan the QR code displayed on either the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or your email invitation. A draft message addressed to Vonage Sandbox opens.
3. In the message field, type the passphrase provided either on the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) or in your email invitation.
4. Tap the send button. Your Facebook Messenger recipient ID is now whitelisted in the sandbox. If you want to test inbound messages or receive status callbacks, you will need to [provide webhooks](#configure-webhooks) prior to [sending a message](#send-a-test-message-via-the-messages-api-sandbox).

## Configure webhooks

1. Enter your application's **Inbound** webhook URL. The inbound webhook is the URL to which inbound messages are forwarded.
2. Enter your application's **Status** webhook URL. The status webhook is the URL at which you will receive message status updates.
3. Click the **Save webhooks** button.

![Configure webhooks](/assets/images/messages/config-webhooks.png)

### Webhook Retries

Inbound and Status webhooks are retried on a per-notification basis in the Messages API Sandbox. Any non 200 response to a webhook will prompt Vonage to retry periodically at intervals of increasing length: 5, 10, 20, 40, 80, 160, 320, 640, and then every 900 seconds for 24 hours.

## Send a test message via the Messages API Sandbox

Once your number or recipient ID is added to the whitelist, you will use a Messages API Sandbox endpoint to send your test messages. The `from` value in the request should be the ID or number associated with the specific Vonage Sandbox external account. For your testing purposes, the value in the `from` field is already populated in the code snippets provided in the [Dashboard](https://dashboard.nexmo.com/messages/sandbox). It is important to note that you will need to replace the value in the `to` field with your number or Recipient ID that is whitelisted on the specific Vonage Sandbox external account.

1. Create a new file for each of the sandbox channels on which you want to send and receive messages. For instance `whatsapp-sandbox-message.sh`.
2. Copy the code snippet for the appropriate channel from the code provided in the [Dashboard](https://dashboard.nexmo.com/messages/sandbox) and paste it into the file you just created.
3. Replace the value in the `to` field with your number (WhatsApp or Viber) or Recipient ID (Facebook Messenger) that is whitelisted in the sandbox.
4. Save the file and run it.

## WhatsApp Templates for use with the Messages API Sandbox

At the moment the following WhatsApp templates can be used with the Messages API Sandbox:

Namespace | Name | Template Structure |Languages
----|----|----|----
`9b6b4fcb_da19_4a26_8fe8_78074a91b584` | `verify` | Header: `none`<br>Body: `{{1}} code: {{2}}. Valid for {{3}} minutes.`<br>Footer: `none` |English, Korean, Japanese, Italian
