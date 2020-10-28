---
title: Overview
meta_title: Redact your data to stay GDPR compliant
description: To facilitate our customers' privacy compliance efforts, Vonage provide an API that allows you to manage personal data within the Vonage API platform. The Redact API allows you to redact information on demand, providing a solution for your own compliance needs.
---

# Redact your data

Vonage provides two solutions to cover your compliance and privacy needs. The Auto-redact service and the Redact API allow you to redact sensitive or personal information either automatically or on demand from our platform.

## Contents

* [Vonage Redact Concepts](#concepts)
   * [Stored data](#stored-data-and-redaction)
   * [Auto-redact service](#auto-redact-service)
   * [Redact API](#redact-api)
   * [Auto-redact vs Redact API](#auto-redact-vs-redact-api)
* [Detailed description of redaction scopes](#detailed-description-of-redaction-scope-per-api)
   * [SMS API](#sms-api)
   * [Number Insight API](#number-insight-api)
   * [Messages API](#messages-api)
   * [Voice API](#voice-api)
   * [Conversations API](#conversations-api)
* [Right to erasure requests](#right-to-erasure-requests)
* [Technical Support Impact](#technical-support-impact)

## Concepts

There are three ways that you can redact personal information from the Vonage platform:

1. Auto-redact service
2. Redact API
3. General product APIs

Each of these options has a different use case and an interaction model.

### Stored data and redaction

When you use Vonage communication APIs, server logs and transactional records of the activity are created. Transactional records of the activity are called CDRs (Call Detail Records).

Server logs are retained for approximately 15 days (at most one month) but the CDRs are stored for 13 months. Both server logs and CDRs can be viewed by our support staff for various purposes, including testing and debugging, diagnosing user issues, and reconciling CDRs against customer's transaction records.

The Auto-redact service and the Redact API can be used to remove Personal Identifiable Information (PII) stored in the Vonage platform. PII held in the platform generally includes the receiver phone number for outbound messages or calls and sender phone number for inbound messages or calls. For messages, PII also includes the message content. In terms of PII, server logs and CDRs are identical, that is, they contain exactly the same PII.

Upon redaction, the real PII content in the redacted fields is overwritten with the string "REDACTED". Redaction of the receiver/sender phone number is subject to applicable data retention regulations, which are country-specific. Details are provided in the following sections.

Customers can view the redacted CDRs using either the [Reports API](/api/reports) or the Customer Dashboard.

### Auto-redact service

Vonage provides the Auto-redact service that automatically redacts PII from our systems without any actions from your side. You can define whether you want redaction to be done immediately (once the message or call has been processed) or with a delay of several days. Supported values are 15, 30, 60, and 90 days. The scope of redaction and the configurable delay depends on which of the Vonage communication APIs you are using. Some communication APIs support Standard Auto-redact while other support Advanced Auto-redact. Standard Auto-redact, like the Free Redact API, cannot redact server logs. It redacts only CDRs. Advanced Auto-redact redacts both the CDRs and the server logs. The detailed description is provided in the following paragraphs.

Please find a relevant pricing for the auto-redact service here: [Vonage Prices](https://www.vonage.com/communications-apis/pricing/).

To request activation of the Auto-redact service for your account, please visit [this page](https://info.nexmo.com/RedactAPI.html).

### Redact API

The Redact API provides Vonage customers with an endpoint to programmatically request the redaction of CDRs (retained for 13 months) held in the Vonage platform. Redact API does not have the capability to redact the server logs (retained for approximately 15 days).

To use the Redact API, you have to provide transaction (message or call) IDs returned in the responses to the API requests sent by you to the Vonage communication APIs. For each ID, you need to make a request to the [Redact API](/api/redact).

It is not possible to make the redaction API request immediately after receiving the transaction ID because it takes time (up to several minutes) for the CDRs to propagate to the long-term storage that Redact API redacts from. Thus, you either have to save the returned transaction (CDR) IDs in your database for later reference or use the Reports API to retrieve the CDRs along with their IDs for your account.

The scope of redaction of the Redact API depends on what Vonage communication APIs you were using. The detailed description is provided below.

To request access to the Redact API, please visit [this page](https://info.nexmo.com/RedactAPI.html).

To learn more about the Redact API please refer to the [Redact API Reference](/api/redact).

### Auto-redact vs Redact API

| Features | Redact API | Auto-redact Standard | Auto-redact Advanced |
| --------------- | --------------- | --------------- | --------------- |
| Usage | For each record that you want to redact, you need to know a record  ID and you need to make a request to the [Redact API](/api/redact). | Automatic. Does not require any customer intervention. | Automatic. Does not require any customer intervention. |
| Redaction scope | Only CDRs | Only CDRs | Server logs and CDRs |
| Redaction options | Fixed | Configurable (except number encryption) | Configurable |
| Invocation delay | can be successfully invoked only after CDR gets propagated to the long-term storage | 15, 30, 60, and 90 days | Immediate |
| Provisioning | Required | Required | Required |
| Price | Free | Paid | Paid |

## Detailed description of redaction scope per API

### SMS API

Feature | Description
----|----
PII | PII includes the message content and the receiver phone number for outbound messages and the sender phone number for inbound messages. The SMS API uses a data pipeline software to transport CDRs to various databases. The data pipeline keeps CDRs along with the receiver/sender phone number for 7 days. Thus, besides server logs and the long-term storage of CDRs, PII is also stored in the data pipeline logs.
Supported Auto&#8209;redact type | Advanced or Standard
Auto&#8209;redact details | Advanced Auto-redact for SMS redacts server logs, CDRs, and the data pipeline logs. The scope of auto-redaction is configurable and can include the following options:<p>1. Message content redaction only.<br/> 2. Phone number redaction only.<br/> 3. Phone number encryption only (not supported by Standard type).<br/> 4. Message content redaction together with redaction or encryption of the phone number.</p>When immediate message content redaction is configured, message content is not written at all, not even to the server logs or the data pipeline logs. When immediate number redaction is configured, the phone number gets encrypted by the SMS API before it gets written to the server logs and the data pipeline logs. When CDRs get propagated to the long-term storage of CDRs, the encrypted number field gets automatically redacted. The logs containing encrypted numbers expire on their own. **Neither Support or any other Vonage personnel have access to decryption keys.**
Redact API details | Redact API redacts only the CDRs in the long-term storage of CDRs. The scope of redaction is not configurable and includes message content together with the phone number.

### Number Insight API

Feature | Description
---- | ----
PII | PII includes the phone number and the phone number owner's details: first name, last name, caller name, and subscriber Id. The NI API uses the data pipeline software to transport CDRs to various databases. The data pipeline keeps logs with PII in them for 7 days. Thus, besides the server logs and the long-term storage of CDRs, PII is also stored in the data pipeline logs.
Supported Auto&#8209;redact type | Advanced or Standard
Auto&#8209;redact details | Advanced Auto-redact for NI redacts server logs, CDRs, and the data pipeline logs. The scope of auto-redaction is configurable and can include the following options:<p>1. Phone number owner details only.<br/>2. Phone number redaction only.<br/>3. Phone number encryption only (not supported by Standard type).<br/>4. Redaction of phone number owner's details together with redaction or encryption of the phone number.</p>When immediate redaction is configured, the content of the redacted fields is not written at all, not even to the server logs. Everything gets redacted immediately (if redaction delay is set to zero).
Redact API details | Redact API redacts only the CDRs in the long-term storage of CDRs. The scope of redaction is not configurable and includes the phone number and the phone number owner's details.

### Messages API

Feature | Description
---- | ----
PII | PII includes the message content and the receiver phone number for outbound messages and sender phone number for inbound messages. The Messages API uses a data pipeline software to transport CDRs to various databases. The data pipeline keeps CDRs along with receiver/sender phone number for 7 days. Thus, besides server logs and the long-term storage of CDRs, PII is also stored in the data pipeline logs.
Supported Auto&#8209;redact type | Standard
Auto&#8209;redact details | Standard Auto-redact for the Messages API redacts only CDRs in the long-term storage of CDRs. The scope of auto-redaction is configurable and can include the following options:<p>1. Message content redaction only.<br/>2. Phone number redaction only.<br/>3. Message content and phone number redaction.</li></p>
Redact API details | Redact API redacts only CDRs in the long-term storage of CDRs. The scope of redaction is not configurable and includes the phone number and the phone number owner's details.

### Voice API

When you use the Voice API to make calls, one or more call resources will be created, as well as call detail records (CDRs). While you can use the Auto-redact service or the Redact API to remove personal data (in this case, the phone number) from the CDR, the call resources themselves will continue to exist.

Call resources are stored as "legs". For instance, if a proxy call is set up between a virtual number V and two other phone numbers A and B, there will be two legs, one between A and V, and one between B and V. These will exist as two separate leg resources with their own unique identifiers.

To determine the identifiers of the leg resources, use the [[GET] method](/api/conversation#listLegs) and add a query parameter to filter by the `conversationUuid` of the call.

Once the identifiers are known, each leg resource can be deleted with the [[DELETE] method](/api/conversation#deleteLeg).

For voice applications with call recordings enabled, for example, using the [record action](/voice/voice-api/ncco-reference#record) of an NCCO, a media resource will be created which holds the recording. This can be deleted using the [DELETE] method of the [Media API](/api/media#delete-a-media-item).

Feature | Description
---- | ----
PII | PII includes the receiver phone number for outbound calls and the sender phone number for inbound calls. If the phone recording functionality is used, the recorded audio files are also consider as PII.
Supported Auto&#8209;redact type | Standard
Auto&#8209;redact details | Standard Auto-redact for the Voice API redacts only CDRs in the long-term storage of CDRs. The scope of redaction is not configurable and includes only the phone number.
Redact API details | Redact API redacts only CDRs in the long-term storage of CDRs. The scope of redaction is not configurable and includes only the phone number.

### Conversations API

For the multi-channel communications APIs of Conversation, a developer might decide to use personal data (such as a personal phone number) as a user handle. In that case, the [[PUT] method](/api/conversation#updateUser) of the User resource could be used to replace the personal data in the resource, or the [[DELETE] method](/api/conversation#deleteUser) could be used to simply delete the resource completely.

If Conversation messages need to be redacted, the corresponding Event resource can be deleted using the [[DELETE] method](/api/conversation#deleteEvent).

Note that when a Conversation resource is deleted, it will no longer be available to query via a [GET] API call. If you need this information, you must store it in your own database outside of the Vonage API platform.

## Right to erasure requests

Under GDPR (and other privacy laws and regulations), individuals have the right to have personal data erased. Your users may ask you to remove any personal data being held about them. This could typically happen when someone terminates their relationship with a vendor, for example, the user of a dating app no longer needs the service, and asks the dating app vendor to delete their account and all the information it holds about them.

If your user sends you a request to have personal data erased, you can use the Redact API to remove this individual's phone number from all communication records (known as "CDRs") in our system.

## Subject Access Requests

Under GDPR, your customers can come to you and ask for the information that you hold on them. While each organization will need to determine the appropriate way to implement their request process, Vonage can help by providing data about what information is held in the platform, if necessary.

Data held on an individual by Vonage can be obtained using the following methods:

* Customer dashboard
* Reports API

Each of these options is described in more detail in the following sections.

### Customer Dashboard

In the [Vonage Customer Dashboard](https://dashboard.nexmo.com/sign-in), it is possible to search for records via a user interface. Generally, searches can be by:

* Transaction ID, for example, find details of a single SMS by providing the `message-id`.
* Phone number and date, for example, find all SMS sent to a specific phone number on a specific date.
* Date range, for example, download all messages (up to a limit of 4000) sent between two specific dates.

This method might be appropriate if generally very few or only a single message would ever be sent to a single person.

Using the dashboard, you can search for [SMS messages](https://dashboard.nexmo.com/sms), [voice calls](https://dashboard.nexmo.com/voice/search), [Verify requests](https://dashboard.nexmo.com/verify) and [Number Insight requests](https://dashboard.nexmo.com/number-insight).

### Reports API

[Reports API](https://developer.nexmo.com/reports/overview) can be used to search for all kinds of data records for all types of communication APIs in bulk. It has two relevant modes:

* Retrieve a JSON record describing an individual single message or call. It can be queried using the [load records endpoint](https://developer.nexmo.com/api/reports#get-records)
* Retrieve multiple data records simultaneously. This can be done either by providing a date range to the [load records endpoint](https://developer.nexmo.com/api/reports#get-records) or by creating a CSV report containing all records with the help of the [create report endpoint](https://developer.nexmo.com/api/reports#create-async-report).

To learn how to use Reports API please refer to the [Reports API documentation](https://developer.nexmo.com/reports/overview).

## Technical Support Impact

Please be aware that redaction of data can have a negative impact on our ability to troubleshoot customer-specific service degradations. As part of our commitment to our customers' success, Vonage Support will attempt to provide assistance to all customers wherever possible. 

Redaction performed by the Redact API has limited impact on the Vonage Support because we still have access to the unredacted server logs until they expire (expiration time is approximately 15 days). The same applies to the automatic redaction with delay performed by the Auto-redact service. The biggest impact on the Vonage Support has Advanced Auto-redact configured to perform immediate redaction because it does not leave any unredacted data sources.

Typically, the diagnosis of an issue starts with identifying a specific problematic API call or a communication event relating to the issue, or a pattern of related events (messages or calls). It is common to identify the data records related to the issue using the date of the issue and a phone number or a message text/body. Examples could include:

* The `to` phone number for an outbound SMS to the phone of one of your users.
* The `from` phone number for an inbound call to your Vonage virtual number.

The side effect of immediate number redaction is that you will not be able to ask Vonage Support to help you by only providing the phone number and the time window. Without having numbers in our data records and logs, we will not be able to use differential analysis and compare failed and successful transactions over time (patterns) to a single number or a range of numbers. Instead, you will need to provide the relevant transaction IDs that were given to you in the API responses. For example, for SMS, this is the `message-id` value. If your system does not log/store the responses you receive from the Vonage APIs or it is difficult to access this response data, you should use either the Reports API or the Customer Dashboard to view your transactional data records in our system, find those related to the issue, and tell us their IDs.

Having the IDs, our Support will usually be able to identify the problem straight away, but in some cases it might take considerable time. For example, if the immediate Advanced auto-redaction of the message body is enabled for SMS and if a Telecommunications Service Provider rejects the SMS because of some local regulations on the contents of the message or some [Unicode formatting](/messaging/sms/code-snippets/send-an-sms-with-unicode) issues, then without knowing the message body, Vonage Support will not be able to pinpoint the problem immediately and may even need to involve the Telecommunications Service Provider in the troubleshooting process.

Note that all transactional data records are deleted after thirteen months, so we will not be able to help you diagnose an issue with a transaction older than this.
