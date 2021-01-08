---
title:  付款
description: 管理付款、启用帐户自动充值功能并获取余额通知
navigation_weight:  43

---


付款
===

您可以使用 PayPal、Visa、MasterCard、微信支付（仅限澳大利亚、中国、中国香港、印度尼西亚、马来西亚、新西兰、菲律宾和台湾地区）或银行转账为 Nexmo 帐户充值。出于安全原因，您只能将信用卡或 PayPal 帐户与一个 Nexmo 帐户关联。

> 有关付款方式的更多信息，请参阅此[知识库文章](https://help.nexmo.com/hc/en-us/articles/213129327)。

一键付款是指使用帐户绑定的信用卡快速而便捷地进行交易您无需重新输入信用卡详细信息，因为这些详细信息存储在我们的付款服务提供商 (PSP) [Braintree](https://www.braintreepayments.com/) 中。Braintree（由 PayPal 拥有）[符合 PCI 1 级标准](https://www.braintreepayments.com/gb/features/data-security)。

> Nexmo 不会根据其 PCI 合规性认证来存储、管理或传输任何完整的信用卡信息。Nexmo 已提交并通过 PCI DSS 自我评估问卷（商家合规性），可应要求提供相关证据。

如果我们通过电子邮件或服务台票证从任何客户那里收到任何信用卡信息，我们会立即将其删除，并通知您该信息已删除。

管理付款
----

您可以使用 Nexmo 开发人员 Dashboard：

* [添加付款方式](#add-a-payment-method)
* [自动充值帐户余额](#auto-reload-your-account-balance)
* [设置余额通知](#setup-balance-notifications)
* [删除付款方式](#delete-a-payment-method)
* [更改余额币种](#change-balance-currency)
* [生成发票](#generate-invoices)

### 添加付款方式

要将付款方式添加到您的 Nexmo 帐户：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，点击用户名旁边的箭头，然后点击 **账单与付款** 。
3. 如果您看到“升级帐户”消息，请点击 **升级帐户** 。
4. 选择一种付款方式、付款金额并填写帐单邮寄地址详细信息，然后点击 **下一步** 。请注意，必须使用与信用卡或 Paypal 帐户关联的地址才能成功付款。
5. 填写所选付款方式的详细信息，然后点击 **付款** 
6. 将保存您选择的付款方式，用于未来的一键付款。您还可以设置[自动充值](#auto-reload-your-account-balance)功能。如果您未在 Paypal 付款页面中看到自动充值选项，请发送电子邮件至 [support@nexmo.com](mailto://support@nexmo.com)，添加该功能。

付款将在您的银行/信用卡对帐单上显示为 **Nexmo** 

### 自动充值帐户余额

您可以启用自动充值功能，以在帐户余额低于特定金额时自动为其充值。

默认情况下，自动充值功能使用您保存的付款方式和[添加付款方式](#add-a-payment-method)时指定的交易金额进行充值，但您可以根据需要指定其他方式或自动充值金额。

启用自动充值功能后，系统将每六分钟检查一次您的帐户余额。如果您要发送大量消息，则当 [SMS API 响应](/api/developer/account#top-up)中的 `remaining-balance` 低于指定金额时，请使用[开发人员 API](/api/sms#send-an-sms) 管理充值。

> 目前，开发人员 API 仅支持 PayPal 自动充值功能。

如果您已有保存的付款方式：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，点击用户名旁边的箭头，然后点击 **账单与付款** 。
3. 将自动充值功能设置为 **开启** 。
4. 从下拉列表中选择保存的付款方式，帐户充值金额以及您希望帐户自动充值的阈值。
5. 点击 **保存** 。

如果您还没有保存的付款方式：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，点击用户名旁边的箭头，然后点击 **账单与付款** 。
3. 选择“添加新的付款方式”。
4. 在页面右上角的下拉菜单中，点击 **付款** 。
5. 选择您的付款类型，然后输入您的付款方式帐单信息。
6. 通过 PayPal 或输入您的信用卡详细信息来完成付款。自动充值功能不支持银行转帐。
7. 在付款成功页面的右侧，启用 **保存付款方式** 和 **自动充值** 功能。
8. 设置您的自动充值阈值和充值金额，然后点击 **保存** 。

### 设置余额通知

当您的帐户余额达到零时，您将无法再使用我们的 API，而您的虚拟号码也会被取消。因此，必须确保您的帐户始终有余额。

要在您的帐户余额低于特定金额时接收电子邮件，请执行以下操作：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，点击用户名旁边的箭头，然后点击 **账单与付款** 。
3. 将您的电子邮件地址添加到 **发票和余额提醒** 中。
4. 启用 **余额提醒** 并设置 **余额阈值** 。
5. 点击 **保存更改** 。

系统每小时会自动检查您的帐户余额是否不足。

> 您还可以使用开发人员 API 以编程方式[查询您的帐户余额](/api/developer/account#get-balance)。

### 删除付款方式

要从您的帐户中删除付款方式，请执行以下操作：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，点击用户名旁边的箭头，然后点击 **账单与付款** 。
3. 选择要删除的付款方式。
4. 点击信用卡或 PayPal 图标旁边的链接。您会看到付款方式的帐单信息。
5. 点击 **删除** 以删除此付款方式。

### 更改余额币种

默认情况下，您的余额将以欧元显示。然而，您也能够以美元 (USD) 查看余额。

要更改余额显示的币种：

1. 登录到[开发人员 Dashboard](https://dashboard.nexmo.com)。
2. 在左侧导航菜单中，点击用户名旁边的箭头，然后点击 **设置** 。
3. 将 **选择显示余额所用币种** 设置为您选择的货币。

> **注意** ：这只会更改 Dashboard 中的显示内容。由于 Nexmo 的经营货币是欧元，您将始终以欧元计费。以美元显示的价格随美元兑换欧元的汇率波动。

### 生成发票

Nexmo 通过第三方提供商生成发票。当您索要发票时，我们的提供商会将发票发送到与您的帐户关联的电子邮件地址或[设置](https://dashboard.nexmo.com/billing-and-payments/settings)中指定的财务电子邮件地址。发票以公司名称打印。如果您使用多个 Nexmo 帐户，则必须在每个 [帐户资料](https://dashboard.nexmo.com/edit-profile target:_blank) 中设置不同的公司名称 。

您可以通过 Dashboard 为每笔付款生成一次发票：

* 银行转帐 - 创建新付款时，系统会通过电子邮件将形式发票发送给您。最终发票在收到付款后立即生成。银行需要 1-3 个工作日处理付款。
* PayPal - 收到付款后会自动生成最终发票。您可以从[帐单和付款](https://dashboard.nexmo.com/billing-and-payments)中下载此发票。
* 信用卡 - 待付款期间，最多需要 72 个小时才能生成发票。在此期间，您无法从[帐单和付款](https://dashboard.nexmo.com/billing-and-payments)中下载发票。

使用 **帐单和付款** 底部的 **下载交易 (.xls)** 和[帐户活动 (.xls)](https://dashboard.nexmo.com/billing-and-payments) 链接查看所有帐户活动。

