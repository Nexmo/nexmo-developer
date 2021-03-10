---
title: 10 DLC guidelines for US customers
navigation_weight: 6
description: Understanding 10 DLC guidelines for US based SMS.
---

# Important 10 DLC guidelines for US customers

10 DLC stands for 10 Digit Long Code. Major US carriers have announced their requirements for a new standard for application-to-person (A2P) messaging in the USA, which applies to all messaging over 10 digit geographic phone numbers, also know as 10 DLC. This new standard provides many benefits including supporting higher messaging speeds and better deliverability.

Customers using the Vonage SMS API to send traffic from a **+1 Country Code 10 Digit Long Code into US networks** will need to register a brand and campaign in order to get approval for sending messages. 

> **Note:** US numbers can no longer be shared across brands which include both geographic numbers and US Shared Short Codes.

> Vonage customers using US shared short codes:
T-Mobile and AT&T’s new code of conduct prohibits the use of shared originators, therefore, **Shared Short codes** will no longer be an acceptable format for A2P messaging.
    
* Vonage customers using a Shared Short Code must migrate SMS traffic to either a [10 DLC](https://help.nexmo.com/hc/en-us/articles/360027503992-US-10-DLC-Messaging), [Toll Free SMS Number](https://help.nexmo.com/hc/en-us/articles/115011767768-Toll-free-Numbers-Features-Overview), or  [Dedicated Short Code](https://help.nexmo.com/hc/en-us/articles/360050950831). 
* Vonage customers using our Shared Short Code API ***must migrate*** to either our [SMS API](/messaging/sms/overview) or [Verify API](/verify/overview).
* Customers using Dedicated Short Codes are not affected by these changes within the scope of 10 DLC.

To learn more about 10 DLC including important dates and carrier-specific information, see the knowledge base.

If you have decided moving to 10 DLC is right for your campaigns, you must:
    1. [Register your brand](#register-a-brand)
    2. Register a campaign (coming soon)
    3. Link a number (coming soon)

## Register a brand

1. Navigate to [Vonage API dashboard > SMS > Brands and campaigns](https://dashboard.nexmo.com/sms/brands).
2. Click **Register a new brand**.
3. Fill in all required fields on the **Register a new brand** form.
4. Click **Review details**. A confirmation dialog box opens.
5. Review your brand details.
6. Click **Register and pay**.
    
> **Note:** You will not be able to change your brand details after registering.

Your brand information is displayed in the Brand list on the Brands and campaigns page where you can monitor the status of its registration and view more details.

## Register a campaign

1. Navigate to [Vonage API dashboard > SMS > Brands and campaigns](https://dashboard.nexmo.com/sms/brands).
2. Click **Register a new campaign**. 
    The **Create a new campaign** page is displayed.
3. Under **Step 2 Use case**, select the checkbox associated with the use case that best describes this campaign. The use case describes the specific purpose of the campaign; for instance, marketing or account notifications you wish to send to customers.
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
11. Under **Step 6 Campaign and content attributes**, select the attribtes that apply to this campaign. For instance, select **Subscriber opt-out** if messages sent for this campaign provide customers the opportunity to opt-out. Select all attributes that apply.
12. Click **Review and pay**.
    A confirmation dialog box opens summarizing your campaign details. Any charges to your account are indicated above the campaign details. You will not be able to change the campaign details after registering.
13. Click **Register and pay**.
    The campaign is displayed in the **Campaigns** list on the **Brands and campaigns** page.
