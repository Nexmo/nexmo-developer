---
title: Download the report
description: Download your completed report
---

# Download the report

When the report is ready (the `request_status` field in the check status request reads `SUCCESS`) you can download the report by making a `GET` request to the URL in the `download_report` field.

## Create the download request

To make the request:

1. Change the HTTP method to `GET`.
2. Enter the `download_report` URL in the address bar.
3. Complete the "Authorization" tab in the same way as before.
4. In the "Body" tab, select the "none" radio button.

![Download the report](/assets/images/reports-api/download-report-postman.png)


## Execute the download request

Click the "Send" button. The response contains unreadable text, because the API returns a compressed CSV file.

Click the "Save Response" button in Postman, select the "Save to a file" option and choose a location on your local machine to save the `.zip` file to.

![Save the compressed file locally](/assets/images/reports-api/save-report-zip-postman.png)

Extract the contents of the `.zip` file and open the `.csv` file to view your report.


