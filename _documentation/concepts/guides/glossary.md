---
title: Glossary
description: Glossary of terms based on the Nexicon
---

# Glossary

## 2FA

Two-factor authentication: unambiguous identification of users by means of the combination of two different components. For example, to withdraw cash from an ATM, you need both a card and a PIN code. These components may be something that the user knows, something that the user possesses or something that is inseparable from the user.

Many Nexmo customers authenticate their users by sending them a [PIN](#pin) code in an [SMS](#sms). The user authenticates by entering the PIN into the customer's UI. For example, password reset. In this case the two components are the account details, and possession of the phone number registered to that account.

See the [Wikipedia article](https://en.wikipedia.org/wiki/Two-factor_authentication).

## A2P

Application to Person.

## Adaptive Routing(™)

Adaptive Routing technology actively reroutes messages through the alternate carrier routes to ensure that messages are delivered in an optimal manner. It identifies the aggregator partners that are providing the best performance to a given destination, and as a result, both latency and performance volatility are reduced.

This technology in the Platform is an algorithm that actively monitors and dynamically adjusts the routes used to deliver SMS. The route choice is made using millions of real-time conversion data points.

## AD

Admin Dashboard. See [Dashboard](#dashboard).

## Analytics

See [insights](#insights).

## Android Virtual Device

A device configuration that is run with the Android emulator.

For more information, see the [Android developer website](http://developer.android.com/tools/devices/index.html).

## API

API, which stands for Application Program Interface, is a set of protocols, tools and routines for building applications. An API specifies how the various software components interact.  Nexmo’s Cloud Communications Platform provides a comprehensive suite of APIS than allow you to implement Messaging, Voice, Verification, and Chat App API solutions.

## App

Software that runs on a computer, mobile device or a Web browser.

See the [Wikipedia article](https://en.wikipedia.org/wiki/App).

## Application

A Nexmo Application.

## AR

See [Adaptive Routing](#adaptive-routing).

## ARDW

Adaptive Routing Dynamic Weights. See [Adaptive Routing](#adaptive-routing).

## ASR

The Answer Seizure Ratio is a metric used to measure the quality of a carrier’s network.

The ASR calculation is `Number of successfully answered calls / Number of calls received`.

## AVD

See [Android Virtual Device](#android-virtual-device).

## BI

See [Business Intelligence](#business-intelligence).

## Business Intelligence

Team managing data and analytical tools, such as Tableau Server or Data Warehouse.

## Call API

You use Call API to generate voice calls over regular phone numbers. You can:

* Create Call me buttons.
* Automate calls in your App.
* Manage event-prompted calls.

Call API is part of [Voice API](#voice-api).

## Caller ID

The [Sender ID](#sender-id) for [voice](#voice) calls.

## Carrier

A Telecommunications Service Provider. The company that a phone connects to is the target carrier for the phone number. You can also have intermediate carriers - Nexmo is one.

## CDR

Call Detail Record. CDRs completely describe a message or call and the submission state. Technically, this is data for a particular Request.

## Challenge

See [Challenge-response](#challenge-response).

## Challenge-response

A family of protocols in which one party presents a question ("challenge") and another party must provide a valid answer ("response") in order to be authenticated.

See [Wikipedia article](https://en.wikipedia.org/wiki/Challenge–response_authentication).

## Chat App API

Supplies two-way messaging with users of all different chat apps, plus access to data about the users’ profiles. Chat App API gives access to all the chat apps in one place after a single integration.

## CLI

See [Caller ID](#caller-id).

## Cloud number

A virtual number that is assigned to a customers account and not a device. A virtual number can accept inbound SMS, Voice or both. Nexmo customers use these numbers for [Messaging](#messaging) or [Voice](#voice) communication.

## Conversions

The successful validation that a message was delivered to a user.

## Customer

A company who uses Nexmo products or services.

## CD

Customer Dashboard. See [Dashboard](#dashboard).

## DA

Destination Address. Receiving number or equivalent.

## Dashboard

This product is a self-service customer tool. You use your Dashboard to:

* Manage your account:
    * Secondary users
    * TopUps
    * Notifications
    * Profile

* Manage your products:
    * Virtual numbers
    * US Short Codes

* Analyse the success rates for your communication using the Nexmo APIs:
    * Measure conversion
    * Track and troubleshoot message delivery
    * Make data-driven decisions
    * Optimize communication with their users

## Dedicated Short Codes

This is a Short Code used by a single Nexmo Customer. Unlike a Shared Short Code, Nexmo manages a lengthy application process in order to purchase a US short code for you. Customers can also transfer their current short code to Nexmo.

## Delivery Receipt

When Nexmo sends an SMS to a Telecommunications Service Provider, they return a delivery receipt. Telecommunications Service Providers send the delivery receipt at a moment of their choice, they do not have to wait for delivery confirmation.

Delivery receipt can be either:

* Carrier - returned to Nexmo when the message is received by the Telecommunications Service Providers.
* Handset - returned to Nexmo when the message is received on your user's handset.

In practice, some Telecommunications Service Providers either do not send the delivery receipt or send a Fake DLR. Nexmo cannot be 100% certain that a "successfully delivered" delivery receipt means that the message reached the user.

If the message is not received, this delivery receipt explains why the message failed to arrive.

## Destination Number

The phone number a message or call is sent to. This is the to parameter in the Nexmo APIs.

## Developer API

The API you use to manage your Nexmo account.

## Direct downloadable link

A direct downloadable link provides a hyperlink that points to a location within the Internet where the user can download a file.

## Direct-to-Carrier Network

The Platform is a globally distributed communication network based on direct integration with Telecommunications Service Providers. This provides zero-hop communication to most destinations worldwide. This results in lower latency and higher quality of delivery.

## DLR

See [Delivery Receipt](#delivery-receipt).

## DN

See [Delivery Receipt](#delivery-receipt).

## DR

See [Delivery Receipt](#delivery-receipt).

## DTMF

Dual Tone Multi Frequency.

See [Wikipedia article](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling).

## Dynamic caller ID

Enables you to present any phone number on your account as your outbound Caller ID. You can have multiple Caller IDs based on the number you are calling. For example, if you call someone in San Francisco from New York City, the recipient would only see a local San Francisco number on their phone.

## Dynamic phone number insertion

A measure of the impact of inbound phone calls in digital marketing efforts. For example, when a potential customer clicks on your site, dynamic phone number insertion will show a phone numbers that is unique to the  search engine, website, key terms or other source.

## Dynamic Routing

See [Adaptive Routing](#adaptive-routing).

## Extended shortcode

A short number between 4 and 6 digits that has been extended to create a large quantity of numbers.

## Fake Delivery Receipt

A [Delivery Receipt](#delivery-receipt) suspected to be fake. That is, when there is no intention to deliver the SMS. In cases of filtering, this usually occurs in the Middle East.

Sometimes delivery receipts are faked because the Telecommunications Service Provider sends it early. Some Telecommunications Service Providers never return a delivery receipt. In this case Nexmo creates a delivery receipt and sends it to you.

## Enterprise-grade call quality

Ensures that your communications network provides high-quality voice traffic. Call quality is never less than that of a major Telecommunications Service Provider.

## Geo

The geographic region of the world.

## GSM

See [Wikipedia article](https://en.wikipedia.org/wiki/GSM).

## Handset Delivery Receipt

A [Delivery Receipt](#delivery-receipt) that is sent when the message is delivered to the user's handset.

## HLR

Home Location Register. These databases contain details of each subscriber phone number, including the current active status and more.

## HTTP

An application protocol for distributed, collaborative, hypermedia information systems. HTTP is the foundation of data communication for the [Web](#web), it is the most common standard internet communication protocol.

See [Wikipedia article](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol).

## HTTPS

The secure version of [HTTP](#http).

See [Wikipedia article](https://en.wikipedia.org/wiki/HTTPS).

## Inactive number

A phone number that is no longer active.

## Inbound message

An SMS sent as a reply to the originator.

## Inbound number

Make it easy for your users to call you and route calls.

## Inbound SMS

A simple, cost-effective way to interact with your users. They can send SMS to you using a virtual number.

## Insights

Reliable data collected for specific goals.

## Interactive Voice Response

Interactive Voice Response, or IVR, is nn automated telephony technology that enables a human caller to interact with a computer using voice and DTMF tones input on a keypad.

## Intermediate carrier

A Telecommunications Service Provider that does not own the wireless network infrastructure.

See [Wikipedia article](https://en.wikipedia.org/wiki/Mobile_virtual_network_operator).

## Internet

The Internet is a global system of interconnected computer networks that use the standard Internet protocol suite (TCP/IP) to link several billion devices worldwide. It is a network of networks.

See [Wikipedia](https://en.wikipedia.org/wiki/Internet).

## IVR

See [Interactive Voice Response](#interactive-voice-response).

## JSON

A data format. When you make a request against the Nexmo APIs, you can choose to send and/or receive data in JSON format.

See [Wikipedia article](https://en.wikipedia.org/wiki/JSON).

## Latency

The elapsed time between the moment a message is sent and when it is received. A delivery that encounters few or no delays has low latency. A delivery that encounters a significant amount of delay has high latency. The greater the number of hops associated with message delivery, the greater the number of opportunities for delay — and higher latency.

## Live Handset Check

See [HLR](#hlr).

## Local Supplier

An intermediate carrier we believe has direct connections Telecommunications Service Providers in a country.

## Low friction integration

Allows you to build conferencing apps that scale with dynamic phone number provisioning and call control for improved experience.

## LVN

See [Virtual Number](#virtual-number).

## Meshed carrier network

A seamless network of Telecommunications Service Providers. This enables you to pick and choose Telecommunications Service Providers for each location. This gives maximum flexibility and savings compared to MPLS or Wide Area Networking solutions.

## Messaging

This product enables Nexmo customers to have a conversation with their users. The products that make up Messaging are:

* SMS API
* US Short Codes API
* SMS Cloud Numbers

## Metrics

See [insights](#insights).

## MO

Mobile Originated. Sent from a phone number to Nexmo. When a phone sends a text to a virtual number it is MO because the message originates from the phone.

## MT

Mobile Terminated. That is, sent by a customer to a phone number through the Platform. For example, requests to deliver an SMS are MT, they go to a phone number.

## Network

A Telecommunications Service Provider.

## Network Delivery Receipt

A [Delivery Receipt](#delivery-receipt).

## Nexmo

Nexmo offers the most advanced solutions to organizations who need to easily embed scalable and trusted communications into their applications and business processes. Nexmo customers communicate with their users through the Platform.

## Nexmo Dashboard

Use [Dashboard](#dashboard).

## Notification service

Provides the means to send a notice to many persons at once.

See [Wikipedia article](https://en.wikipedia.org/wiki/Notification_Service).

## Number Cloud

Using Number Cloud you check and retrieve information about phone numbers. It includes:

* Number Insight API
* Verify API

## Number Insight API

A group of products in the Number Cloud that provides actionable intelligence on phone numbers without interfering with the end-user experience. Number Insight is made up of:

* Number Insight Basic
* Number Insight Standard
* Number Insight Advanced

## Number Insight Basic

This Number Insight product is an synchronous API that returns local and international representations of a phone number. Use this API to pretty-print numbers in a UX.

## Number Insight Standard

This Number Insight product is an synchronous API that identifies the Telecommunications Service Provider network a number belongs to and the number type. Use this API to ensure that you are dealing with a real phone number that is semantically correct. This API also supplies the functionality in Number Insight Basic.

## Number Insight Advanced

This  Number Insight  product is an synchronous API that verifies the relationship between a phone number and the Telecommunications Service Providers that have supplied it.

## Number inventory

Search for, buy and update your inventory of numbers using Nexmo Dashboard.

## Number validity

Determine if the numbers in your database are valid according to local numbering plans and portability databases.

## Operator

See [Telecommunications Service Provider](#telecommunications-service-provider).

## OA

Originating Address see [Sender ID](#sender-id) or the MSISDN of the sender.

## Originating Number

See [Sender ID](#sender-id).

## PDD

Post-Dial Delay is the time it takes to receive feedback after a user has finished dialling. This feedback is one of the following:

* Dial tone
* Recorded announcement
* Abandoned call

## P2P

Person to Person

## Per second billing

With Nexmo per second billing, you maintain full control over how much you spend. For example, if your call lasts 2.5 minutes, you are charged for 2.5 minutes, not 3. This billing model allows you to make more calls for the same amount of money.

## Performance volatility

The frequent changes in throughput that constantly occur in SMS networks. For example, the fastest and most reliable network connection to a Telecommunications Service Providers may suddenly become unavailable, in which case alternate routes must be immediately switched to.

## PIN

A numeric password shared between a user and a system that can be used to authenticate the user to the system.

See [Wikipedia article](https://en.wikipedia.org/wiki/Personal_identification_number).

## Platform

The Nexmo technologies that facilitate the interaction between Nexmo customers and their users. The Cloud Communications Platform is an API based, fully redundant global communication platform that delivers mission critical multi-channel solutions. The main products in the cloud are:

**Technologies** - the components and algorithms that make the Platform work:

* Direct-to-Carrier Network
* Adaptive Routing(™)
* Platform Infrastructure

**Services** - Customers communicate with the cloud using the comprehensive suite of Nexmo APIs in order to optimize their communication experience.

These APIs are:

* [Messaging](#messaging)
* [Voice](#voice)
* [Number Cloud](#number-cloud)
* Developer API

Virtual Numbers - phone numbers that customers rent:

* SMS Cloud Numbers
* Voice Cloud Numbers
* Shared Short Codes
* Dedicated Short Codes

Customers interact and manage their account in the Platform using the [Dashboard](#dashboard).

## Phone number

The number that is either a [telephone number](https://en.wikipedia.org/wiki/Telephone_number) or a virtual number.

## Ported Phone Number

When somebody changes Telecommunications Service Provider but keeps the same phone number. As a ported phone is registered with another Telecommunications Service Provider, the reliability of delivery is reduced.

## Premium number

Used when certain services are provided over the phone. Part of the call charge is paid to the service provider, this enables businesses to be funded through calls to the premium number.

## PSTN

See [Public Switched Telephone Network](#public-switched-telephone-network).

## Presence

If the phone number associated with a user is currently reachable. You use this to see if a user is available to receive information. For example, an SMS or Voice message.

## Read rate

The number of times a user opened the message you sent. SMS has a 95% read rate, most inbound messages are read within 90 seconds of arrival.

## Request

A call to the APIs offered by Nexmo.

## Response

After you send a Request, the response returns the the status and cost of your Request to the Nexmo API. Depending on your Request, the Response is in either JSON or XML format.

## REST

An architectural style of remote execution applied over HTTP. REST is not completely defined, many people refer to remote requests using HTTP as REST requests. 

See [Wikipedia article](https://en.wikipedia.org/wiki/Representational_state_transfer).

## Rich interaction

The interface model for a rich client. This interaction model supports several input methods and that responds intuitively and in a timely fashion.

## Roaming

When a phone number is outside its Telecommunications Service Provider network and it remains connected in another Telecommunications Service Provider network. This only happens if roaming is enabled on the phone.

See [Wikipedia article](https://en.wikipedia.org/wiki/Roaming).

## RTP

Media protocol used for transfer of voice data once a Voip call is established.

## Sender ID

The phone number or message shown on a handset when it receives an SMS API or Voice API message.

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

## SIP Trunking

In [Voice](#voice), some customers connect to the Nexmo [SIP](#sip) enpoint (sip.nexmo.com) to create and accept inbound and outbound VOIP calls. All requests are digest authenticated using account credentials. You can use this flexible as a SIP trunk and a SIP User Agent gateway.

## SMPP

The Short Message Peer-to-Peer (SMPP) protocol is used to communicate [SMS](#sms) between carriers. [Nexmo](#nexmo) supports SMPP. However, the majority of our customers use the [HTTP](#http) interface.

## SMS

See [Short Message Service](#short-message-service).

## SMS API

A [Messaging](#messaging) API you use to send and receive a high volume of [SMS](#sms) anywhere in the world. The SMS API provides instant access to the highest quality global messaging network. The SMS API uses Adaptive Routing and delivery optimization technologies to ensure the highest quality message delivery.

## SMS Cloud Numbers

Cloud numbers enabled to receive [SMS](#sms).

## SMS-Enabled Virtual Number

See [SMS Cloud Numbers](sms-cloud-numbers).

## Stochastic

Events or systems that are unpredictable due to the influence of a random variable. 

See [Wikipedia](https://en.wikipedia.org/wiki/Stochastic).

## Supplier

Any company furnishing telecoms services to Nexmo that does not fit into the category of carrier or intermediate carrier.

## Target Carrier

The carrier that a phone number is currently connected to.

## Telecommunications Service Provider

A type of communications service provider that has traditionally provided telephone and similar services. This category includes incumbent local exchange carriers, competitive local exchange carriers, and mobile wireless communication companies.

## Trace ID

Proposed id code for an API request to be in all logs that the API request triggers, used for linking of related logs.

## TSP

See [Telecommunications Service Provider](#telecommunications-service-provider).

## TTS API

You use the [TTS](#tts) API to play synthesized messages and audio files to a live call. Using this API you can:

* Specify the language to use for synthesized speech.
* Change the cadence of the synthesized speech to speed up or slow down the voice.
* Specify the URL of the media file for streaming audio.
* Repeat a message up to ten times.
* Change the gender of the voice.

TTS API is part of Voice API.

## TTS Prompt API

You use the Nexicon (Glossary)#TTS Prompt API to:

* Collect digits following a TTS message.
* Collect digits for [2FA](#2fa).
* Set a message to be played after users have entered digits.
* Play a message after three failed [PIN](#pin) entries.

TTS Prompt API is part of Voice API.

## Two-way messaging

Send and receive SMS directly from your system or App.

## User

A person that uses a customer's services. A user is associated with a phone number.

## US Short Codes API

You use Nexmo's US Short Codes API to:

* Prove a user's identity with Two-factor Authentication.
* Communicate with people using Event Based Alerts.

## Verify API

A turnkey, pay-per-conversation phone verification solution that allows you to instantly verify users globally and achieve highest conversion in order to:

* Easily register users
* Verify transactions
* Implement [2FA](#2fa) and one-time passwords

## Virtual number

A virtual number such as `+44 7624 80055` in international notation or `757-772-8555` in typical U.S. notation. Nexmo purchases virtual numbers from various carriers. Nexmo customers rent these virtual numbers to receive inbound messages and voice communication in their [App](#app).

See [Long Number](https://en.wikipedia.org/wiki/Long_number) and [Virtual Number](https://en.wikipedia.org/wiki/Virtual_number) on Wikipedia.

## Voice

A suite of API's used to build voice enabled apps. These products allow customers to integrate text-to-speech into their workflow, build interactive voice response systems using [VXML](#vxml) or make VOIP calls using [SIP](#sip) trunks.

Voice includes:

* Voice API
* SIP Trunking
* Voice Enabled Numbers (LVNS)

## Voice API

This [Voice](#voice) product provides a simple and affordable personalized voice communication experience.

Voice API contains:

* Call API - generate voice calls over regular phone numbers
* TTS API - play synthesized messages and audio files to a live call
* TTS Prompt API -  Collect digits following a TTS message

## Voice Cloud Numbers

Cloud numbers enabled to send and receive [Voice Messages](#voice-messages).

## Voice-Enabled Landline Virtual Number

An virtual number tied to a landline that you can send voice data to.

## Voice-Enabled Toll-Free Virtual Number

A Voice-Enabled Landline Virtual Number designated as Freephone. That is, calls to this LVN from within the local country are free for the caller.

## VoiceXML

A digital document standard for specifying interactive media and voice dialogs between humans and computers.

See [Wikipedia article](https://en.wikipedia.org/wiki/VoiceXML).

## VOIP

A methodology and group of technologies for delivering voice communications and multimedia sessions over Internet Protocol (IP) networks.

See [Wikipedia article](https://en.wikipedia.org/wiki/Voice_over_IP).

## VXML

See [Voice XML](#voicexml).

## Web

An information system of interlinked hypertext documents and other digital resources that are accessed via the [Internet](#internet).

See [Wikipedia article](https://en.wikipedia.org/wiki/World_Wide_Web).

## XML

A data format. When you make a request against the Nexmo APIs, you can choose to receive data in XML format.

See [Wikipedia article](https://en.wikipedia.org/wiki/XML).
