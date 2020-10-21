---
title: Configure Account Webhooks
description: Walk-through about how to configure account webhooks for SMS
---

# Configure Account Webhooks

In order to receive SMS messages and DLRs you will need to set two account level settings. Your account level Delivery Receipt and Inbound Messages URL. You can find this in your [dashboard account settings page](https://dashboard.nexmo.com/settings).

Set these URLs to, replacing `NGROK_HOST_NAME` with your ngrok host name

* Inbound Messages: http://NGROK_HOST_NAME/webhooks/inbound-sms
* Delivery Receipts: http://NGROK_HOST_NAME/webhooks/dlr
