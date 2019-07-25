---
title: Overview
meta_title: Subaccounts API
navigation_weight: 1
description: The Subaccounts API overview.
---

# Subaccounts API Overview

The Subaccounts API allows to programmatically create and manage subaccounts for separate business units, use cases, product stages, or separate customers. The API empowers developers to handle various aspects of subaccount logistics: manage credit, track usage, set usage limits, suspend subaccounts, and so on.

The figure below illustrates the relationship between the primary account and the subaccounts created by the Subaccounts API:

![Subaccounts Overview](/assets/images/subaccounts/structure.png)

## Beta

This API is currently in Beta.

Nexmo always welcomes your feedback. Your suggestions help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include the Subaccounts API in the subject line.

During Beta Nexmo will expand the capabilities of the API.

## Supported features

In this release the following features are supported:

* Create a new subaccount
* Assign individual or shared balance to the subaccount
* Transfer credit (provided by Nexmo) from the primary account to the subaccount and vice versa
* Transfer balance from the primary account to the subaccount and vice versa
* List all subaccount balances and credits
* Show total credit and total balance across all subaccounts
* Suspend/re-activate the subaccount

## Reference

* [API Reference](/api/subaccounts)
