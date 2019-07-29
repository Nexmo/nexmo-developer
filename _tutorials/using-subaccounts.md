---
title: Using the Subaccounts API - A case study
products: account/subaccounts
description: This tutorial presents a case study that shows you how to get started with the Subaccounts API.
languages:
    - Curl
---

# Using the Subaccounts API - A case study

## Overview

This tutorial looks at a use case here a partner uses the Subaccounts API to successfully manage end customers. Before working through this tutorial you main want to first review the [main concepts](/account/subaccounts/concepts/overview).

## Creating a subaccount

A Partner decided to create a subaccount for each of its end customers and thus was able to use distinct API credentials for each of its end customers and see their spending.

![Subaccounts with shared balance](/assets/images/subaccounts/shared_balance.png)

```code_snippets
source: '_examples/subaccounts/create-subaccount'
```

## Transferring credit

The Partner could not control spending among its end customers because they all shared the same balance. One end customer used to occasionally consume all shared balance effectively blocking access to the Nexmo APIs for other Partner’s end customers. The Partner decided to set individual balance and allocate a credit limit to that end customer.

> **NOTE:** The Partner could have made his accounts prepaid.

![Credit allocation](/assets/images/subaccounts/credit_allocation.png)

```code_snippets
source: '_examples/subaccounts/transfer-credit'
```

## Checking the balance of all subaccounts

The Partner decided to put monitoring in place and periodically check the balance of all of its end customers:

```code_snippets
source: '_examples/subaccounts/get-subaccounts'
```

## Additional credit allocation

After some time, the Partner noticed that the end customer 1 (subaccount1) used up all of its credit (40 out of 40) and could not make any more API calls. The Partner had a choice of either waiting for the end customer 1 to pay them (and then in turn making a payment to Nexmo and transferring a corresponding balance to the subaccount) or increasing the end customer’s credit limit immediately so that end customer 1 can continue using the Nexmo API. The Partner decided to allocate additional credit. The Partner has 40 = |-60| - |-20| available credit, and decides to allocate 20 to the subaccount.

![Additional credit](/assets/images/subaccounts/additional_credit_allocation.png)

## End of month balance transfers

At the end of the month the Partner received a |-20| + |-50| = €70 invoice from Nexmo (for all spending from all its accounts). End customer 1 (subaccount1) covered 45 out of €50 that it had spent. Thus, the Partner transferred €45 to subaccount1's balance.

![Additional credit](/assets/images/subaccounts/month_end_balance_transfer.png)

```code_snippets
source: '_examples/subaccounts/transfer-balance'
```

## Suspending a subaccount

Partner liked the ability to control the spending of the end customer and decided to assign individual balance and €30 credit to the end customer 2 (subaccount2). The Partner, which was monitoring the spending of its subaccounts spending, noticed that subaccount2 consumed €25 of its balance. Alarmed by subaccount2's spending rate, the Partner decided to temporarily suspend subaccount2.

```code_snippets
source: '_examples/subaccounts/suspend-subaccount'
```

## Summary

In this tutorial you have seen how to use the Subaccounts API to manage end customers.

## Further resources

* [API Reference](/api/subaccounts)
