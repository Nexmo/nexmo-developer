---
title: Overview
---

## Contents

In this document you can learn about:

* [Reports API Overview](#overview)
* [Performance considerations when implementing the Reports API](#performance-considerations)
* [What products are supported by the Reports API](#products-supported)
* [Tutorial](#tutorial)
* [Reference](#reference)

# Overview

The free Reporting API can be used to download up to 50,000 records at a time. Customers subscribing to the enterprise package may download an unlimited number of records per report, within practical limits*. Records can be queried using a variety of parameters such as originating and destination phone numbers, status, and date range (see [report filters](https://ea.developer.nexmo.com/api/reports) for more information).

Practical limits:
* Using the start and end date filters, do not query more than one month data; or
* Do not query more than 10 million records; whichever is the lowest amount of records
* Do not request reports more than twice per day

Benefits include:

* Up to 5 concurrent requests.
* Reports are formatted as CSV (comma separated values).
* All files are compressed for faster downloads.
* Asynchronous processing, minimising network resources tied up in open connections.
* Reports are automatically deleted after 72 hours.
* API responses follow the REST HAL standard to simplify integration in your existing applications.
* More filters available, so that you can query exactly the data you need

Some possible use cases you could implement include:

* Customer billing
    * Download your transactions and use the included price data to determine what to bill your customers
* Invoice reconciliation
    * Compare your usage data with the invoice you have received
* Relate usage to your other data
    * Add usage data to your business intelligence or analytics system to correlate it with other events

## Performance considerations

* 25-30 minutes elapsed time to generate 1 million records
* We recommend that you query less than 20 million records per request, for a reasonable report generation elapsed time
* Prefer infrequent queries of bulk data to many requests for small amounts of data, e.g. one request per day/month, depending upon your usage
* The Reporting API is not suitable for real-time dashboards or monitoring
* For more information about the Reporting API, please sign up for early access here: https://info.nexmo.com/ReportingAPI.html

## Products Supported

* SMS - inbound and outbound
* Voice - SIP and TTS
* Verify API
Support for Number Insight records will be added soon.

## Reference

* [Reports API Reference](/api/reports)

## Tutorial

* [How to generate a report via Postman for non-technical users](link to be added when available)
