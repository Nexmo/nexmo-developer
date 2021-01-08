---
title:  Nexmo CLI
meta_title:  Nexmo コマンドラインインターフェース (CLI)
Description:  Nexmo CLI を使用して、アプリケーションを作成および管理できます。
navigation_weight:  2

---


Nexmo CLI を使用したアプリケーションの管理
==========================

Nexmo CLI を使用すると、Vonage アプリケーションを作成および管理できます。ヘルプを取得するには、CLI のインストール後に `nexmo` と入力してください。

インストール
------

Nexmo CLI (ベータ版) は、次のコマンドを使用してインストールできます。

```shell
npm install -g nexmo-cli@beta
```

最新のベータ版には、コマンドラインでアプリケーション API V2 をサポートするすべての機能が含まれています。次のコマンドを使用して、インストールされているバージョンを確認できます。

```shell
nexmo --version
```

アプリケーションの一覧表示
-------------

現在のアプリケーションを一覧表示するには、次を使用します：

```shell
nexmo app:list
```

これにより、アプリケーション ID と名前を示すリストが表示されます。

アプリケーションの詳細を表示する
----------------

特定のアプリケーションの詳細を表示するには (`APP_ID` は既存のアプリケーションのアプリケーション ID です)：

```shell
nexmo app:show APP_ID
```

次のようなものが返されます：

```shell
[id]
61fd1849-280d-4722-8712-1cc59aa12345

[name]
My Client SDK App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MII...n9efcS+L...
-----END PUBLIC KEY-----

[_links.self.href]
/v2/applications/61fd1849-280d-4722-8712-1cc59aa12345

[voice.webhooks.0.endpoint_type]
event_url

[voice.webhooks.0.endpoint]
https://example.ngrok.io/webhooks/event

[voice.webhooks.0.http_method]
POST

[voice.webhooks.1.endpoint_type]
answer_url

[voice.webhooks.1.endpoint]
https://example.ngrok.io/webhooks/answer

[voice.webhooks.1.http_method]
GET
```

または、結果をアプリケーション V2 形式で表示するには、次の手順を実行します。

```shell
nexmo as APP_ID --v2
```

これにより、次のようなものが返されます：

```shell
[id]
61fd1849-280d-4722-8712-1cc59aa12345

[name]
My Client SDK App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MIIB...DAQAB...
-----END PUBLIC KEY-----


[capabilities.voice.webhooks.event_url.address]
https://example.ngrok.io/webhooks/event

[capabilities.voice.webhooks.event_url.http_method]
POST

[capabilities.voice.webhooks.answer_url.address]
https://example.ngrok.io/webhooks/answer

[capabilities.voice.webhooks.answer_url.http_method]
GET

[_links.self.href]
/v2/applications/61fd1849-280d-4722-8712-1cc59aa12345
```

