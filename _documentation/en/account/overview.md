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

![Overview](/public/assets/images/account/users.png)

Each of the main items in the diagram is explained in  more detail in the following sections.

## Account

Represents a relationship between clients and Nexmo. Each account is identified with a unique API key (account Id) and contains balance, settings, reports, logs of Nexmo API usage.

## User

Represents a person that manages and configures the account. Users have logins and passwords, and different sets of permissions.

## Subaccounts

Each account can be associated with subaccounts. This division facilitates differential product configuration, reporting, and billing.

An account divided into subaccounts is called a primary account, while subaccounts are considered to be collectively owned and controlled by the primary account. Only one level of hierarchy is allowed, i.e. subaccounts cannot have their own subaccounts.

## Primary user

Primary user is created when Nexmo account is created. There can be only a single primary user for the account and its subaccounts. Primary user can invite other people to register as users. Primary user defines management and oversight rights for new users and the accounts/subaccounts that they will manage.

## API secret

In order to call Nexmo REST APIs, one has to send API key (account ID) and associated secret in the API call. Nexmo will verify that secret is correct and will bill the account identified by the API key.

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

