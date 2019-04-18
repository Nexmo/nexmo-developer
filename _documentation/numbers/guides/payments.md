---
title: Payments
description: Manage payments, enable account auto reload, and get balance notifications
navigation_weight: 43
---

# Payments

You can top up your Nexmo account using PayPal, Visa, MasterCard, WeChat Pay (Australia, China, Hong Kong, Indonesia, Malaysia, New Zealand, Philippines and Taiwan only) or a bank transfer. For security reasons you can associate a credit card or PayPal account with only one Nexmo account.

> For more information on payment options, see [this knowledge base article](https://help.nexmo.com/hc/en-us/articles/213129327).

One-click payments are quick and easy transactions made with a credit card stored for your account. You don't need to re-enter your credit card details as these are stored with our Payment Service Provider (PSP), [Braintree](https://www.braintreepayments.com/). Braintree (owned by PayPal) is [PCI level 1 compliant](https://www.braintreepayments.com/gb/features/data-security).

> Nexmo does not store, manage or transmit any complete credit card information in accordance with its PCI Compliance certification. Nexmo has submitted and passed PCI DSS Self-Assessment Questionnaire Merchant Compliance and can produce evidence of this upon request.

If we receive any credit card information from any of our customers in an email or helpdesk ticket, we will immediately delete it and notify you that the information has been removed.

## Managing payments

You can use the Nexmo developer dashboard to:

* [Add a payment method](#add-a-payment-method)
* [Auto reload your account balance](#auto-reload-your-account-balance)
* [Setup balance notifications](#setup-balance-notifications)
* [Delete a payment method](#delete-a-payment-method)
* [Change balance currency](#change-balance-currency)
* [Generate invoices](#generate-invoices)

### Add a payment method

To add a payment method to your Nexmo account:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click the arrow next to your user name, then click **Billing & payments**.
3. If you see an "Upgrade your account" message, click **Upgrade account**.
4. Select a payment method, payment amount and complete your billing address details and then click **Next**. Note that you must use the address associated with the card or Paypal account for the payment to be successful.
5. Complete the details for your chosen payment method, then click **Make payment**
6. The payment method you chose is saved for future one-click payments. You can also set up [auto reload](#auto-reload-your-account-balance). If you do not see auto reload as an option in the Paypal payments page, email [support@nexmo.com](mailto://support@nexmo.com) to add the capability.

Payments will appear as **Nexmo** on your bank/card statements.

### Auto reload your account balance

You can enable auto reload to top up your account balance automatically when it falls below a certain level.

By default, auto reload uses your stored payment method and the transaction amount you specified when you [added a payment method](#add-a-payment-method) but you can specify a different method or amount for auto reload if you wish.

When auto-reload is enabled your account balance is checked every six minutes. If you are sending a lot of messages, use the [Developer API](/api/developer/account#top-up) to manage reloads when `remaining-balance` in the [SMS API response](/api/sms#send-an-sms) goes below a specified amount. 

> Currently only PayPal auto-reload is available with the Developer API.

If you already have a saved payment method:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click the arrow next to your user name, then click **Billing & payments**.
3. Set Auto reload to **ON**.
4. Choose your saved payment method from the dropdown, the amount to top up your account by and the threshold amount at which you want your account to be automatically replenished.
5. Click **Save**.

If you do not already have a saved payment method:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click the arrow next to your user name, then click **Billing & payments**.
3. Select "Add a new payment method".
4. On the dropdown in the top right hand of the page click **Make payment**.
5. Select your payment type and enter your payment method billing information.
6. Complete your payment either via PayPal or by entering your credit card details. Auto reload is not available for bank transfers.
7. On the right-hand side of the payment success page, enable **Save payment method** and **Auto reload**.
8. Set your auto reload threshold and top up amount and click **Save**.

### Setup balance notifications

When the balance in your account reaches zero you can no longer use our APIs and your virtual numbers are cancelled. Therefore it is important to ensure that your account is always in credit.

To receive an email whenever your account balance falls below a certain level:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click the arrow next to your user name, then click **Billing & payments**.
3. Add your email address to **Invoice & balance alerts**.
4. Enable **Balance alert** and set the **Balance threshold**.
5. Click **Save changes**.

Your account is automatically checked for a low balance every hour.

> You can also use the Developer API to [query your account balance](/api/developer/account#get-balance) programmatically.

### Delete a payment method

To remove a payment method from your account:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click the arrow next to your user name, then click **Billing & payments**.
3. Select the payment method you want to remove.
4. Click the link next to the credit card or PayPal icon. You see the billing information for the payment method.
5. Click **Delete** to remove this payment method.

### Change balance currency

By default, your balance is displayed in Euros. However, you can also view your balance in US Dollars (USD).

To change the currency your balance is displayed in:

1. Sign in to the [developer dashboard](https://dashboard.nexmo.com).
2. In the left-hand navigation menu, click the arrow next to your user name, then click **Settings**.
3. Set **Display balance in** to your chosen currency.

> **Note**: This only changes the display in the Dashboard. Because Nexmo's operating currency is the Euro you are always charged in Euros. Prices shown in USD fluctuate with the USD-EUR exchange rate.

### Generate invoices

Nexmo uses a third party provider to generate invoices. When you request an invoice our provider sends the invoice to either the  email address associated with your account or the finance email address defined in [Settings](https://dashboard.nexmo.com/billing-and-payments/settings). Invoices are printed by company name. If you use multiple Nexmo accounts you must set a different company name in each [account profile](https://dashboard.nexmo.com/edit-profile target:_blank).

You can generate an invoice from Dashboard once for each payment:

* Bank transfers - a pro-forma invoice is emailed to you when you create a new payment. The final invoice is generated upon receipt of payment. Banks take 1-3 working days to process payments.
* PayPal - the final invoice is automatically generated upon receipt of payment. You download this invoice from [Billing & Payments](https://dashboard.nexmo.com/billing-and-payments).
* Credit cards - take up to 72 hours to be generated while the payment is pending. During this period you cannot download the invoice from [Billing & Payments](https://dashboard.nexmo.com/billing-and-payments).

Use the **Download Transactions (.xls)** and **Account Activity (.xls)** links at the bottom of [Billing & Payments](https://dashboard.nexmo.com/billing-and-payments) to see all account activity.
