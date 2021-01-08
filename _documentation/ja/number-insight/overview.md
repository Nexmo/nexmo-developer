---
title:  概要
meta_title:  Number Insight API
description:  Vonage の Number Insight API は、電話番号の有効性、リーチャビリティ、ローミングステータスに関するリアルタイムのインテリジェンスを提供し、アプリケーションで番号を正しくフォーマットする方法を示します。(Nexmo は Vonage になりました)

---


Number Insight API の概要
======================

Vonage の Number Insight API は、電話番号の有効性、リーチャビリティ、ローミングステータスに関するリアルタイムのインテリジェンスを提供し、アプリケーションで番号を正しくフォーマットする方法を示します。(Nexmo は Vonage になりました)

内容
---

このドキュメントでは、次の内容について説明します。

* [コンセプト](#concepts) - 知っておくべきこと
* [Basic、Standard、Advanced API のレベル](#basic-standard-and-advanced-apis) - それぞれの機能を理解する
* **[Number Insight API の最初のステップ](#getting-started)** - お試しください
* [ガイド](#guides) - Number Insight API の使用方法に関する説明
* [コードスニペット](#code-snippets) - 特定のタスクに役立つコードスニペット
* [ユースケース](#use-cases) コードサンプルを使った詳細なユースケース
* [関連情報](#reference) - API の完全なドキュメント

基本概念
----

* [Webhook](/concepts/guides/webhooks)- Advanced API を使用して、番号に関する包括的なデータを Webhook 経由でアプリケーションの利用可能時に返すことができます。

Basic、Standard および Advanced API
-------------------------------

各 API レベルは、前のレベルの機能に基づいて構築されます。たとえば、Standard API には、Basic API からのすべてのロケールとフォーマット情報が含まれており、番号のタイプ、移植されているかどうか、Caller ID (米国のみ) に関する追加データを返します。Advanced API は、最も包括的なデータを提供します。これには Basic API と Standard API で使用できるすべてのものが含まれ、ローミングとリーチャビリティの情報も追加されています。

> 同期 API である Basic API と Standard API とは異なり、Advanced API は非同期的な使用を意図しています。

### 一般的なユースケース

* **Basic API** ：番号がどの国に属しているかを検出し、その情報を使用して数字を正しくフォーマットします。
* **Standard API** ：番号が固定電話か携帯電話かを判断し (音声と SMS 連絡先のどちらかを選択)、仮想番号をブロックします。
* **Advanced API** ：番号に関連するリスクを確認します。

### 機能の比較

| 機能                      | Basic | Standard | Advanced |
|:------------------------|:-----:|:--------:|:--------:|
| 番号の形式と発信元               |   ✅   |    ✅     |    ✅     |
| ネットワークのタイプ              |   ❌   |    ✅     |    ✅     |
| 通信会社と国                  |   ❌   |    ✅     |    ✅     |
| 移植されている                 |   ❌   |    ❌     |    ✅     |
| 有効性                     |   ❌   |    ❌     |    ✅     |
| リーチャビリティ (米国では利用不可) |   ❌   |    ❌     |    ✅     |
| ローミングステータス              |   ❌   |    ❌     |    ✅     |
| ローミングの通信会社と国            |   ❌   |    ❌     |    ✅     |
| **米国の番号** の発信者の名前とタイプ   |   ❌   |    ✅     |    ✅     |

> ユーザーのローミング情報の保存が許可されていることを確認するには、お住まいの国の法律を確認してください。

最初のステップ
-------

この例では、[Nexmo CLI](/tools)を使用して Number Insight Basic API にアクセスし、番号に関する情報を表示する方法を示します。

> `curl` および開発者 SDK で Basic、Standard、および Advanced Number Insight を使用する方法の例については、[コードスニペット](#code-snippets)を参照してください。

### 始める前に：

* [Vonage API アカウントに](https://dashboard.nexmo.com/signup)サインアップする
* [Node.JS](https://nodejs.org/en/download/)をインストールする

### Nexmo CLI のインストールとセットアップ
````
$ npm install -g nexmo-cli
````
> 注：ユーザーの権限によっては、上記のコマンドの前に `sudo` を付ける必要があります。

[Dashboard の最初のステップページ](https://dashboard.nexmo.com/getting-started-guide)から `VONAGE_API_KEY` と `VONAGE_API_SECRET` を使用して、ご自分の認証情報で Nexmo CLI をセットアップします。
````
$ nexmo setup VONAGE_API_KEY VONAGE_API_SECRET
````
### Number Insight API Basic の検索を実行する

以下に示すサンプルコマンドを実行し、電話番号を情報が必要な番号に置き換えます。
````
nexmo insight:basic 447700900000
````
### 応答を表示する

Basic API の応答では、番号とその番号が存在する国が一覧表示されます。以下は一例です。
````
447700900000 | GB
````
`--verbose` フラグ (または `-v`) を使用して、Basic API 応答に含まれるすべてのものを確認します。
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
ガイド
---

```concept_list
product: number-insight
```

コードスニペット
--------

```code_snippet_list
product: number-insight
```

ユースケース
------

```use_cases
product: number-insight
```

関連情報
----

* [Number Insight API の関連情報](/api/number-insight)

