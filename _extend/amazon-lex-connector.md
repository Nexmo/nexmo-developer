---
title: Amazon Lex Connector
description: A hosted and opensource connector to bridge between Nexmo websockets and Amazon Lex
tags: ["Amazon","Lex","AI","Bots"]
cta: Get this Repo
link: https://github.com/nexmo/lex-connector
image: /assets/images/extend/amazon-lex-logo.jpg
published: true
---

## Overview
The Lex connector is a middleware component which sits between the [Nexmo Voice API Websocket](https://developer.nexmo.com/voice/voice-api/guides/websockets) and [Amazon Lex](https://aws.amazon.com/lex/), it allows you to connect a call directly to a Lex bot, all audio from that call will then be sent to Lex and responses played back into the call. You pass the details of the Lex bot endpoint and AWS credentials to Nexmo through the NCCO Connect action.
The connector is supplied as an open source project written in python and also has a hosted service on Nexmo in Developer Preview.

## Resources
* [GitHub Repository](https://github.com/nexmo/lex-connector)
* [Hosted Service Docs](/voice/voice-api/guides/lex-connector)
* [Lex PostContent Endpoint](https://docs.aws.amazon.com/lex/latest/dg/API_runtime_PostContent.html) For information

## Support
The open source project is supported by the Nexmo DevRel team on a best effort basis, issues should be raised in the github repository.

The Hosted connector is in Developer Preview and is supplied without warranty, questions should be directed to [devrel@nexmo.com](mailto:devrel@nexmo.com).
