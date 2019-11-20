---
title: Overview
meta_title: Redact your data to stay GDPR compliant
---

# Redact your data

To facilitate our customers' privacy compliance efforts, Nexmo provide an API that allows you to manage personal data within the Nexmo platform. The Redact API allows you to redact information on demand, providing a solution for your own compliance needs.

### Right to erasure requests

Under GDPR (and other privacy laws and regulations), a person may ask you to remove any data being held about them. This could typically happen when someone terminates their relationship with a vendor, e.g. the user of a dating app no longer needs the service, and asks the dating app vendor to delete their account and all the information it holds about them.

## Contents

In this document you can learn about:

* [Nexmo Redact Concepts](#concepts)
* [Subject Access Requests](#subject-access-requests)
* [Guides](#guides)
* [Reference](#reference)
* [Technical Support Impact](#technical-support-impact)

## Concepts

There are two ways that you can redact personal information from the Nexmo platform via tools provided by us, the Redact API and the general product APIs. Each of these options has a different use case and interaction model.

### Redact API

When you use Nexmo communication APIs, we create a transaction record of the activity, which we call a `CDR` (short for `call detail record`, a telecommunications industry term). This can be viewed by our customers and support staff for various purposes, including testing and debugging, diagnosing user issues, and reconciling the CDR against a customer transaction record.

The Redact API can be used to remove personal data from a CDR stored in the Nexmo platform. Personal data held in the platform generally means a person's phone number, and for messages, the body of the message itself.

To use the Redact API:

1. Make a request to a Nexmo API. Save the ID returned in the response in your database for later reference
2. When you receive a right to erasure request, fetch all IDs associated with that user from your database
3. For each ID, make a request to the [Nexmo Redact API](/api/redact)

To request access to the Nexmo Redact API, please visit [this page](https://info.nexmo.com/RedactAPI.html)

### Product API

Redaction from certain Nexmo APIs is not supported by the Redact API as either the data stored is controlled by the customer, or because Nexmo cannot identify what is personal data and what is not. These cases are detailed below.

#### Voice API

When you use the Voice API to make calls, one or more call resources will be created, as well as call detail records (CDRs). While you can use the Redact API to remove personal data (in this case, the phone number) from the CDR, the call resources themselves will continue to exist.

Call resources are stored as "legs". For instance, if a proxy call is set up between a virtual number V and two other phone numbers A and B, there will be two legs, one between A and V, and one between B and V. These will exist as two separate leg resources with their own unique identifiers.

To determine the identifiers of the leg resources, use the [GET method](/api/conversation#listLegs) and add a query parameter to filter by the `conversationUuid` of the call.

Once the identifiers are known, each leg resource can be deleted with the [DELETE method](/api/conversation#deleteLeg).

#### Call recordings

For voice applications where a call recording is made, e.g. using the [record action](/voice/voice-api/ncco-reference#record) of an NCCO, a media resource will be created which holds the recording. This can be deleted using the `DELETE` method of the [Media API](/api/media#delete-a-media-item).

#### Nexmo Conversation

For the multi-channel communications APIs of Conversation, a developer might decide to use personal data (such as a personal phone number) as a user handle. In that case, the [PUT method](/api/conversation#updateUser) of the User resource could be used to replace the personal data in the resource, or the [DELETE method](/api/conversation#deleteUser) could be used to simply delete the resource completely.

If Conversation messages need to be redacted, the corresponding Event resource can be deleted using the [DELETE method](/api/conversation#deleteEvent).

Note that when a Conversation resource is deleted, it will no longer be available to query via a GET API call. If you need this information, you must store it in your own system/database outside of the Nexmo platform.

## Subject Access Requests

Under GDPR, your customers can come to you and ask for the information that you hold on them. While each organization will need to determine the appropriate way to implement their request process, Nexmo can help by providing data about what information is held in the platform, if necessary.

Data held on an individual by Nexmo can be obtained using the following methods:

* Customer dashboard
* Message search API
* Reporting API

Each of these options is described in more detail in the following sections.

### Customer Dashboard

In the Nexmo Customer Dashboard, it is possible to search for records via a user interface. Generally, searches can be by:

* transaction ID, e.g. find details of a single SMS by providing the message-id
* phone number and date, e.g. find all SMS sent to a specific phone number on a specific date
* date range, e.g. download all messages (up to a limit of 4000) sent between two specific dates

This method might be appropriate if generally very few or only a single message would ever be sent to a single person.

Using the dashboard, you can search for [SMS messages](https://dashboard.nexmo.com/sms), [voice calls](https://dashboard.nexmo.com/voice/search), [Verify requests](https://dashboard.nexmo.com/verify) and [Number Insight requests](https://dashboard.nexmo.com/number-insight).

### Message Search API

This API can be used to search outbound SMS messages. It has two relevant modes:

* A single message's detail can be queried using the individual [message search endpoint](https://developer.nexmo.com/api/developer/messages#search)

* The details of multiple messages can be retrieved simultaneously, either by providing up to 10 message-id values, or by providing a date range to the [messages search endpoint](https://developer.nexmo.com/api/developer/messages#retrieve-multiple-messages)

This method may be used for any customers sending outbound SMS, but does not work for other communication API records such as voice calls.

### Reporting API

This API can be used to download up to 50000 records at a time, or more for enterprise customers. Records can be queried using a variety of parameters such as originating and destination phone numbers, status, date range, and other parameters.

For more information about the Reports API, please [sign up for early access](https://info.nexmo.com/ReportingAPI.html)

## Guides

* [Developer Field Usage Guidance](/redact/guides/developer-field-usage-guidance)

## Reference

* [Redact API Reference](/api/redact)

## Technical Support Impact

Please be aware that redaction of identifying data can have a negative impact on our ability to troubleshoot customer-specific service degradations. As part of our commitment to our customers' success, Nexmo Support will attempt to provide assistance to all customers wherever possible. Typically diagnosis of an issue would start with attempting to identify a specific problematic API call or communication event relating to this issue, or a pattern of related events (messages or calls).

If your system does not log the responses you receive from the Nexmo API (for instance storing the transaction ID and details in a database table or a text file), or it is difficult to access this response data, it is common to identify the transaction relating to an issue via a related phone number or message text body. Examples could include:

* the 'to' phone number for an outbound SMS to the phone of one of your users
* the 'from' phone number for an inbound call to your Nexmo virtual number

If you need to redact a phone number because one of your users has asked to delete their account and data, you can use the Redact API to do this as described above. This means that we will remove the phone number from all of our communications records (also known as "CDRs") in our system.

The side effect of this is that if you want to diagnose an issue with one of these communications events, you will not be able to ask us to help by only providing the phone number; you will instead need to provide the relevant transaction ID or IDs (the same ID you used when making the Redact API call) that were been provided in your initial communications API response. e.g. for SMS, the 'message-id' value. You will therefore need to make sure that if you need to ask for Nexmo Support help relating to the transaction, it is essential that you have saved and can find and access the transaction ID.

We would also be unable to detect an issue based on differential analysis  of a pattern of communications to a single number or range of numbers, such as failed versus successful transactions over time.

Keep in mind that if you have already deleted one of your users and their data from your system, it is probably unlikely that you will need to address a complaint from that user that they did not receive a message or they had a problem with a call.

Note that all communications records containing phone numbers are deleted after thirteen months, so we will not be able to help you diagnose an issue with a communications transaction older than this.
