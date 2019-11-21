---
title: Glossary
description: Glossary of terms based on the Nexicon
navigation_weight: 6
---

# Glossary

## 2FA

Two-factor authentication: unambiguous identification of users by means of the combination of two different components. For example, to withdraw cash from an ATM, you need both a card and a PIN code. These components may be something that the user knows, something that the user possesses or something that is inseparable from the user.

Many Nexmo customers authenticate their users by sending them a PIN code in an [SMS](#sms). The user authenticates by entering the PIN into the customer's UI. An example of usage is where the customer requires a password reset. In this case, the two components are the account details and possession of the phone number registered to that account.

See the [Wikipedia article](https://en.wikipedia.org/wiki/Two-factor_authentication).

See also the [Verify API documentation](/verify/overview).

## Adaptive Routing™

Adaptive Routing technology actively reroutes messages through the alternate carrier routes to ensure that messages are delivered in an optimal manner. It identifies the aggregator partners that are providing the best performance to a given destination, and as a result, both latency and performance volatility are reduced.

This technology in the Platform is an algorithm that actively monitors and dynamically adjusts the routes used to deliver SMS. The route choice is made using millions of real-time conversion data points.

## AR

See [Adaptive Routing](#adaptive-routing).

## Caller ID

The [Sender ID](#sender-id) for [voice](#voice) calls. Referred to as the CLI or ANI also.

## Carrier

A Telecommunications Service Provider. The company that a phone connects to is the target carrier for the phone number. You can also have intermediate carriers - Nexmo is one.

## CDR

Call Detail Record. CDRs completely describe a message or call and the submission state. Technically, this is data for a particular Request.

For more information on managing CDRs see the [Redact API documentation](/redact/overview).

## CLI

Nexmo Command Line Interface (CLI) tool. 

Further information can be found in the [CLI repository](https://github.com/Nexmo/nexmo-cli).

Also, Caller Line Identity. See [Caller ID](#caller-id)

## Client libraries

See [Server SDKs](#server-sdks).

## Client SDK

The [Client SDK](/client-sdk/overview) enables you to add in-app voice and messaging capabilities to your JavaScript, Android, and iOS applications.

## Cloud number

A virtual number that is assigned to a customer's account and not a device. A virtual number can accept inbound SMS, Voice or both. Nexmo customers use these numbers for [Messaging](#messaging-api) or [Voice](#voice) communication.

See also [Virtual Number](#virtual-number).

## Conversions

The successful validation that a message was delivered to a user.

## Conversation API

The [Conversation API](/conversation/overview) provides an API to enable you to build applications based on Conversations. Conversations are containers that provide a way to store communications between logged in users. For example a Conversation can store a messaging history and, through [custom events](/client-sdk/custom-events), other data such as an order history.

## Dashboard

See [Nexmo Dashboard](#nexmo-dashboard).

## Dedicated Short Codes

This is a Short Code used by a single Nexmo Customer. Unlike a Shared Short Code, Nexmo manages a lengthy application process in order to purchase a US short code for you. Customers can also transfer their current short code to Nexmo.

For more information see the [US Short Code documentation](/messaging/us-short-codes/overview).

## Delivery Receipt

When Nexmo sends an SMS to a Telecommunications Service Provider, they return a delivery receipt. Telecommunications Service Providers send the delivery receipt at a moment of their choice, they do not have to wait for delivery confirmation.

Delivery receipt can be either:

* Carrier - returned to Nexmo when the message is received by the Telecommunications Service Providers.
* Handset - returned to Nexmo when the message is received on your user's handset.

In practice, some Telecommunications Service Providers either do not send the delivery receipt or send a Fake DLR. Nexmo cannot be 100% certain that a "successfully delivered" delivery receipt means that the message reached the user.

If the message is not received, this delivery receipt explains why the message failed to arrive.

## Destination Number

The phone number a message or call is sent to. This is the `to` parameter in the Nexmo APIs.

## Direct-to-Carrier Network

The Platform is a globally distributed communication network based on direct integration with Telecommunications Service Providers. This provides zero-hop communication to most destinations worldwide. This results in lower latency and higher quality of delivery.

## DLR

See [Delivery Receipt](#delivery-receipt).

## DTMF

Dual Tone Multi Frequency. Typically used when dealing with data entered by the caller using their phone keyboard.

See [Wikipedia article](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling).

For further information see the [Nexmo DTMF documentation](/voice/voice-api/guides/dtmf).

## Dynamic Caller ID

Enables you to present any phone number on your account as your outbound Caller ID. You can have multiple Caller IDs based on the number you are calling. For example, if you call someone in San Francisco from New York City, the recipient would only see a local San Francisco number on their phone.

## Dynamic phone number insertion

A measure of the impact of inbound phone calls in digital marketing efforts. For example, when a potential customer clicks on your site, dynamic phone number insertion will show a phone number that is unique to the search engine, website key terms or other sources.

## E.164 format

The Nexmo APIs expect numbers to be in [E.164 format](https://en.wikipedia.org/wiki/E.164), ensuring that the dialling code `+` is omitted.

Numbers must therefore:

* Omit both the international access code such as `+`, `00` or `001`.
* Contain no special characters, such as a space, `(`, `)`, or `-`.

For example, a US number would have the format `14155550101`. A UK number would have the format `447700900123`.

If you are unsure how to format the number the Number Insight API can be used to find correct information about a number.

See [Number format](#number-format).

## Extended shortcode

A short number between 4 and 6 digits that has been extended to create a large pool of numbers.

## Fake Delivery Receipt

A [Delivery Receipt](#delivery-receipt) suspected to be fake. That is when there is no intention to deliver the SMS.

Sometimes delivery receipts are faked because the Telecommunications Service Provider sends it early. Some Telecommunications Service Providers never return a delivery receipt. In this case Nexmo creates a delivery receipt and sends it to you.

## Geo

The geographic region of the world.

## Handset Delivery Receipt

A [Delivery Receipt](#delivery-receipt) that is sent when the message is delivered to the user's handset.

## HLR

Home Location Register. These databases contain details of each subscriber phone number, including the current active status and more.

## Interactive Voice Response

Interactive Voice Response, or IVR, is an automated telephony technology that enables a human caller to interact with a computer using voice and DTMF tones input on a keypad.

See also the [Nexmo DTMF documentation](/voice/voice-api/guides/dtmf).

## Intermediate carrier

A Telecommunications Service Provider that does not own the wireless network infrastructure.

See [Wikipedia article](https://en.wikipedia.org/wiki/Mobile_virtual_network_operator).

## IVR

See [Interactive Voice Response](#interactive-voice-response).

## Latency

The elapsed time between the moment a message is sent and when it is received. A delivery that encounters few or no delays has low latency. A delivery that encounters a significant amount of delay has high latency. The greater the number of hops associated with message delivery, the greater the number of opportunities for a delay — and higher latency.

## Live Handset Check

See [HLR](#hlr).

## Local Supplier

An intermediate carrier Nexmo believes has direct connections Telecommunications Service Providers in a country.

## Low friction integration

Allows you to build conferencing apps that scale with dynamic phone number provisioning and call control for an improved experience.

## LVN

Long Virtual Number.

See [Virtual Number](#virtual-number).

You can rent LVNs via the [Dashboard](https://dashboard.nexmo.com/).

## Meshed carrier network

A seamless network of Telecommunications Service Providers. This enables you to pick and choose Telecommunications Service Providers for each location. This gives maximum flexibility and savings compared to MPLS or Wide Area Networking solutions.

## Messaging API

This product enables Nexmo customers to have a conversation with their users. The products that makeup Messaging are:

* SMS API
* US Short Codes API
* SMS Cloud Numbers

Further information can be found in the [Messaging API documentation](/messaging/sms/overview).

## MO

Mobile Originated. Sent from a phone number to Nexmo. When a phone sends a text to a virtual number it is MO because the message originates from the phone.

## MSISDN

Mobile Station International Subscriber Directory Number (MSISDN) is a number used to identify a mobile phone number internationally. MSISDN is defined by the [E.164 format](https://en.wikipedia.org/wiki/E.164). MSISDN includes a country code and a National Destination Code (NDC) that identifies the subscriber's network operator.

## MT

Mobile Terminated. That is, sent by a customer to a phone number through the Platform. For example, requests to deliver an SMS are MT, they go to a phone number.

## Network

A Telecommunications Service Provider.

## Network Delivery Receipt

A [Delivery Receipt](#delivery-receipt).

## Nexmo Application

An application object that you create in the [Nexmo Dashboard](#nexmo-dashboard), or using the [CLI](#cli), [client libraries](#client-libraries) or [REST APIs](https://developer.nexmo.com).

## Nexmo Dashboard

This product is a self-service customer tool.

You use your Dashboard to:

* Manage your account:
    * Secondary users
    * Top-ups
    * Notifications
    * Profile

* Manage your products:
    * Virtual numbers
    * US Short Codes

* Analyze the success rates for your communication using the Nexmo APIs:
    * Measure conversion
    * Track and troubleshoot message delivery
    * Make data-driven decisions
    * Optimize communication with their users

[Access your Nexmo Dashboard](https://dashboard.nexmo.com).

## Notification service

Provides the means to send a notice to many persons at once.

See [Wikipedia article](https://en.wikipedia.org/wiki/Notification_Service).

## Number Cloud

Using Number Cloud you check and retrieve information about phone numbers. It includes:

* [Number Insight API](#number-insight-api)
* [Verify API](#verify-api)

## Number Insight API

A group of products in the Number Cloud that provides actionable intelligence on phone numbers without interfering with the end-user experience. Number Insight is made up of:

* [Number Insight Basic](#number-insight-basic)
* [Number Insight Standard](#number-insight-standard)
* [Number Insight Advanced](#number-insight-advanced)

Further information can be found in the [Number Insight documentation](/number-insight/overview).

## Number Insight Basic

This Number Insight product is a synchronous API that returns local and international representations of a phone number. Use this API to pretty-print numbers in a UX.

## Number Insight Standard

This Number Insight product is a synchronous API that identifies the Telecommunications Service Provider network a number belongs to and the number type. Use this API to ensure that you are dealing with a real phone number that is semantically correct. This API also supplies the functionality in Number Insight Basic.

## Number Insight Advanced

This  Number Insight  product is a synchronous API that verifies the relationship between a phone number and the Telecommunications Service Providers that have supplied it.

## Number inventory

Search for, buy and update your inventory of numbers using Nexmo Dashboard.

## Number format

Within the Nexmo Voice API, all numbers are in E.164 format. This means that numbers:

* Omit both a leading `+` and the international access code such as `00` or `001`.
* Contain no special characters, such as a space, `(`, `)` or `-`.

For example, a US number would have the format `14155550101`. A UK number would have the format `447700900123`.

If you are unsure how to format the number the [Number Insight API](/number-insight/overview) can be used to find correct information about a number.

## Number validity

Determine if the numbers in your database are valid according to local numbering plans and portability databases.

See also [Number Insight API documentation](/number-insight/overview).

## Operator

See [Telecommunications Service Provider](#telecommunications-service-provider).

## OA

Originating Address see [Sender ID](#sender-id) or the MSISDN of the sender of an SMS.

## Originating Number

See [Sender ID](#sender-id).

## PDD

Post-Dial Delay is the time it takes to receive feedback after a user has finished dialling. This feedback is one of the following:

* Dial tone
* Recorded announcement
* Abandoned call

## Per-second billing

With Nexmo per-second billing, you maintain full control over how much you spend. For example, if your call lasts 2.5 minutes, you are charged for 2.5 minutes, not 3. This billing model allows you to make more calls for the same amount of money.

## Performance volatility

The frequent changes in throughput that constantly occur in SMS networks. For example, the fastest and most reliable network connection to a Telecommunications Service Provider may suddenly become unavailable, in which case alternate routes must be immediately switched to.

## Platform

The Nexmo technologies that facilitate the interaction between Nexmo customers and their users. The Cloud Communications Platform is an API-based, fully redundant global communication platform that delivers mission-critical multi-channel solutions. The main products in the cloud are:

**Technologies** - the components and algorithms that make the Platform work:

* Direct-to-Carrier Network
* [Adaptive Routing™](#adaptive-routing)
* Platform Infrastructure

**Services** - Customers communicate with the cloud using the comprehensive suite of Nexmo APIs in order to optimize their communication experience.

These APIs are:

* [Messaging](#messaging-api)
* [Voice](#voice)
* [Number Cloud](#number-cloud)
* [Developer API](/api/developer/account)

**Virtual Numbers** - phone numbers that customers rent:

* SMS Cloud Numbers
* Voice Cloud Numbers
* Shared Short Codes
* Dedicated Short Codes

Customers interact and manage their account in the Platform using the [Dashboard](#dashboard).

## Ported Phone Number

When somebody changes Telecommunications Service Provider but keeps the same phone number. As a ported phone is registered with another Telecommunications Service Provider, the reliability of delivery is reduced.

## Premium number

Used when certain services are provided over the phone. Part of the call charge is paid to the service provider, this enables businesses to be funded through calls to the premium number.

## Presence

If the phone number associated with a user is currently reachable. You use this to see if a user is available to receive information. For example, an SMS or Voice message.

## Read rate

The number of times a user opened the message you sent. SMS has a 95% read rate, most inbound messages are read within 90 seconds of arrival.

## Roaming

When a phone number is outside its Telecommunications Service Provider network and it remains connected in another Telecommunications Service Provider network. This only happens if roaming is enabled on the phone.

See [Wikipedia article](https://en.wikipedia.org/wiki/Roaming).

## RTP

Real-Time Transport Protocol. Media protocol used for transfer of voice data once a VoIP call is established.

## Sender ID

The phone number or message shown on a handset when it receives an SMS API message.

## Server SDKs

Nexmo provides Server SDKs for various programming languages. These SDKs allow you to develop
Nexmo applications quickly and reduce time to market.

Further information can be found on the [Nexmo Tools page](https://developer.nexmo.com/tools).

## Shared Short Codes

A Short Code that is instantly available to Customers. These US Short Codes are shared with other customers.

## Short Code

Special telephone numbers, significantly shorter than full telephone numbers, that can be used to address SMS.

See [Wikipedia article](https://en.wikipedia.org/wiki/Short_code).

## Short Message Service

A text messaging service component of phone, Web, or mobile communication systems.

See [Wikipedia](https://en.wikipedia.org/wiki/Short_Message_Service).

## Silent ping

A silent SMS sent to check if a user's phone is turned on. If the user's device is not turned on when the ping SMS is sent, you receive a notification as soon as the device is turned on.

## SIP

Session Initiation Protocol (SIP) is an application-layer control protocol that can establish, modify, and terminate multimedia sessions (conferences) such as Internet telephony calls. Nexmo supports a SIP interface for [Voice](#voice).

See [Wikipedia article](https://en.wikipedia.org/wiki/Session_Initiation_Protocol).

See also the [Nexmo documentation on endpoints](/voice/voice-api/guides/endpoints).

## SIP Trunking

In [Voice](#voice), some customers connect to the Nexmo [SIP](#sip) endpoint (`sip.nexmo.com`) to create and accept inbound and outbound VOIP calls. All requests are digest authenticated using account credentials. You can flexibly use this as a SIP trunk and a SIP User Agent gateway.

## SMPP

The Short Message Peer-to-Peer (SMPP) protocol is used to communicate [SMS](#sms) between carriers. Nexmo supports SMPP. However, the majority of our customers use the [HTTP](#sms-api) interface.

## SMS

See [Short Message Service](#short-message-service).

## SMS API

A [Messaging API](#messaging-api) you use to send and receive a high volume of [SMS](#sms) anywhere in the world. The SMS API provides instant access to the highest quality global messaging network. The SMS API uses [Adaptive Routing](#adaptive-routing) and delivery optimization technologies to ensure the highest quality message delivery.

More information can be found in the [SMS API documentation](/messaging/sms/overview).

## SMS Cloud Numbers

Cloud numbers enabled to receive [SMS](#sms).

## SMS Enabled Virtual Number

See [SMS Cloud Numbers](#sms-cloud-numbers).

## Supplier

Any company furnishing telecoms services to Nexmo that does not fit into the category of carrier or intermediate carrier.

## Target Carrier

The carrier that a phone number is currently connected to.

## Telecommunications Service Provider

A type of communications service provider that has traditionally provided telephone and similar services. This category includes incumbent local exchange carriers, competitive local exchange carriers, and mobile wireless communication companies.

## Trace ID

Proposed ID code for an API request to be in all logs that the API request triggers, used for linking of related logs.

## TSP

See [Telecommunications Service Provider](#telecommunications-service-provider).

## TTS API

Text-to-Speech API. You use the TTS API to play synthesized messages and audio files to a live call. Using this API you can:

* Specify the language to use for synthesized speech.
* Change the cadence of the synthesized speech to speed up or slow down the voice.
* Specify the URL of the media file for streaming audio.
* Repeat a message up to ten times.
* Change the gender of the voice.

## Two-way messaging

Send and receive SMS directly from your system or App.

## US Short Codes API

You use Nexmo's US Short Codes API to:

* Prove a user's identity with Two-factor Authentication.
* Communicate with people using Event Based Alerts.

## Verify API

A turnkey, pay-per-conversation phone verification solution that allows you to instantly verify users globally and achieve highest conversion in order to:

* Easily register users.
* Verify transactions.
* Implement [2FA](#2fa) and one-time passwords.

Further information can be found in the [Verify documentation](/verify/overview).

## Virtual Number

Nexmo purchases virtual numbers from various carriers. Nexmo customers rent these virtual numbers to receive inbound messages and voice communication in their application.

See [Long Number](https://en.wikipedia.org/wiki/Long_number) and [Virtual Number](https://en.wikipedia.org/wiki/Virtual_number) on Wikipedia.

## Voice

A suite of APIs used to build voice enabled apps. These products allow customers to integrate text-to-speech into their workflow, build interactive voice response systems using JSON or make VoIP calls using [SIP](#sip) trunks.

Voice includes:

* Voice API
* SIP Trunking
* Voice Enabled Numbers (LVNs)

## Voice API

This [Voice](#voice) product provides a simple and affordable personalized voice communication experience.

Further information can be found in the [Voice API documentation](/voice/voice-api/overview).

## Voice Cloud Numbers

Cloud numbers enabled to send and receive Voice Messages.

## Voice-Enabled Landline Virtual Number

A virtual number tied to a landline that you can send voice data to.

## Voice-Enabled Toll-Free Virtual Number

A Voice-Enabled Landline Virtual Number designated as Freephone. That is, calls to this LVN from within the local country are free for the caller.

## VoIP

A methodology and group of technologies for delivering voice communications and multimedia sessions over Internet Protocol (IP) networks.

See [Wikipedia article](https://en.wikipedia.org/wiki/Voice_over_IP).
