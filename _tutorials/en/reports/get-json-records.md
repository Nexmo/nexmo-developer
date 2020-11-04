---
title: Get JSON records using command line
description: In this step you learn how to create a JSON report using the command line tool, curl.
---

# Get JSON records using command line

To create a report, send a `GET` request to `https://api.nexmo.com/v2/reports/records`.

The parameters that you include in the request will determine which records are returned.

To obtain a specific record use the ID filter. For example, use the following request to view a status of SMS message with ID `13000000C7FE9025`:

``` shellsession
curl -X GET -u $API_KEY:$API_SECRET "https://api.nexmo.com/v2/reports/records?account_id=$TARGET_API_KEY&product=SMS&direction=outbound&include_message=true&id=13000000C7FE9025"
```

> **NOTE:** `TARGET_API_KEY` can be either your primary account or one of your subaccounts. By providing `API_KEY` and `API_SECRET` belonging to the primary account and `TARGET_API_KEY` belonging to the subaccount, you can obtain records for your subaccount using the primary account credentials. In all other cases set `TARGET_API_KEY` equal to the `API_KEY`.

To obtain records within a specific time period use the `date_start` and `date_end` filters. The records returned describe all API requests that Vonage received from you within this time period. For example, use the following request to view SMS messages sent from your Vonage Account in a 5-minute window between `2020-04-02T12:00:00Z` and `2020-04-02T12:05:00Z`:

``` shellsession
curl -X GET -u $API_KEY:$API_SECRET 'https://api.nexmo.com/v2/reports/records?account_id=$TARGET_API_KEY&product=SMS&direction=outbound&include_message=true&date_start=2020-04-02T12:00:00Z&date_end=2020-04-02T12:05:00Z'
```

> **NOTE:** `date_end` must be no more than 24 hours later than `date_start`.
