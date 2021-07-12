---
title: Overview
description: Understanding 10 DLC guidelines for US based SMS.
---

# 10 DLC Registration API

10 DLC stands for 10 Digit Long Code. Major US carriers have announced their requirements for a new standard for application-to-person (A2P) messaging in the USA, which applies to all messaging over 10 digit geographic phone numbers, also know as 10 DLC. This new standard provides many benefits including supporting higher messaging speeds and better deliverability.

Customers using the Vonage SMS API to send traffic from a **+1 Country Code 10 Digit Long Code into US networks** will need to register a brand and campaign in order to get approval for sending messages. 

## Contents

* [Migration to 10 DLC](#migration-to-10-dlc)
* [General Workflow](#general-workflow)
* [Register a Brand](#register-a-brand)
* [Register a Campaign](#register-a-campaign)
* [Troubleshooting](#troubleshooting)

## Migration to 10 DLC

> **Note:** US numbers can no longer be shared across brands which include both geographic numbers and US Shared Short Codes.

> Vonage customers using US shared short codes:
T-Mobile and AT&T’s new code of conduct prohibits the use of shared originators, therefore, **Shared Short codes** will no longer be an acceptable format for A2P messaging.
    
* Vonage customers using a Shared Short Code must migrate SMS traffic to either a [10 DLC](https://help.nexmo.com/hc/en-us/articles/360027503992-US-10-DLC-Messaging), [Toll Free SMS Number](https://help.nexmo.com/hc/en-us/articles/115011767768-Toll-free-Numbers-Features-Overview), or  [Dedicated Short Code](https://help.nexmo.com/hc/en-us/articles/360050950831). 
* Vonage customers using our Shared Short Code API ***must migrate*** to either our [SMS API](/messaging/sms/overview) or [Verify API](/verify/overview).
* Customers using Dedicated Short Codes are not affected by these changes within the scope of 10 DLC.

To learn more about 10 DLC including important dates and carrier-specific information, see the knowledge base.

## General Workflow

If you have decided moving to 10 DLC is right for your campaigns, you must:
    
    1. [Register your brand](#register-a-brand)

    2. [Register a campaign] (#register-a-campaign)

    3. Link a number (coming soon)

## Register a brand

A Brand is a company that has a need to send SMS messages to customers or users. Each brand can have multiple Campaigns associated with them. A Vonage Account may have multiple brands associated with it, but a Brand may only be registered with Vonage once. For example, Vonage Account ABCD may register brands on behalf of their own customers, Company X and Company Y. Vonage Account EFGH may not register Company X in that case.

Public information about a brand/company is used to determine what Campaigns they are allowed to run.

Currently only public or private companies and non-profits may be registered. "Personal" accounts cannot be registered, and may be more suitable for a Toll Free Number instead.

### Via Dashboard

1. Navigate to [Vonage API dashboard > SMS > Brands and campaigns](https://dashboard.nexmo.com/sms/brands).
2. Click **Register a new brand**.
3. Fill in all required fields on the **Register a new brand** form.
4. Click **Review details**. A confirmation dialog box opens.
5. Review your brand details.
6. Click **Register and pay**.
    
> **Note:** You will not be able to change your brand details after registering.

Your brand information is displayed in the Brand list on the Brands and campaigns page where you can monitor the status of its registration and view more details.

### Via the API

```code_snippets
source: '_examples/messaging/10dlc/register-a-brand'
```

## Register a campaign

A Campaign is a notification that a brand will be sending a specific type of message to customers. Campaigns generally have limited use cases associated with them, like Notifications or Two Factor Authentication messages. Each campaign is tied to a single brand, and contains its own pool of numbers. A number cannot be associated with multiple campaigns.

### Via the Dashboard

1. Navigate to [Vonage API dashboard > SMS > Brands and campaigns](https://dashboard.nexmo.com/sms/brands).
2. Click **Register a new campaign**. 
    The **Create a new campaign** page is displayed.
3. Under **Step 2 Use case**, select the check box associated with the use case that best describes this campaign. The use case describes the specific purpose of the campaign; for instance, marketing or account notifications you wish to send to customers.
4. Click **Done**.
5. Under **Step 3 Carrier qualification**, you can determine whether or not your use case has been approved for sending SMS traffic. Qualification is done by 10DLC enabled carriers. If your use case was rejected, or if your throughput is insufficient, you can appeal through Brand Vetting which is done through a 3rd party.
6. Click **Done**.
7. Under Step 4 Campaign details: 
    1. In the **Selected brand** field, identify the brand associated with this campaign.
    2. From the **Vertical** drop-down menu, select the vertical associated with your brand.
    3. In the **Campaign description** field, type a brief description of this campaign.
8. Click **Done**.
9. Under **Step 5 Sample messages**, type up to five examples of messages that will be sent for this campaign. 
10. Click **Done**.
11. Under **Step 6 Campaign and content attributes**, select the attributes that apply to this campaign. For instance, select **Subscriber opt-out** if messages sent for this campaign provide customers the opportunity to opt-out. Select all attributes that apply.
12. Click **Review and pay**.
    A confirmation dialog box opens summarizing your campaign details. Any charges to your account are indicated above the campaign details. You will not be able to change the campaign details after registering.
13. Click **Register and pay**.
    The campaign is displayed in the **Campaigns** list on the **Brands and campaigns** page.

### Via the API

```code_snippets
source: '_examples/messaging/10dlc/register-a-campaign'
```

## Troubleshooting

All error messages that are returned will be returned in the RFC 7807 JSON Format:

```json
{
  "type": "https://developer.nexmo.com/api-errors#unauthorized",
  "title": "Invalid credentials supplied",
  "detail": "You did not provide correct credentials.",
  "instance": "797a8f199c45014ab7b08bfe9cc1c12c"
}
```

Each API Endpoint may have various error messages that can be returned, as well as various HTTP status codes that help indicate the type of failure. In general:

* 2xx responses indicate success
* 400 will indicate a general client-side error, and should contain additional information for resolving the error
* 401 will indicate invalid credentials
* 404 will indicate a missing resource
* 409 will indicate a conflicting operation that may still be pending operations from The Campaign Registry
* 422 will indicate a data validation error, and should contain additional information for correcting the invalid data

Additional information can be found in the OpenAPI specification for individual endpoint errors.
