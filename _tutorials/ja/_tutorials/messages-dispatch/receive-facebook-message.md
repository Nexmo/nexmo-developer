---
title:  Facebookメッセージを受信する
description:  このステップでは、Facebookのメッセージを受信する方法を学びます。

---

Facebookメッセージを受信する
==================

まず、Webhookサーバーが実行中であることを確認します。[着信メッセージコールバック](/messages/code-snippets/inbound-message)と[メッセージステータスコールバック](/messages/code-snippets/message-status)の **両方** を正しく処理し、少なくとも`200`を返して各コールバックを確認する必要があります。着信メッセージを送信するFacebookユーザーのPSIDを取得できるように、これを配置する必要があります。配置を完了すると、返信できるようになります。

FacebookユーザーがFacebookページにFacebookメッセージを送信されると、コールバックが着信メッセージWebhook URLに送信されます。コールバックの例を次に示します。

```json
{
  "message_uuid":"aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "to":{
    "type":"messenger",
    "id":"0000000000000000"
  },
  "from":{
    "type":"messenger",
    "id":"1111111111111111"
  },
  "timestamp":"2020-01-01T14:00:00.000Z",
  "message":{
    "content":{
      "type":"text",
      "text":"Hello from Facebook Messenger!"
    }
  }
}
```

これは返信を送信するために必要なIDであるため、ここで`from.id`値を抽出する必要があります。

