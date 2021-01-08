---
title:  检索 CNAM 所有者详细信息
description: 检索美国呼叫者的身份详细信息。
navigation_weight:  1

---


检索 CNAM 所有者详细信息
===============

概述
---

Nexmo 的 Number Insight Advanced API 可让您检索许多美国电话号码的 CNAM 所有者详细信息。这包括消费者和企业的固定电话号码和手机号码。

CNAM 是指 Caller ID 名称的首字母缩写。美国网络使用 CNAM 在电话号码旁边显示呼叫者的姓名，以帮助用户识别呼叫者。

> Number Insight Advanced API 仅提供美国号码的 CNAM 详细信息：无法为其他国家/地区的号码返回此信息。

发出要求
----

在呼叫高级 API 时，将 `cnam=true` 作为附加参数传递将会查找该号码的 CNAM。

以下示例显示了如何使用 `curl` 请求 CNAM 数据：

```bash
$ curl "https://api.nexmo.com/ni/advanced/json?api_key=VONAGE_API_KEY&api_secret=VONAGE_API_SECRET&number=14155550100&cnam=true"
```

了解响应
----

在 Number Insight Advanced API 返回的响应中，以下字段与 CNAM 相关：

* `caller_name`：所有者姓名
* `caller_type`：`business` 或 `consumer` 取决于号码类型
* `first_name` 和 `last_name`：仅用于消费者号码

### 消费者示例

```json
{
    "status": 0,
    "status_message": "Success",
    "lookup_outcome": 1,
    "lookup_outcome_message": "Partial success - some fields populated",
    "request_id": "50793c0c-8025-408f-ab9a-71cbbaf033bf",
    "international_format_number": "14155550100",
    "national_format_number": "(415) 55500100",
    "country_code": "US",
    "country_code_iso3": "USA",
    "country_name": "United States of America",
    "country_prefix": "1",
    "request_price": "0.04000000",
    "remaining_balance": "10.000000",
    "current_carrier": {
        "network_code": "310004",
        "name": "Verizon Wireless",
        "country": "US",
        "network_type": "mobile"
    },
    "original_carrier": {
        "network_code": "310004",
        "name": "Verizon Wireless",
        "country": "US",
        "network_type": "mobile"
    },
    "valid_number": "valid",
    "reachable": "unknown",
    "ported": "not_ported",
    "roaming": {"status": "unknown"},
    "ip_warnings": "unknown",
    "caller_name": "Wile E. Coyote",
    "last_name": "Coyote",
    "first_name": "Wile",
    "caller_type": "consumer"
}
```

### 企业示例

```json
{
    "status": 0,
    "status_message": "Success",
    "lookup_outcome": 1,
    "lookup_outcome_message": "Partial success - some fields populated",
    "request_id": "27c61a46-5b4a-4e80-b16d-725432559078",
    "international_format_number": "14155550101",
    "national_format_number": "(415) 555-0101",
    "country_code": "US",
    "country_code_iso3": "USA",
    "country_name": "United States of America",
    "country_prefix": "1",
    "request_price": "0.04000000",
    "remaining_balance": "10.000000",
    "current_carrier": {
        "network_code": "US-FIXED",
        "name": "United States of America Landline",
        "country": "US",
        "network_type": "landline"
    },
    "original_carrier": {
        "network_code": "US-FIXED",
        "name": "United States of America Landline",
        "country": "US",
        "network_type": "landline"
    },
    "valid_number": "valid",
    "reachable": "unknown",
    "ported": "not_ported",
    "roaming": {"status": "unknown"},
    "ip_warnings": "unknown",
    "caller_name": "ACME Corporation",
    "caller_type": "business"
}
```