これは、アプリケーション V2 の[機能](/application/overview#capabilities)を示しています。

メッセージアプリケーションの場合、コマンドは次のようになります。

```shell
nexmo as 43fd399e-0f17-4027-83b9-cc16f4a12345 --v2
```

これは次のようなものを返します：

```shell
[id]
43fd399e-0f17-4027-83b9-cc16f4a12345

[name]
FaceBook Messenger App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MIIB...AQAB...
-----END PUBLIC KEY-----

[capabilities.messages.webhooks.inbound_url.address]
https://example.ngrok.io/webhooks/inbound

[capabilities.messages.webhooks.inbound_url.http_method]
POST

[capabilities.messages.webhooks.status_url.address]
https://example.ngrok.io/webhooks/status

[capabilities.messages.webhooks.status_url.http_method]
POST

[_links.self.href]
/v2/applications/43fd399e-0f17-4027-83b9-cc16f4a12345
```

この場合、メッセージ[機能](/application/overview#capabilities)が表示されることに注意してください。

アプリケーションの作成
-----------

### インタラクティブモード

まず、アプリケーションの新しいディレクトリを作成し、そのディレクトリに移動します。次に、以下のコマンドを使用して、 **インタラクティブモード** でアプリケーションを作成します。

```shell
nexmo app:create
```

必要なアプリケーション機能を選択するよう求められます。アプリケーションに対し、必要な数だけ選択できます。次に、選択した機能に基づいて Webhook URL の入力を求められます。たとえば、`rtc` 機能をリクエストした場合は、RTC イベントの Webhook URLの入力を求められます。

将来的にアプリケーションを再作成するために使用できるコマンドも、出力の一部として表示されることに注意してください。これは、後でスクリプトを使用して同様のアプリケーションを作成する場合など、将来参照する際に役立ちます。

### スクリプトモード

インタラクティブモード (スクリプトに便利です) を使用せずにアプリケーションを作成するには、次のようなコマンドを使用します。

```shell
nexmo app:create "Test Application 1" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent
```

これにより、アプリケーション ID と秘密鍵を含む `.nexmo-app` ファイルがプロジェクトディレクトリ内に作成されます。また、表示された秘密鍵をコピーして `private.key` ファイルに貼り付けることもできます。

設定する必要のある Webhook URL は、選択した機能によって異なります。これについては、[アプリケーション Webhook](/application/overview#webhooks) のトピックで詳しく説明しています。

独自の公開鍵/秘密鍵ペアを使用したアプリケーションの作成
----------------------------

適切な公開鍵/秘密鍵ペアがすでに存在する場合は、独自の公開鍵を使用してアプリケーションを作成できます。

まず、適切な公開鍵/秘密鍵のペアが必要です。作成するには、まず次のように入力します。

```shell
ssh-keygen -t rsa -b 4096 -m PEM -f private.key
```

パスフレーズを使用しない場合は、Enter キーを (2 回) 押します。これにより、秘密鍵 `private.key` が生成されます。

次に、以下のように入力します。

```shell
openssl rsa -in private.key -pubout -outform PEM -out public.key.pub
```

これにより、`public.key.pub` が生成されます。これは、Vonage アプリケーションの作成または更新に使用する公開鍵です。

```shell
nexmo app:update asdasdas-asdd-2344-2344-asdasd12345 "Application with Public Key" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent --public-keyfile=public.key.pub
```

アプリケーションの再作成
------------

`--recreate` オプションを `app:show` に使用すると、アプリケーションがどのように作成されたかを確認できます。たとえば、次のコマンドを実行します。

```shell
nexmo app:show 9a1089f2-3990-4db2-be67-3e7767bd20c9  --recreate
```

すると、以下が出力されます。

```shell
[id]
9a1089f2-3990-4db2-be67-3e7767bd20c9

[name]
APP_NAME

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MII...EAAQ==
-----END PUBLIC KEY-----


[capabilities.voice.webhooks.event_url.address]
http://example.com/event

[capabilities.voice.webhooks.event_url.http_method]
POST

[capabilities.voice.webhooks.answer_url.address]
http://example.com/answer

[capabilities.voice.webhooks.answer_url.http_method]
GET

[capabilities.voice.webhooks.fallback_answer_url.address]


[capabilities.voice.webhooks.fallback_answer_url.http_method]
GET

[capabilities.rtc.webhooks.event_url.address]
http://example.com/rtcevent

[capabilities.rtc.webhooks.event_url.http_method]
POST

[_links.self.href]
/v2/applications/9a1089f2-3990-4db2-be67-3e7767bd20c9


To recreate a similar application use the following command:

nexmo app:create DELETE ME FOREVER --capabilities=voice,rtc --voice-answer-url=http://example.com --voice-fallback-answer-url= --voice-event-url=http://example.com --rtc-event-url=http://example.com 
```

このアプリケーションを *再作成する* コマンドは、出力の最後に表示されていることに注意してください。

アプリケーションの更新
-----------

以前に作成したアプリケーションは、次のようなコマンドを使用して更新できます。

```shell
nexmo app:update asdasdas-asdd-2344-2344-asdasda12345 "Updated Application" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent
```

アプリケーション名の変更、Webhook の変更、または新しい機能の追加を行うことができます。

アプリケーションの削除
-----------

次のコマンドを使用して、アプリケーションを削除できます。

```shell
nexmo app:delete APP_ID
```

削除の確認を求められます。

> **注：** 削除を元に戻すことはできません。

関連情報
----

* [Nexmo CLI GitHub リポジトリ](https://github.com/Nexmo/nexmo-cli)

