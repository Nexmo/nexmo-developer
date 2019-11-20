---
title: Using the Subaccounts API
products: account/subaccounts
description: This topic presents a case study that shows you how to get started with the Subaccounts API.
languages:
    - Curl
---

# Using the Subaccounts API

## Overview

This topic describes a use case where a partner uses the Subaccounts API to successfully manage end customers.

## Prerequisites

You should be familiar with the [main concepts](/account/subaccounts/overview) associated with the Subaccounts API.

## Creating a subaccount

A Partner decides to create a subaccount for each end customer and is therefore able to use distinct API credentials for each of the end customers and see their spending. This is illustrated in the following diagram:

![Subaccounts with shared balance](/assets/images/subaccounts/shared_balance.png)

To create a subaccount the following code can be used:

```code_snippets
source: '_examples/subaccounts/create-subaccount'
```

## Transferring credit

The Partner could not control spending among its end customers because they all shared the same balance. One end customer used to occasionally consume all shared balance effectively blocking access to the Nexmo APIs for other Partner’s end customers. The Partner decided to set individual balance and allocate a credit limit to that end customer.

> **NOTE:** The Partner could have made his accounts prepaid.

Each subaccount can be allocated an individual balance, and a credit limit, as show in the following diagram:

![Credit allocation](/assets/images/subaccounts/credit_allocation.png)

The following code snippet illustrates allocating a specified amount of credit to a subaccount: 

```code_snippets
source: '_examples/subaccounts/transfer-credit'
```

## Checking the balance of all subaccounts

The Partner decides to put monitoring in place. It is possible to periodically check the balance of all of subaccounts using the following code snippet:

```code_snippets
source: '_examples/subaccounts/get-subaccounts'
```

## Additional credit allocation

After some time, the Partner noticed that the end customer 1 (subaccount1) used up all of its credit (40 out of 40) and could not make any more API calls. The Partner had a choice of either waiting for the end customer 1 to pay them (and then in turn making a payment to Nexmo and transferring a corresponding balance to the subaccount) or increasing the end customer’s credit limit immediately so that end customer 1 can continue using the Nexmo API. The Partner decided to allocate additional credit. The Partner has 40 = |-60| - |-20| available credit, and decides to allocate 20 to the subaccount. This is illustrated in the following diagram:

![Additional credit](/assets/images/subaccounts/additional_credit_allocation.png)

## End of month balance transfers

At the end of the month the Partner received a |-20| + |-50| = €70 invoice from Nexmo (for all spending from all its accounts). End customer 1 (subaccount1) covered 45 out of €50 that it had spent. Thus, the Partner transferred €45 to subaccount1's balance. This is illustrated in the following diagram:

![Additional credit](/assets/images/subaccounts/month_end_balance_transfer.png)

The following code shows how to transfer balance to a subaccount:

```code_snippets
source: '_examples/subaccounts/transfer-balance'
```

## Suspending a subaccount

The Partner liked the ability to control the spending of the subaccount and decided to assign individual balance and €30 credit to the end customer 2 (subaccount2). The Partner, who was monitoring the spending of its subaccounts spending, noticed that subaccount2 consumed €25 of its balance. Alarmed by subaccount2's spending rate, the Partner decided to temporarily suspend subaccount2. The code to suspend a subaccount is shown here:

```code_snippets
source: '_examples/subaccounts/suspend-subaccount'
```

## Reactivating a subaccount

After discussions with subaccount2, the Partner decides to reactivate subaccount2's account. This can be achieved using the following code:

```code_snippets
source: '_examples/subaccounts/reactivate-subaccount'
```

## Summary

In this topic you have seen how to use the Subaccounts API to manage end customers in typical scenarios.

## Further resources

* [Concepts](/account/subaccounts/overview)
* [Code Snippets](/account/subaccounts/code-snippets/create-subaccount)
* [API Reference](/api/subaccounts)
