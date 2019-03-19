---
title: Subscribe a user
navigation_weight: 1
---

# Subscribe a user

You can subscribe a user to a topic using Amazon SNS. [Sign up for an account](https://dashboard.nexmo.com/sign-up) and replace the following variables in the example below:

Key | Description
-- | --
`TO_NUMBER` | The number you would like to subscribe
`API_KEY` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)
`API_SECRET` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)
`SNS_ARN` | The ARN for the SNS that you are subscribing the user to. It's policy must allow the Nexmo user ID `564623767830` to subscribe & publish.

```sh
curl -X "POST" "https://sns.nexmo.com/sns/json?api_key=API_KEY&api_secret=API_SECRET" \
  -d "cmd=subscribe" \
  -d "to=TO_NUMBER" \
  -d "topic=SNS_ARN"
```
