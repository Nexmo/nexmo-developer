---
title: Create a report using command line
description: In this step you learn how to create a report using the command line tool, curl.
---

# Create a Report

To create a report, you send a `POST` request to `https://api.nexmo.com/v2/reports`. The parameters that you include in the request will determine which records are returned.

For example, use the following request to view all SMS messages sent from your Nexmo Account in June 2019:

```bash
curl -X POST https://api.nexmo.com/v2/reports/ \
  -u $API_KEY:$API_SECRET \
  -H "Content-Type: application/json" \
  -d '{"account_id": "API_KEY","product": "SMS","direction": "outbound","date_start": "2019-06-01T00:00:00+0000","date_end": "2019-07-01T00:00:00+0000"}'
```

The response contains a `request_id`. Make a note of this as you will need it to [check the report status](/reports/tutorials/create-and-retrieve-a-report/reports/check-report-status).

> **Note**: When you filter using a date range, `start_date` is inclusive, but `end_date` is exclusive. This means that the above example would not include any SMS messages sent at `00:00:00`.

For a full list of the filter parameters available, see the [Reports API reference](/api/reports).
