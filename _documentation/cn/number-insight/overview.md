---
title:  概述
meta_title:  Number Insights API
description:  Vonage 的 Number Insight API 提供有关电话号码有效性、可接通性和漫游状态的实时情报，并告诉您如何在应用程序中正确格式化号码。（Nexmo 现已更名为 Vonage）

---


Number Insight API 概述
=====================

Vonage 的 Number Insight API 提供有关电话号码有效性、可接通性和漫游状态的实时情报，并告诉您如何在应用程序中正确确定号码的格式。（Nexmo 现已更名为 Vonage）

目录
---

本文档包含以下信息：

* [概念](#concepts) - 您需要了解的内容
* [基本、标准和高级 API 等级](#basic-standard-and-advanced-apis) - 了解它们的不同功能
* **[Number Insight API 入门](#getting-started)** - 试用
* [指南](#guides) - 了解如何使用 Number Insight API
* [代码片段](#code-snippets) - 帮助完成特定任务的代码片段
* [用例](#use-cases) - 带有代码示例的详细用例
* [参考](#reference) - 完整的 API 文档

概念
---

* [Webhook](/concepts/guides/webhooks) - 您可以使用高级 API 通过 Webhook 将有关号码的全面数据返回给您的应用程序。

基本、标准和高级 API
------------

每个 API 等级都基于前一个等级的功能。例如，标准 API 包含基本 API 的所有语言环境和格式化信息，并返回有关号码类型、是否带端口以及呼叫者身份（仅美国）的额外数据。高级 API 提供最全面的数据。它包括基本和标准 API 中可用的所有内容，并添加漫游和可接通性信息。

> 与作为同步 API 的基本 API 和标准 API 不同，高级 API 设计为异步使用。

### 典型用例

* **基本 API** ：确定号码所属的国家/地区，并使用信息正确格式化号码。
* **标准 API** ：确定电话号码是固定电话还是手机号码（在语音和 SMS 联系人之间进行选择）并屏蔽虚拟号码。
* **高级 API** ：确定与号码相关的风险。

### 功能比较

| 功能                | 基本 | 标准 | 高级 |
|:------------------|:--:|:--:|:--:|
| 号码格式和来源           | ✅  | ✅  | ✅  |
| 网络类型              | ❌  | ✅  | ✅  |
| 运营商和国家/地区         | ❌  | ✅  | ✅  |
| 带端口               | ❌  | ❌  | ✅  |
| 有效性               | ❌  | ❌  | ✅  |
| 可接通性（在美国不可用）      | ❌  | ❌  | ✅  |
| 漫游状态              | ❌  | ❌  | ✅  |
| 漫游运营商和国家/地区       | ❌  | ❌  | ✅  |
| **美国号码** 呼叫者姓名和类型 | ❌  | ✅  | ✅  |

> 查看您所在国家/地区的法律，以确保您可以保存用户的漫游信息。

入门
---

本示例说明如何使用 [Nexmo CLI](/tools) 访问 Number Insight Basic API 并显示有关号码的信息。

> 有关如何将基本、标准和高级 Number Insight 与 `curl` 以及开发人员 SDK 组合使用的示例，请参见[代码片段](#code-snippets)。

### 开始之前：

* 注册一个 [Vonage API 帐户](https://dashboard.nexmo.com/signup)
* 安装 [Node.JS](https://nodejs.org/en/download/)

### 安装并设置 Nexmo CLI
````
$ npm install -g nexmo-cli
````
> 注意：根据您的用户权限，您可能需要在上述命令前面加上前缀 `sudo`。

使用 [Dashboard 入门页面中](https://dashboard.nexmo.com/getting-started-guide)的 `VONAGE_API_KEY` 和 `VONAGE_API_SECRET` 以及您的凭据设置 Nexmo CLI：
````
$ nexmo setup VONAGE_API_KEY VONAGE_API_SECRET
````
### 执行 Number Insight API 基本查找

执行以下所示的示例命令，将电话号码替换为您想要相关信息的号码：
````
nexmo insight:basic 447700900000
````
### 查看响应

基本 API 响应会列出号码以及该号码所属的国家/地区。示例：
````
447700900000 | GB
````
使用 `--verbose` 标志（或 `-v`）查看基本 API 响应中包含的所有内容：
````
$ nexmo insight:basic --verbose 447700900000

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
````
指南
---

```concept_list
product: number-insight
```

代码片段
----

```code_snippet_list
product: number-insight
```

用例
---

```use_cases
product: number-insight
```

参考
---

* [Number Insight API 参考](/api/number-insight)

