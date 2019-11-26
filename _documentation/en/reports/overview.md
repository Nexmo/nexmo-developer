---
title: Overview
meta_title: The Reports API
---


# Reports
The Reports API enables you to download call data records (CDRs). You can filter your CDRs based on attributes such  as origin and destination phone numbers, status, time period and more. [See the list of supported parameters](/api/reports#create-report). You can include the message body/text and download reports for any of your subaccounts.

You can use the Reports API in a wide variety of use cases, including:

* Customer billing - Download your transactions and use the included price data to determine what to bill your customers.
* Invoice reconciliation - Compare your usage data with the invoice you have received.
* Monitoring and analytics - Add CDR data to your business intelligence or analytics system to correlate it with other events.

> The Reports API Beta is available free of charge for all customers until the 1st of March 2020. After that date, charges will be applied if the number of requests exceeds the Free Usage Tier. Please use [this form](https://info.nexmo.com/ReportsAPI.html) to request the API pricing.

## Features

- Searchability - Query your CDRs using a wide range of filters to extract the data you need
- Compressed output - Reports are formatted as CSV and compressed for faster downloads
- Privacy - Report files are automatically deleted after 72 hours
- Full coverage - Reports can fetch up to 13 months of data (which is the maximum retention period for CDRs).
- Callbacks - An HTTP(S) POST callback can be generated to notify when report is completed

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
