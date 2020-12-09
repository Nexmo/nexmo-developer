---
title:  WhatsAppメッセージを送信する
description:  このステップでは、WhatsAppのメッセージを送信する方法を学びます。

---

WhatsAppメッセージの送信
================

フリーフォームのテキストメッセージは、顧客が最初に企業にメッセージを送信したときにのみ送信することができます。企業は、顧客メッセージの最後の瞬間から最大24時間以内にフリーフォームメッセージを送り返します。その期間以降は、WhatsAppテンプレート（MTM）を使用する必要があります。

顧客からメッセージを受信していない場合は、メッセージを送信する前にWhatsAppテンプレート（MTM）を送信する必要があります。[WhatsAppメッセージングについて理解する](/messages/concepts/whatsapp)で詳細を学ぶことができます。

WhatsAppテンプレートを送信するためのコードを表示する場合は、[WhatsAppテンプレートの送信](/messages/code-snippets/send-whatsapp-template)コードスニペットを表示できます。

|キー | 説明|
|-- | --|
|`WHATSAPP_NUMBER` | あなたのWhatsApp番号。|
|`TO_NUMBER` | メッセージ送信先の電話番号。|

> **注:** 電話番号は先頭に `+` や `00` を付けずに国番号から入力してください (例: 447700900000)。

例
---

```code_snippets
source: '_examples/messages/whatsapp/send-text'
```

> **ヒント：** Curlを使用してテストする場合は、JWTが必要です。[JWTの作成](/messages/code-snippets/before-you-begin#generate-a-jwt)に関するドキュメントで、JWTの作成方法を確認できます。

