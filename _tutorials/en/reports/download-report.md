---
title: Download a report
---

# Download a report

Once the report has been generated, you can download the results using the Media API.


```bash
curl -u $API_KEY:$API_SECRET -o report.zip DOWNLOAD_URL
```

Replace `DOWNLOAD_URL` with the link provided in the `download_report` field in the [report status response](/reports/tutorials/create-and-retrieve-a-report/reports/check-report-status).

Running the above command will download the report in to the current folder as a file named `report.zip`. Unzip this compressed file to see your report.
