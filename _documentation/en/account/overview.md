---
title: Overview
description: This documentation describes the Account API and Subaccounts API
meta_title: Manage your Vonage API account and subaccounts
---

# Overview

Your Vonage API account can be managed in a few different ways:

* Via the [Dashboard](https://dashboard.nexmo.com/)
* Using the [CLI](/tools) (command line interface) tool
* By calling the [API](/api/account) directly or with one of the [Vonage API Server SDKs](/tools) for your preferred technology stack

Within your account you can check your balance, configure the account-level settings, and rotate your API secrets for security purposes.

The overall architecture is illustrated in the following diagram:

![Overview](/assets/images/account/overview.png)

Each of the main items in the diagram is explained in  more detail in the following sections.

## Account

Represents a relationship between clients and Vonage. Each account is identified with a unique API key (account Id) and contains balance, settings, reports, and logs of Vonage API usage.

## Subaccounts

Each account can be associated with one or more [subaccounts](/account/subaccounts/overview). This division allows you to create a hierarchical structure to help manage product configuration, reporting, and billing.

An account divided into subaccounts is called a primary account, while subaccounts are considered to be collectively owned and controlled by the primary account. Only one level of hierarchy is allowed, so subaccounts cannot have their own subaccounts.

## Primary user

A _primary user_ is created when a Nexmo account is created. There can only be a single primary user for the account and its subaccounts. A primary user can invite others to register as team members. A primary user defines management and oversight rights for new team members and the accounts/subaccounts that they will manage.

## Team member

A team member, formerly referred to as a _secondary user_, represents a user that manages and configures one or more accounts via the [Dashboard](https://dashboard.nexmo.com/). Team members have usernames and passwords to login to the [Dashboard](https://dashboard.nexmo.com/), and different sets of permissions to define what they can manage via the Dashboard.

## API secret

In order to make an API call with the Vonage APIs, an API key (account ID) is required, as well as an associated API secret. Vonage verifies that the secret is correct and bills the account identified by the API key.

## Guides

```concept_list
product: account
```

## Code Snippets

Code snippets demonstrate how to use the API to perform various tasks.

```code_snippet_list
product: account
```

## See also

* [Secret Management overview](/account/secret-management)
* [Subaccounts](/account/subaccounts/overview)
