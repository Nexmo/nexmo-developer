---
title: Subscribe your users to an Amazon SNS topic and notify them by SMS
description: You use Nexmo SNS to subscribe your users to a topic and notify them about updates.
---

# Nexmo SNS Overview

You use Nexmo SNS to easily subscribe your users to a topic and automatically send them an SMS when you publish a new message.

The workflow for Nexmo SNS is:

1. [Setup SNS access](#setup-sns-access)
2. [Subscribe users to your topic](#subscribe-users-to-your-topic)
3. [Publish a message notification to your users for your topic](#publish-messages-to-your-topic).

## Setup SNS access

SNS access is associated with your Amazon SNS account. To configure SNS:

1. Create your Amazon SNS account from: <http://aws.amazon.com/sns/>.
2. In [SNS dashboard](https://console.aws.amazon.com/sns/home), click *Topics*, then *Create new topic*.
3. In *Create new topic* fill in the form, then click *Create Topic*.
4. In *Actions*, select your topic, then click *edit topic policy*.
5. For *Publishers* and *Subscribers*, add the Nexmo account number (*564623767830*) to *Only these AWS users*, then click *Update Policy*.

The following sections explain how to use the REST API for Nexmo SNS. You can also use [Nexmo Java](https://github.com/Nexmo/nexmo-java) for SNS.

## Subscribe users to your topic

Using the Nexmo SNS API you:
1. Subscribe your users to your topic using a [request](#subscribe-request).
2. Receive a [response](#subscribe-response) and check that the subscription succeeded.

### Subscribe request

A subscribe request to the SNS API looks like:

```
https://sns.nexmo.com/sns/json?api_key=xxxxxxxx&api_secret=xxxxxxxx&to=xxxxxxxxxxxx&cmd=subscribe&topic=arn:aws:sns:<zone>:1:1:<ID>:<channel name>
```

All requests to the SNS API must contain:

* `https://sns.nexmo.com/sns`
* A response object: `json` or `xml`

Your base URL becomes either:

JSON | XML
-- | --
`https://sns.nexmo.com/sns/json` | `https://sns.nexmo.com/sns/xml`

As well as your `api_key` and `api_secret`, the following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`cmd` | Set to `subscribe` | Yes
`to` | The phone number of the user you are subscribing to your topic in [E.164](https://en.wikipedia.org/wiki/E.164). For example, `to=447700900000`. You can set one recipient only for each request. | Yes
`topic` | Your SNS Topic. For example, `topic=arn:aws:sns:us-east:1:1:000000000000:my_sms_channel` | Yes

### Subscribe Response

The following table shows example responses in JSON or XML:

```tabbed_examples
source: '_examples/messaging/sns/subscribe-response'
```

## Publish messages to your topic

Using the Nexmo SNS API you:

1. Publish a notification message to the users subscribed to your topic using a [request](#publish-request).
2. Receive a [response](#publish-response) and check that your message has been published.

### Publish request

A publish request to the SNS API looks like:

```
https://sns.nexmo.com/sns/json?api_key=xxxxxxxx&api_secret=xxxxxxxx&from=xxxxxxxxxxxx&cmd=publish&topic=arn:aws:sns:us-east:1:1:000000000000:my_sms_channel&message=Nexmo SNS is cool
```

All requests to the SNS API must contain:

* `https://sns.nexmo.com/sns`
* A response object: `json` or `xml`

Your base URL becomes either:

JSON | XML
-- | --
`https://sns.nexmo.com/sns/json` | `https://sns.nexmo.com/sns/xml`

As well as your `api_key` and `api_secret`, the following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`cmd` | Set to `publish`. | Yes
`to` | Leave this blank to publish to all subscribers. The phone number of the user you are publishing your topic in [E.164](https://en.wikipedia.org/wiki/E.164) to. For example, `to=447700900000`. You can set one recipient only for each request. | Yes
`topic` | Your SNS Topic. For example, `topic=arn:aws:sns:us-east:1:1:000000000000:my_sms_channel` | Yes
`from` | An alphanumeric string giving your sender address. For example, `from=MyCompany20`. See our information in [Global messaging](/messaging/sms/guides/global-messaging). This is also called the SenderID. | Yes
`message` | The message to publish to your users. | Yes

> Note: to publish a message directly to a topic with using *sns.nexmo.com/sns.json*, set sender as the subject and put your message in the body.

### Publish Response

The following table shows example responses in JSON or XML:

```tabbed_examples
source: '_examples/messaging/sns/publish-response'
```
