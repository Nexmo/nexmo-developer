---
title: Overview
description: This documentation describes the Account API and Subaccounts API
meta_title: Manage your Nexmo account and subaccounts
---

# Overview

Your Nexmo account can be managed in a few different ways:

* Via the [Dashboard](https://dashboard.nexmo.com/)
* Using the [CLI](/tools) (command line interface) tool
* By calling the [API](/api/account) directly or with one of the [Nexmo client libraries](/tools) for your preferred technology stack

Within your account you can check your balance, configure the account-level settings, and rotate your API secrets for security purposes.

The overall architecture is illustrated in the following diagram:

![Overview](/assets/images/account/users.png)

Each of the main items in the diagram is explained in  more detail in the following sections.

## Account

Represents a relationship between clients and Nexmo. Each account is identified with a unique API key (account Id) and contains balance, settings, reports, and logs of Nexmo API usage.

## User

Represents a person that manages and configures the account via the [Dashboard](https://dashboard.nexmo.com/). Users have usernames and passwords to login to the [Dashboard](https://dashboard.nexmo.com/), and different sets of permissions to define what users can manage via the Dashboard.

## Subaccounts

Each account can be associated with [subaccounts](/account/subaccounts/overview). This division facilitates differential product configuration, reporting, and billing.

An account divided into subaccounts is called a primary account, while subaccounts are considered to be collectively owned and controlled by the primary account. Only one level of hierarchy is allowed, so subaccounts cannot have their own subaccounts.

## Primary user

A _primary user_ is created when a Nexmo account is created. There can only be a single primary user for the account and its subaccounts. A primary user can invite others to register as users. A primary user defines management and oversight rights for new users and the accounts/subaccounts that they will manage.

## API secret

In order to make an API call with the Nexmo REST APIs, an API key (account ID) is required, as well as an associated API secret. Nexmo verifies that the secret is correct and bills the account identified by the API key.

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
