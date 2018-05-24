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

The free Reporting API can be used to download up to 50,000 records at a time. Customers subscribing to the enterprise package may download an unlimited number of records per report, within practical limits. Records can be queried using a variety of parameters such as originating and destination phone numbers, status, and date range (see report filters for more information).

Features include:

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

This guide shows you how to generate reports by using a free tool such as Postman. Postman is available via Google Chrome or as a standalone application for most platforms. You can find download links here: https://www.getpostman.com/apps

**_To make your life easier we have provided you with sample queries. Import this script file into Postman and update the keys with your details to get started._**

1. Open Postman by going to the Chrome app launcher, or by launching the application you have installed
2. If you are using the scripts provided above, please ensure you have imported them in Postman
3. In the new tab window enter the URL to the report service: https://api.nexmo.com/v1/reports or use the existing script we provided

![figure 1](https://api.media.atlassian.com/file/30999294-51a7-4a4b-9e43-05b6e6445298/image?mode=full-fit&client=ca864b5e-9cbc-4f14-b2f1-ad9c58799b70&token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjYTg2NGI1ZS05Y2JjLTRmMTQtYjJmMS1hZDljNTg3OTliNzAiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpmaWxlOjMwOTk5Mjk0LTUxYTctNGE0Yi05ZTQzLTA1YjZlNjQ0NTI5OCI6WyJyZWFkIl19LCJleHAiOjE1MjcxNzM4MDEsIm5iZiI6MTUyNzE3MDQ0MX0.HTw4_sbEGsBhPysVf7DyaMceWYEwxjFjxHaqQli-fNI)

4. In the body, add the parameters to generate your report (accepted parameters can be found here)

![figure 2](https://api.media.atlassian.com/file/c14bfe30-b299-4744-b065-70624825634b/image?mode=full-fit&client=ca864b5e-9cbc-4f14-b2f1-ad9c58799b70&token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjYTg2NGI1ZS05Y2JjLTRmMTQtYjJmMS1hZDljNTg3OTliNzAiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpmaWxlOmMxNGJmZTMwLWIyOTktNDc0NC1iMDY1LTcwNjI0ODI1NjM0YiI6WyJyZWFkIl19LCJleHAiOjE1MjcxNzM4MTgsIm5iZiI6MTUyNzE3MDQ1OH0.4JOo_rHPTpCHAc6s-28P9mXllnOpyrH-QtxtvWDbRZI)

**_You don't have to specify a callback URL in order to receive your report, but if you do we recommend using either http://webhook.site or https://requestb.in/ for testing. You can get the download URL from the status request in step 6 below. Remember to update the media URL to the one in step 7_**

5. You can use the report status URL provided in the response in the field "self_link" to query the status of the report or you can use the Postman script provided. You must also authenticate with your API key and secret to access the status
Please note that currently you must remove the s in https (https://api.nexmo.com/v1/reports/{file_id}) if using the link in "self_link".

![figure 3](https://api.media.atlassian.com/file/621bd97c-3db2-4055-bddb-2eb84d372789/image?mode=full-fit&client=ca864b5e-9cbc-4f14-b2f1-ad9c58799b70&token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjYTg2NGI1ZS05Y2JjLTRmMTQtYjJmMS1hZDljNTg3OTliNzAiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpmaWxlOjYyMWJkOTdjLTNkYjItNDA1NS1iZGRiLTJlYjg0ZDM3Mjc4OSI6WyJyZWFkIl19LCJleHAiOjE1MjcxNzM4MzMsIm5iZiI6MTUyNzE3MDQ3M30.nnbber8NmylEDpgZe-_-9OdAeTS9PQms5gGXPERY-0o)

    1. To download the report, type https://api.nexmo.com/v3/media/ in your browser
    2. Append the media ID (highlighted in the screenshot below). It should look like this: https://api.nexmo.com/v3/media/9bb028f4-ffcd-4588-97d9-2a9d7ed0e78c
    3. Add your API key and secret. It should now look like this: https://api.nexmo.com/v3/media/9bb028f4-ffcd-4588-97d9-2a9d7ed0e78c?api_key=key&api_secret=secret
    4. Press enter to start the download
    5. When you receive the callback message or when querying the status of the report and the status is set to SUCCESS, you can use the media ID provided in the "url" field to download your report from the media service. See highlighted in the screenshot below

![figure 4](https://api.media.atlassian.com/file/5316f496-2897-40c5-93fa-81a33d85cad5/image?mode=full-fit&client=ca864b5e-9cbc-4f14-b2f1-ad9c58799b70&token=eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjYTg2NGI1ZS05Y2JjLTRmMTQtYjJmMS1hZDljNTg3OTliNzAiLCJhY2Nlc3MiOnsidXJuOmZpbGVzdG9yZTpmaWxlOjUzMTZmNDk2LTI4OTctNDBjNS05M2ZhLTgxYTMzZDg1Y2FkNSI6WyJyZWFkIl19LCJleHAiOjE1MjcxNzI5MTEsIm5iZiI6MTUyNzE2OTU1MX0.gx3glqcx0cOAIrr0A_brzOPevIEM9R6gPQFajMSp1gI)

**_You can include all data from your sub-accounts by specifying the "include_subaccounts" filter and setting its value to 'true'. You can also specify only what API keys to include by using a comma separated list of API keys in the "account_id" filter._**

