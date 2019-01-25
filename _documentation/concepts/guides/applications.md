---
title: Applications
Description: A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products.
navigation_weight: 1
---

# Application Overview

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products. You use one or more applications to supply a service based on a Nexmo Product. For example, you may create one Voice application to record calls to your support center, and another application for internal conferences.

![Application API Workflow](/assets/images/capi_architecture.svg)

## Structure

Each application has the following

Name | Description
-- | --
`msisdn` | A virtual phone number that you rent from Nexmo and is associated with this application.
`type` | Describes the Nexmo API you access for your application. Possible values: `voice`, `messages`, `rtc`
`private_key` | You use the private key to generate the JWTs used to authenticate your calls to the Nexmo APIs.
`public_key` | Used by Nexmo to authenticate the JWT in your requests to Nexmo API.
`applicationID` | Used to identify each application & used in conjunction with *private_key* to generate JWTs.
`webhooks` | Nexmo sends and retrieves information from your webhook endpoints including : `answer_url` - The webhook endpoint that provides the Nexmo Call Control Object governing a Call or Conference & `event_url` - Nexmo sends event information asynchronously to this URL when status changes.

> **Note**: by default, all HTTP requests are POST.

You use Application API to [create, list, modify and delete applications](/api/application).

## Getting started with applications

```tabbed_content
source: _examples/concepts/guides/applications/
```
