---
title: Nexmo Account Dashboard
description: How to use the Nexmo dashboard
---

# Using the Nexmo Dashboard for Account management

Dashboard is a web application that makes it easy to:

* Manage your account - setup and configure your Nexmo account
* Manage payments - top up your account balance, configure notifications and generate invoices
* Manage numbers - view and buy virtual numbers and short codes
* Analyze your API use - each product has a dedicated page you use to search and interpret the results of your API requests
* Manage your team - you can create team members who have controlled access to your primary account or [subaccounts](/account/subaccounts/overview)

## Contents

* [Create and configure a Nexmo account](#create-and-configure-a-nexmo-account)
* [Retrieve your account information](#retrieve-your-account-information)
* [Manage your team](#manage-team)
* [Manage your profile](#manage-your-profile)
* [Reset your password](#reset-your-password)
* [Supported browsers](#supported-browsers)

## Create and configure a Nexmo account

To create your free Nexmo account:

1. In your browser, navigate to [Dashboard](https://dashboard.nexmo.com/sign-up).
2. Add  your company information and click **Sign up**.
   Nexmo sends a PIN to your phone as a text message or automated phone call. The timeout for each verification attempt is 5 minutes.
   **Note**: you can associate a phone number with one account only. If your phone number is already associated with a Nexmo account you should [remove that phone number](#manage-your-profile) from the existing account.
3. In **Phone number verification**, enter the PIN sent to you by Nexmo and click **Verify**.
  You are logged into Dashboard and shown how to start developing with Nexmo. This page is displayed each time you login until you have made your first successful call with Nexmo API.

When you create your Nexmo account you are given €2 free test credit and your account is set in DEMO mode. You can use our products to send messages to up to 10 destination numbers, *[Nexmo DEMO]* is added to all the SMS you send. To move out of the Demo mode [add credit to your account](/numbers/guides/payments#add-a-payment-method).

For very few countries Nexmo cannot create a Nexmo account automatically. This is because of payment restrictions or legal trading restrictions for a US registered company.

## Retrieve your account information

To retrieve your Nexmo account information:

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. On the top-right of Dashboard, click the arrow next to **&lt;username>**, then click **Settings**.
3. In **API settings**, you see your **API key** and **API secret**. You need these values for all API calls.

## Manage your team

When you setup your Nexmo account you create your primary user. The primary user has unlimited access to your Nexmo products and services. The primary user can:

* Manage payments and view your payment history
* Rent virtual numbers and short codes
* Search through your requests
* Analyze your API use

After setup, you can add team members to your Nexmo account. A team member can have the same access rights as your primary user or a restricted set. For example, you can create a team member with no access to payments.

To create a team member:

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. On the top-right of Dashboard, click the arrow next to **&lt;username>**, then click **Team**.
3. Click **Invite team member**.
4. Add the team member information, assign one or more API keys, and then choose any restrictions you want to apply.
5. Click **Invite**.
6. Your team member uses the temporary password they receive in an email to access the Dashboard and then create a new password.

Team members then use the *api_key* and *api_secret* associated with any assigned accounts to connect to Nexmo API endpoints.

## Manage your profile

Dashboard uses the information you gave during setup to create your Nexmo profile. This includes:

* Contact information - phone number, email, Skype and password.
* Company information - name, address and VAT number.

To change your profile information:

1. [Sign in](https://dashboard.nexmo.com/sign-in) to Dashboard.
2. On the top-right of Dashboard, click the arrow next to **&lt;username>**, then click **Edit profile**.
3. Update your contact or company information, then click **Save changes**.

## Reset your password

To reset your Nexmo password:

1. Navigate to [Forgot your password?](https://dashboard.nexmo.com/sign-in/forgot-password).
2. Enter the email address associated with your Nexmo account and click **Reset password**.
3. You receive a password reset link at the email address associated with your Nexmo account. This link is valid for 15 minutes.
4. Navigate to the reset link and reset your password.

If you are still having issues, please contact <support@nexmo.com>.
