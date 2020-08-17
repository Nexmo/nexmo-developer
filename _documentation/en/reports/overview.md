---
title: Overview
meta_title: The Reports API
description: When you use our communication APIs, server logs and transactional records of the activity are created, which are called CDRs (Call Detail Record). The Reports API enables you to download your CDRs. You can filter your CDRs based on attributes such  as origin and destination phone numbers, status, time period and more.  (Nexmo is now Vonage)
---

# Reports API

When you use our communication APIs, server logs and transactional records of the activity are created, which are called CDRs (Call Detail Record). The Reports API enables you to download your CDRs. You can filter your CDRs based on attributes such  as origin and destination phone numbers, status, time period and more. [See the list of supported parameters](/api/reports). You can include the message body/text and download reports for any of your subaccounts.

You can use the Reports API in a wide variety of use cases, including:

* Customer billing - Download your transactions and use the included price data to determine what to bill your customers.
* Invoice reconciliation - Compare your usage data with the invoice you have received.
* Monitoring and analytics - Add CDR data to your business intelligence or analytics system to correlate it with other events.

You can query your CDRs using a wide range of filters. Data records are kept for thirteen months (maximum retention period). Records older than 13 months cannot be obtained because they are automatically deleted from the system.

## Synchronous and asynchronous operation

Depending on your query pattern, you can choose from one of the two approaches for the Reports API:

1. Synchronous
2. Asynchronous

The *synchronous* version is optimized for frequent and periodic retrievals of small batches of data records. Typical batch sizes range from one record to tens of thousands per query.

The *asynchronous* version is optimized for infrequent and large data queries. Typical batch sizes range from several thousand records to tens of millions.

## Feature summary

The following table compares the features of the synchronous and asynchronous methods of using the Reports API:

Feature  | Reports Synchronous (GET endpoint) | Reports Asynchronous (POST endpoint)
---- | ---- | ----
 Data retrieval | Returns results immediately in batches of up to 1000 records. Response contains a batch of data records and a link to the next batch (if any) | Does not return data immediately. Instead, it records a data request, processes it asynchronously, and creates a file containing all records. When the results file is ready, it returns a link to the file
 Output format | JSON | CSV
 Compression | Not applicable | CSV file is compressed for faster downloads
 Report TTL | Not applicable | Report files are automatically deleted after 72 hours
 Time filter  | Can fetch up to 24 hours of data in one query | Can fetch up to 13 months (maximum retention period) of data in one query
 ID filter  | Can fetch one data record by its ID | Does not support ID filtering
 Message body  | Can fetch message body | Can fetch message body
 Subaccounts  | Requires a separate request for each subaccount | Requires one report request. It automatically groups data records belonging to subaccounts into one report
 Callbacks | Not applicable | An HTTP(S) POST callback can be generated to notify when report is completed

> **A note on performance**: Even though the Reports API is fast and can deal with enormous amounts of data, it may become slower when trying to download data for realtime analytics. Using sensible filters can speed up processing considerably.

## Supported products

* SMS API
* Messages API
* Voice API
* Conversations API
* Verify API
* Number Insight API

## Pricing (subject to change)

> The Reports API Beta is available free of charge for all customers until the 1st of October 2020. After that date, charges will be applied if the number of requests exceeds the Free Usage Tier. Free Usage Tier applies only to create CSV report `POST` requests. **Please use [this form](https://info.nexmo.com/ReportsAPI.html) to request the Reports API pricing.**

As part of the Free Usage Tier, you can create ten reports per month per account (API key) for free. Generated reports are not limited in size and can fetch up to thirteen months of data (maximum retention period for CDRs).

Charges are applied based on the quantity of requests and the volume of data retrieved as listed in the following table:

Resource | Price
---- | ----
Report generation | 0.0002€ per CDR

### Pricing example (`POST` requests)

Assume you create an SMS report to retrieve one day of data and this report contains 10,000 CDRs. If you still have some free reports left (for example, you created six reports this calendar month so you can only create four more reports for free), then you will not be charged for this report. If you have already used your free monthly reports, then the total charge for this report will be the following:

```
Charge = 10,000 * 0.0002€ = 2€
```

### Pricing example (`GET` requests)

Assume you want to retrieve SMS records for the last one minute, and it turns out that there are 300 records in this time period. The total charge for this report will be the following:

```
Charge = 300 * 0.0002€ = 0.06€
```

`GET` Requests (create and get JSON report) can return records either by ID or by a time period they belong to. Search by ID is not time-bounded. Time period search supports ranges of up to 24 hours.

> Pricing information documented here is provisional and is subject to change.

## Code Snippets

```code_snippet_list
product: reports
```

## Tutorials

* [Create a CSV report using the command line](/reports/tutorials/create-and-retrieve-a-report)
* [Create a CSV report using a graphical tool](/reports/tutorials/create-report-using-graphical-tools)
* [Get JSON records using the command line](/reports/tutorials/get-json-records-cli)

## API Reference

* [Reports API Reference](/api/reports)
