---
title:  Facebookメッセージを送信する
description:  このステップでは、Facebookのメッセージを送信する方法を学びます

---

Facebookメッセージを送信する
==================

その後、メッセージAPIを使用してFacebookユーザーから受信した着信メッセージに返信できます。

以下の例の次の変数を、実際の値に置き換えます。

|キー | 説明
|-- | --|
|`FB_SENDER_ID` | あなたのページ ID。`FB_SENDER_ID`は、着信メッセージWebhook URLの着信メッセンジャーイベントで受け取った`to.id`値と同じです。|
|`FB_RECIPIENT_ID` | 返信したいユーザーのPSID。`FB_RECIPIENT_ID`は、あなたがメッセージを送信するFacebookユーザーのPSIDです。この値は、着信メッセージWebhook URLの着信メッセンジャーイベントで受け取った`from.id`値です。|

例
---

```code_snippets
source: '_examples/messages/messenger/send-text'
```

> **ヒント：** Curlを使用してテストする場合は、JWTが必要です。[JWTの作成](/messages/code-snippets/before-you-begin#generate-a-jwt)に関するドキュメントで、JWTの作成方法を確認できます。

