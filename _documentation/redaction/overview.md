---
title: Overview
---

# Overview

As part of our General Data Protection Regulation (GDPR) program, Nexmo provide an API that allows you to manage personally identifiable information within the Nexmo platform. The redaction API allows you to redact information on demand, providing a solution for your own compliance needs.

### Right to erasure requests

Under GDPR (and other privacy regulatory environments), a person may ask you to remove any data being held about them. This could typically happen when someone terminates their relationship with a vendor, e.g. the user of a dating app no longer needs the service, and asks the dating app vendor to delete their account and all the information it holds about them.

## Contents

In this document you can learn about:

* [Nexmo Redaction Concepts](#concepts)
* [Subject Access Requests](#subject-access-requests)
* [Guides](#guides)
* [Reference](#reference)

## Concepts

There are two ways that you can redact personal information from the Nexmo platform, the Redaction API and the general product APIs. Each of these options has a different use case and interaction model.

### Redaction API

When you use Nexmo communication APIs, we create a transaction record of the activity, which we call a `CDR` (short for `call detail record`, a telecommunications industry term). This can be viewed by our customers and support staff for various purposes, including testing and debugging, diagnosing user issues, and reconciling the CDR against a customer transaction record.

The redaction API can be used to remove personal data from a CDR stored in the Nexmo platform. Personal data held in the platform generally means a person's phone number, and for messages, the body of the message itself.

To use the redaction API:

1. Make a request to a Nexmo API. Save the ID returned in the response in your database for later reference
2. When you receive a right to erasure request, fetch all IDs associated with that user from your database
3. For each ID, make a request to the [Nexmo redaction API](/api/redaction)

### Product API

Some Nexmo APIs are not covered by the automatic redaction API as the data stored is controlled by the customer. These cases are detailed below

#### Call recordings

For voice applications where a call recording is made, e.g. using the [record action](/api/voice/ncco#record) of an NCCO, a media resource will be created which holds the recording. This can be deleted using the `DELETE` method of the [media API](/api/media#delete-a-media-item)

#### Nexmo Stitch

For the multi-channel communications APIs of Stitch, a developer might decide to use personal data (such as a personal phone number) as a user handle. In that case, the [PUT method](/api/stitch#updateUser) of the User resource could be used to replace the personal data in the resource, or the [DELETE method](/api/stitch#deleteUser) could be used to simply delete the resource completely.

If Stitch messages need to be redacted, the corresponding Event resource can be deleted using the [DELETE method](/api/stitch#deleteEvent)

## Subject Access Requests

Under GDPR, your customers can come to you and ask for all of the information that you hold on them. While each organisation will need to determine the appropriate way to implement their request process, Nexmo can help by providing data about what information is held in the platform, if necessary.

Data held on an individual by Nexmo can be obtained using the following methods:

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

* Multiple messages' details can be retrieved simultaneously, either by providing up to 10 message-id values, or by providing a date range to the [messages search endpoint](https://developer.nexmo.com/api/developer/messages#retrieve-multiple-messages)

This method may be used for any customers sending outbound SMS, but does not work for other communication API records such as voice calls.

### Reporting API

This API can be used to download up to 50000 records at a time, or more for enterprise customers. Records can be queried using a variety of parameters such as originating and destination phone numbers, status, date range, and other parameters.

For more information about the Reports API, please [sign up for early access](https://info.nexmo.com/ReportingAPI.html)

## Guides

* [Developer Field Usage Guidance](/redaction/guides/developer-field-usage-guidance)

## Reference

* [Redaction API Reference](/api/redaction)

