---
title:  Nexmo CLI を介した Number Insight の使用
description: Nexmo CLI を使用して、電話番号に関する情報を取得します。
navigation_weight:  2

---


Nexmo CLI を介した Number Insight の使用
=================================

概要
---

[Nexmo CLI](https://github.com/Nexmo/nexmo-cli)を使用すると、`curl` を使用してリクエストを作成したり、プログラムコードを記述したりすることなく、Number Insight API を操作できます。このガイドでは、その方法を説明します。

最初のステップ
-------

### 始める前に：

* [Nexmo アカウント](https://dashboard.nexmo.com/signup)へのサインアップ - これにより、Number Insight API にアクセスするために必要な API キーとシークレットが付与されます。
* [Node.JS](https://nodejs.org/en/download/)のインストール - `npm` (ノードパッケージマネージャー) を使用して Nexmo CLI をインストールします。

### Nexmo CLI のインストールとセットアップ (コマンドラインインターフェース)

ターミナルプロンプトで次のコマンドを実行して、Nexmo CLI をインストールします。

```bash
$ npm install -g nexmo-cli
```

> *注* ：十分なシステム権限がない場合は、上記のコマンドの前に `sudo` を付ける必要があります。

次に、Nexmo CLI に `VONAGE_API_KEY` と `VONAGE_API_SECRET` を提供します。これらは、Dashboard の[最初のステップページ](https://dashboard.nexmo.com/getting-started-guide)にあります。

```bash
$ nexmo setup VONAGE_API_KEY VONAGE_API_SECRET
```

この操作は、Nexmo CLI を初めて使用する場合にのみ行う必要があります。

Basic API で自分の番号を試す
-------------------

Number Insight Basic API は無料で使用できます。`nexmo insight:basic` (または `nexmo ib`) を使用し、表示されている番号を自分の番号に置き換えて、自分の番号でテストします。番号は、[国際形式](/voice/voice-api/guides/numbers#formatting)でなければなりません。

```bash
$ nexmo insight:basic 447700900000
```

Nexmo CLI には、入力した番号とその番号の国が表示されます。

```bash
447700900000 | GB
```

Number Insight API からの応答に含まれるその他の詳細を表示するには、`--verbose` スイッチ (または、略して `-v`) を使用します。

```bash
$ nexmo insight:basic --verbose 447700900000
```

Basic API からの完全な応答には、次の情報が含まれています。
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
この人間に読める形式の出力は、JSON 応答で使用可能なフィールド名とデータを反映しており、リクエストに関するデータ (`status`、`status_message`、`request_id`)、番号が属する国の詳細 (`country_name`、`country_prefix` など) およびその国に合わせて番号を適切にフォーマットする方法 (`national_format_number`) を返します。

> 上記のような応答が表示されない場合は、API の認証情報をチェックし、Node.js と `nexmo-cli` が正しくインストールされていることを確認してください。

Standard API および Advanced API をテストする
------------------------------------

Standard および Advanced Number Insight APIは、オペレーターの詳細やローミングステータス (携帯電話番号の場合) など、番号に関するさらに多くの情報を提供します。各 API レベルに含まれる応答データについては、[機能の比較表](/number-insight/overview#basic-standard-and-advanced-apis)を参照してください。

> **注** ：Standard API および Advanced API への呼び出しは無料ではなく、利用時にアカウントに請求するかどうかを確認するよう求められます。

### Number Insight Standard API の使用

Number Insight Standard API を使用するには、`nexmo insight:standard` コマンドを使用します

```bash
$ nexmo insight:standard --verbose 447700900000
```

標準 API からの一般的な応答は、次のようになります。
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
### Number Insight Advanced API の使用

Advanced API を使用するには、`insight:advanced` (または `ia`) を使用します。

```bash
$ nexmo insight:advanced --verbose 447700900000
```

応答で次の追加フィールドを探します。
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
`[lookup_outcome]` フィールドと `[lookup_outcome_message]` フィールドは、Advanced API が番号の有効性 (`[valid_number]`)、リーチャビリティ (`[reachable]`)、ローミングステータス (`[roaming.status]`) を判断できたかどうかを示します。

