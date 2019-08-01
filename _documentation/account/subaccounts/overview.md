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

## Provisioning

Subaccounts API is released with restricted availability. To get access to the Subaccounts API please contact your account manager. [Nexmo Partners](https://info.nexmo.com/PartnerProgram.html) get access automatically.

## Supported features

In this release the following features are supported:

* Create a new subaccount
* Assign individual or shared balance to the subaccount
* Transfer credit (provided by Nexmo) from the primary account to the subaccount and vice versa
* Transfer balance from the primary account to the subaccount and vice versa
* List all subaccount balances and credits
* Show total credit and total balance across all subaccounts
* Suspend/re-activate the subaccount

## Concepts

### Account balance and credit

All Nexmo accounts have an associated account balance. It shows the amount of funds available for spending. The account balance is deducted each time a chargeable API call is made. When account balance reaches zero, chargeable API calls cannot be executed unless the account has a credit line provided by Nexmo. If an account has a credit, then its account balance can go below zero. A postpaid account is an account that has credit, a prepaid account is an account without credit.

The amount of credit available to the customer is called a `credit_limit`. Thus, any postpaid account that has a positive balance has `account_balance + |credit_limit|` funds available for spending. A prepaid account has only `account_balance` available for spending.

![Account balance](/assets/images/subaccounts/account_balance.png)

### Subaccount creation

By default, a newly created subaccount shares its balance with the primary account, that is, any charges resulting from the subaccount's activity are applied directly to the primary account's balance.

To create a subaccount with its own balance (all charges resulting from the subaccount's activity are applied directly to the subaccount's balance), you need to set parameter `use_primary_account_balance` to `FALSE`. This change is irreversible. The subaccount with its own balance cannot be at a later stage converted back to the subaccount with a shared balance.

### Postpaid and prepaid subaccounts

Subaccounts with individual balance can be either prepaid or postpaid. Subaccounts that share balance with the primary account cannot be prepaid/postpaid because the shared balance belongs to the primary account.

Primary account type | Postpaid subaccounts | Prepaid subaccounts | Subaccounts with shared balance
-- | -- | -- | --
Postpaid primary account | ✅ | ✅ | ✅ 
Prepaid primary account | ❌ | ✅ | ✅ 

**Key:**
* ✅ = Supported.
* ❌ = Not supported. 

If a primary account is prepaid, then the created subaccounts are also prepaid. If the primary account is postpaid, then the created subaccounts can be either postpaid or prepaid.

A subaccount (with individual balance) becomes postpaid only if the primary postpaid subaccount allocates some of its credit to the subaccount (the credit amount is zero for the prepaid subaccount). Therefore, prepaid primary accounts that do not have credit cannot have postpaid subaccounts.

Feature | Postpaid subaccount | Prepaid subaccount | Subaccount with shared balance
-- | -- | -- | --
Individual balance | ✅ | ✅ | n/a
Individual credit | ✅ | 0 | n/a

**Key:**
* ✅ = Supported.
* n/a = Not applicable.

### Balance transfer

A newly created subaccount with a shared balance can perform API calls directly, assuming the corresponding primary account's balance or credit (provided by Nexmo) is non-zero. A newly created subaccount with individual balance initially has a zero balance and therefore cannot make API calls. One needs to transfer some amount from the primary account to the the subaccount.

> RULE: Balance_available_for_transfer = |account_balance - credit_limit|

It means that the primary account can transfer funds to the secondary account, and these funds can come either from its balance (assuming it is positive) or from the credit provided by Nexmo. It is also possible to transfer balance from the subaccount back to the primary account, but direct transfer of balance between subaccounts is not supported.

Example: A postpaid primary account that initially had a zero balance and was given €100 in credit by Nexmo already used 20€ of the provided credit, that is, its balance was €-20. It had still €80 = |-20 - -100| that it could either spend itself or transfer to one of its subaccounts. The postpaid primary account decided to transfer €20 to Subaccount1. The primary account's balance became €-40 after this operation.

![Balance transfer](/assets/images/subaccounts/balance_transfer.png)

### Credit allocation

A primary account is considered postpaid if it has a credit provided by Nexmo. The postpaid primary account can allocate a part of its credit to one of its subaccounts. Thus, it is possible to have a subaccount with a zero balance but non-zero credit. This subaccount will be able to make API calls until the allocated credit runs out. In general, any account that has a positive balance has `account_balance + |credit_limit|` funds available for spending.

> RULE: Credit_available_for_allocation =  |credit_limit| - |account_balance|, if account_balance < 0 AND |credit_limit|, if account_balance > 0

It means that the primary account can allocate credit that has not been already spent or allocated to the secondary account, and vice versa (credit that was not used by the subaccount can be returned to the primary account).

Example: After spending €20 and transferring another €20 to subaccount1, the postpaid primary account's balance dropped to €-40, and it decided to assign individual balance to Subaccount2 and to allocate €35 out of its remaining credit to it. The primary account had |-100| - |-40| = €60 in credit available for allocation. After the credit allocation operation, the primary account's remaining credit line became €65: |credit_limit| = |-100| - 35 = €65.

![Credit allocation](/assets/images/subaccounts/credit_allocation.png)

### Charges and monitoring of spending

Nexmo charges for the actual Nexmo API usage, but the way it is captured and applied differs for prepaid and postpaid accounts. Subaccounts inherit the prices of the primary account.

### Prepaid primary account

After top up, prepaid accounts receive a positive balance that gets deducted later with API usage. When zero balance is reached, the prepaid account cannot make any more API calls (until another top up). A prepaid primary account that distributed its entire balance across its subaccounts would not be able to make API calls, but its subaccounts with positive balance would still be able to make API calls:

* The `total_balance` field returned by the Subaccounts API represents the amount of balance left across all subaccounts and the primary account from the initial top up made by the primary account.
* The `balance` field returned by the Subaccounts API shows the amount of balance left for each individual account including the primary account and subaccounts.

### Postpaid primary account

A postpaid primary account is responsible for spending of all of its subaccounts and its own spending (from the primary API key). The value that captures the total amount owned to Nexmo is the negative `total_balance` (positive `total_balance` means that nothing is owned to Nexmo). At the end of the month, Nexmo invoices a postpaid primary account for all usage on all its API keys (accounts) in that month. In theory, the total invoice amount would equal the `total_balance` across all accounts (all usage plus payments made).

Example: In the previous example, subaccount1's balance was 20, subaccount2's balance was 0, and the primary account's balance was -40. The total balance for the prepaid primary account and its subaccounts is: `total_balance = -40 + 20 + 0 = -20`.

## Best practices

* A Nexmo Partner should possess and manage a Nexmo primary account and should create subaccounts for its end customers.
* The Partner should not use its primary API key (account) to perform API calls. If the Partner wants to use Nexmo API itself, the Partner should create another subaccount.
* When an end customer is close to using out all of its credit limit the Partner should either allocate additional credit limit to the end customer or wait for the end customer to pay before increasing end customer’s balance, otherwise the end customers API calls will be temporarily blocked.
* The Partner should not transfer any balance to the end customer’s subaccount unless the end customer has paid the equivalent amount of money to the Partner.
* It is up to partners to choose the mode of payment for their end customers: postpaid end customers with allocated credit limit or prepaid end customers with zero in credit limit but with pre-allocated balance.

## Reference

* [Code Snippets](/account/subaccounts/code-snippets/create-subaccount)
* [API Reference](/api/subaccounts)
