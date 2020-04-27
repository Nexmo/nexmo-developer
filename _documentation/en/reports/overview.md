---
title: Overview
meta_title: The Reports API
---

# Reports

The Reports API enables you to download call data records (CDRs). You can filter your CDRs based on attributes such  as origin and destination phone numbers, status, time period and more. [See the list of supported parameters](/api/reports). You can include the message body/text and download reports for any of your subaccounts.

You can use the Reports API in a wide variety of use cases, including:

* Customer billing - Download your transactions and use the included price data to determine what to bill your customers.
* Invoice reconciliation - Compare your usage data with the invoice you have received.
* Monitoring and analytics - Add CDR data to your business intelligence or analytics system to correlate it with other events.

> The Reports API Beta is available free of charge for all customers until the 1st of May 2020. After that date, charges will be applied if the number of requests exceeds the Free Usage Tier. Please use [this form](https://info.nexmo.com/ReportsAPI.html) to request the API pricing.

## Features

You can query your CDRs using a wide range of filters. Data records are kept for thirteen months (maximum retention period). Records older than 13 months cannot be obtained because they are automatically deleted from the system.
Depending on your query pattern, you can choose from one of the two versions of Reports API: asynchronous and synchronous. Asynchronous version is optimized for infrequent and large data queries (from several records to tens of millions). Synchronous version is optimized for frequent and periodic retrievals of small batches of data records (from one record to tens of thousand per query).

Feature  | Reports Synchronous (GET endpoint) | Reports Asynchronous (POST endpoint)
---- | ---- | ----
 Data retrieval | Returns results immediately in batches of up to 1000 records. Response contains a batch of data records and a link to the next batch (if any) | Does not return data immediately. Instead, it records a data request, processes it asynchronously, and creates a file containing all records. When the results file is ready, it returns a link to the file
 Output format | JSON | CSV
 Compression | Not applicable | CSV file is compressed for faster downloads
 Report TTL | Not applicable | Report files are automatically deleted after 72 hours
 Time filter  | Can fetch up to 1 hour of data in one query | Can fetch up to 13 months (maximum retention period) of data in one query
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
* Number Insight

## Tutorials

* [Create a report using the command line](/reports/tutorials/create-and-retrieve-a-report/)
* [Create a report using a graphical tool](/reports/tutorials/create-report-using-graphical-tools)

## API Reference

* [Reports API Reference](/api/reports)
