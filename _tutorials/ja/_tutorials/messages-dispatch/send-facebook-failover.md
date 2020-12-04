---
title:  Facebookメッセージを送信する
description:  このステップでは、Dispatch APIを使用して自動フェイルオーバーを伴うFacebookのメッセージを送信する方法を学びます。この手順は、600秒が経過しても`messenger`メッセージが既読にならない場合、自動フェイルオーバーが発生し、SMSが送信される単純なワークフローを示しています。

---

フェイルオーバーを伴うFacebookメッセージを送信する
=============================

フェイルオーバーを伴うFacebookメッセージを別のチャネルに送信するには、Dispatch APIエンドポイントに1つのリクエストを行います。

この例では、次のワークフローを実装します:

1. メッセージAPIを使用して、Facebook Messengerメッセージをユーザーに送信します。
2. Facebook Messengerメッセージが600秒を経過しても読み込まれない場合、ワークフローは次のステップにフェイルオーバーされます。
3. メッセージAPIを使用して、SMSをユーザーに送信します。`FROM_NUMBER`は、メッセージの送信元として使用する番号です。`TO_NUMBER`は受信者の電話番号です。

|キー | 説明|
|-- | --|
|`FROM_NUMBER` | メッセージを送信する電話番号。 **電話番号は先頭に`+`や`00`を付けずに国番号から入力してください（例：447700900000）。** |
|`TO_NUMBER` | 受信者の電話番号。 **電話番号は先頭に`+`や`00`を付けずに国番号から入力してください（例：447700900000）。** |
|`FB_SENDER_ID` | あなたのページID。`FB_SENDER_ID`は、着信メッセージWebhook URLの着信メッセンジャーイベントで受け取った`to.id`値と同じです。|
|`FB_RECIPIENT_ID` | 返信したいユーザーのPSID。`FB_RECIPIENT_ID` は、あなたがメッセージを送信する Facebook ユーザーの PSID です。この値は、着信メッセージ Webhook URL の着信メッセンジャーイベントで受け取った `from.id` 値です。|

例
---

```code_snippets
source: '_examples/dispatch/send-facebook-message-with-failover'
```

