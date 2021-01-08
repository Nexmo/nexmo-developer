---
title:  通过 Nexmo CLI 使用 Number Insight
description:  使用 Nexmo CLI 获取有关电话号码的信息。
navigation_weight:  2

---


通过 Nexmo CLI 使用 Number Insight
==============================

概述
---

您可将 [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) 与 Number Insight API 组合使用，而不必使用 `curl` 来创建请求或编写程序代码。本指南将介绍如何操作。

入门
---

### 开始之前：

* 注册一个 [Nexmo 帐户](https://dashboard.nexmo.com/signup)，从而获得访问 Number Insight API 所需的 API 密钥和密码。
* 安装 [Node.JS](https://nodejs.org/en/download/)，您将使用 `npm` (Node Package Manager) 安装 Nexmo CLI。

### 安装并设置 Nexmo CLI（命令行界面）

根据终端提示执行以下命令，以安装 Nexmo CLI：

```bash
$ npm install -g nexmo-cli
```

> *注意* ：如果您没有足够的系统权限，则可能需要在上述命令前面加上前缀`sudo`。

然后，向 Nexmo CLI 提供您的 `VONAGE_API_KEY` 和 `VONAGE_API_SECRET`，这些可在 [Dashboard 入门页面](https://dashboard.nexmo.com/getting-started-guide)
找到：

```bash
$ nexmo setup VONAGE_API_KEY VONAGE_API_SECRET
```

您只需要在首次使用 Nexmo CLI 时执行此操作。

使用 Basic API 尝试自己的号码
--------------------

Number Insight Basic API 可供免费使用。通过使用 `nexmo insight:basic`（或 `nexmo ib`）并用您自己的号码替换显示的号码，使用您自己的号码对其进行测试。号码必须为[国际格式](/voice/voice-api/guides/numbers#formatting)：

```bash
$ nexmo insight:basic 447700900000
```

Nexmo CLI 将显示您输入的号码及其所属的国家/地区：

```bash
447700900000 | GB
```

要查看 Number Insight API 响应中包含的其他详细信息，请使用 `--verbose` 开关（简称 `-v`）：

```bash
$ nexmo insight:basic --verbose 447700900000
```

Basic API 的完整响应包含以下信息：
````
[status]
0

[status_message]
Success

[request_id]
385bf642-d096-4b85-9dfc-4c1910d65300

[international_format_number]
447700900000

[national_format_number]
07700 900000

[country_code]
GB

[country_code_iso3]
GBR

[country_name]
United Kingdom

[country_prefix]
44
````
此可读输出反映 JSON 响应中可用的字段名称和数据：它返回关于请求（`status`、`status_message`、`request_id`）的数据、号码所属国家/地区的详细信息（`country_name`、`country_prefix` 等）以及如何将号码格式化为适合该国家/地区的号码（`national_format_number`）。

> 如果没有看到与前面所示内容类似的响应，请检查您的 API 凭据并确保已正确安装 Node.js 和 `nexmo-cli`。

测试标准和高级 API
-----------

标准和高级 Number Insight API 提供有关号码的更多信息，包括运营商和漫游状态（手机号码）的详细信息。请参阅[功能比较表](/number-insight/overview#basic-standard-and-advanced-apis)，查看每个 API 等级包括的响应数据。

> **注意** ：调用标准和高级 API 并不免费，在使用它们时，系统会要求您确认是否使用您的帐户付费。

### 使用 Number Insight Standard API

要使用 Number Insight Standard API，请使用 `nexmo insight:standard` 命令

```bash
$ nexmo insight:standard --verbose 447700900000
```

标准 API 的典型响应如下所示：
````
[status]
0

[status_message]
Success

[request_id]
aaaaaaaa-bbbb-cccc-dddd-0123456789ab

[international_format_number]
447700900000

[national_format_number]
07700 900000

[country_code]
GB

[country_code_iso3]
GBR

[country_name]
United Kingdom

[country_prefix]
44

[request_price]
0.00500000

[remaining_balance]
1.995

[current_carrier.network_code]
23420

[current_carrier.name]
Hutchison 3G Ltd

[current_carrier.country]
GB

[current_carrier.network_type]
mobile

[original_carrier.network_code]
23410

[original_carrier.name]
Telefonica UK Limited

[original_carrier.country]
GB

[original_carrier.network_type]
mobile

[ported]
assumed_ported
````
### 使用 Number Insight Advanced API

要使用高级 API，请使用 `insight:advanced`（或 `ia`）：

```bash
$ nexmo insight:advanced --verbose 447700900000
```

在响应中查找以下其他字段：
````
[lookup_outcome]
0

[lookup_outcome_message]
Success

[valid_number]
valid

[reachable]
reachable

[roaming.status]
not_roaming
````
`[lookup_outcome]` 和 `[lookup_outcome_message]` 字段告诉您高级 API 是否能够确定号码的有效性（`[valid_number]`）、可接通性（`[reachable]`）和漫游状态（`[roaming.status]`）。

