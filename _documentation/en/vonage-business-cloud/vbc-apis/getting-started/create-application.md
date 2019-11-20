---
title: Create an Application
description: Create an application to use with the APIs
navigation_weight: 1
---

# Create a Vonage Business Cloud Application

To work with the Vonage Business Cloud APIs, you must create a Vonage Business Cloud Application.

> Note: To avoid confusion, "Application" in this context refers to a logical grouping of APIs. The application you are building to consume these APIs will be referred to as "application".

## Create a new Application

1. Sign into [Vonage UC Extend](https://developer.vonage.com/store/) using your Vonage Business Cloud credentials and select "Vonage Business Cloud" from the Platform drop down list.

2. Select "My Applications" from the left-hand navigation menu.

3. Click "Add Application" at the top of the page.

4. In the Add Application dialog, enter a name and optionally a description for your Application, so that you can locate it easily later. You can limit the maximum number of requests that each access token allows (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication)) in the "Per Token Quota" dropdown. By default it is "Unlimited". Then click the "Add" button.

    ![Screenshot showing the Add Application dialog](/assets/images/vbc/create-application.png)

> Now that you have created your Application, you need to [configure authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication) to enable it to use the VBC APIs.
