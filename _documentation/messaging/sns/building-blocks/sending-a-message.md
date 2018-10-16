---
title: Sending a message
navigation_weight: 2
---

# Sending a message

You can send broadcast a message out to an SNS topic. Replace the following variables in the example below:

Key | Description
-- | --
`TO_NUMBER` | The number you would like to subscribe
`FROM_NUMBER` | The number you are sending the message from.
`API_KEY` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)
`API_SECRET` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)
`SNS_ARN` | The ARN for the SNS that you are broadcasting to. It's policy must allow the Nexmo user ID `564623767830` to subscribe & publish.

```sh
curl -X "POST" "https://sns.nexmo.com/sns/json?api_key=API_KEY&api_secret=API_SECRET" \
  -d "cmd=publish" \
  -d "topic=SNS_ARN" \
  -d "from=FROM_NUMBER"
  -d "message=A text message sent using the Nexmo SMS API" \
```
