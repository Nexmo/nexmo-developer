---
title:  CNAM 所有者の詳細の取得
description:` 米国の発信者の ID の詳細を取得します。`navigation_weight:  1

---


CNAM 所有者の詳細の取得
==============

概要
---

Nexmo の Number Insight Advanced API を使用すると、多くの米国の電話番号の CNAM 所有者の詳細を取得できます。これには、消費者と企業の両方の固定電話および携帯電話番号が含まれます。

CNAM は、Caller ID 名を表す頭字語です。米国のネットワークでは、発信者の名前を電話番号とともに表示し、ユーザーが発信者を識別できるようにしています。

> Number Insight Advanced API は、米国の番号の CNAM の詳細のみを提供します。他の国の番号については、この情報を返すことはできません。

リクエストを行う
--------

Advanced API の呼び出しで追加パラメーターとして `cnam=true` を渡すと、その番号の CNAM が検索されます。

次の例は、`curl` を使用して CNAM データをリクエストする方法を示しています。

```bash
$ curl "https://api.nexmo.com/ni/advanced/json?api_key=VONAGE_API_KEY&api_secret=VONAGE_API_SECRET&number=14155550100&cnam=true"
```

応答を理解する
-------

Number Insight Advanced API によって返される応答では、次のフィールドが CNAM に関連しています。

* `caller_name`：所有者名
* `caller_type`：番号の種類に応じて、`business` または `consumer`
* `first_name` および `last_name`：消費者の番号のみ

### 消費者の例

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

### ビジネスの例

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

