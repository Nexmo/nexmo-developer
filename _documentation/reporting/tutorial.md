This guide shows you how to generate reports by using a free tool such as Postman. Postman is available via Google Chrome or as a standalone application for most platforms. You can find download links here: https://www.getpostman.com/apps

**_To make your life easier we have provided you with sample queries. Import this [script file](https://www.getpostman.com/collections/aa8f31ac59cc332f8b1e) into Postman and update the keys with your details to get started._**

1. Open Postman by going to the Chrome app launcher, or by launching the application you have installed
2. If you are using the scripts provided above, please ensure you have imported them in Postman
3. In the new tab window enter the URL to the report service: https://api.nexmo.com/v1/reports or use the existing script we provided

![figure 1](https://github.com/13webstreet/nexmo-developer/blob/patch-8/public/assets/images/figure%201.png)

4. In the body, add the parameters to generate your report (accepted parameters can be found here)

![figure 2](https://github.com/13webstreet/nexmo-developer/blob/patch-8/public/assets/images/figure%202.png)

**_You don't have to specify a callback URL in order to receive your report, but if you do we recommend using either http://webhook.site or https://requestb.in/ for testing. You can get the download URL from the status request in step 6 below. Remember to update the media URL to the one in step 7_**

5. You can use the report status URL provided in the response in the field "self_link" to query the status of the report or you can use the Postman script provided. You must also authenticate with your API key and secret to access the status.

![figure 3](https://github.com/13webstreet/nexmo-developer/blob/patch-8/public/assets/images/figure%203.png)

    1. To download the report, type https://api.nexmo.com/v3/media/ in your browser
    2. Append the media ID (highlighted in the screenshot below). It should look like this: https://api.nexmo.com/v3/media/9bb028f4-ffcd-4588-97d9-2a9d7ed0e78c
    3. Add your API key and secret. It should now look like this: https://api.nexmo.com/v3/media/9bb028f4-ffcd-4588-97d9-2a9d7ed0e78c?api_key=key&api_secret=secret
    4. Press enter to start the download
    5. When you receive the callback message or when querying the status of the report and the status is set to SUCCESS, you can use the media ID provided in the "url" field to download your report from the media service. See highlighted in the screenshot below

![figure 4](https://github.com/13webstreet/nexmo-developer/blob/patch-8/public/assets/images/figure%204.png)

**_You can include all data from your sub-accounts by specifying the "include_subaccounts" filter and setting its value to 'true'. You can also specify only what API keys to include by using a comma separated list of API keys in the "account_id" filter._**

