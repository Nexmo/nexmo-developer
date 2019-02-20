---
title: Nexmo Send SMS Action
description: A GitHub Action for sending an SMS.
tags: ["GitHub","SMS","Action","Continuous Integration"]
cta: Use GitHub Action
link: https://github.com/nexmo-community/nexmo-sms-action
image: /assets/images/extend/github-mark.png
published: true
---

## Overview

The Nexmo Send SMS Action allows you to send SMS as part of a [GitHub Actions](https://github.com/features/actions) workflow. The passed in arguments represent the recipient and contents of the message.

For example:

```workflow
workflow "Send SMS On Push" {
  on = "push"
  resolves = ["notification"]
}

action "notification" {
    uses = "nexmo-community/nexmo-sms-action@master"
    secrets = [
        "NEXMO_API_KEY",
        "NEXMO_API_SECRET",
        "NEXMO_NUMBER"
    ]
    args = "15551234567 New pull on $GITHUB_REPOSITORY from $GITHUB_ACTOR."
}
```

will send New pull on `$GITHUB_REPOSITORY` from `$GITHUB_ACTOR` to 15551234567.

## Resources

* [GitHub Repository](https://github.com/nexmo-community/nexmo-sms-action)

## Support

This open source project is supported by the Nexmo DevRel team on a best effort basis, issues should be raised in the github repository.
