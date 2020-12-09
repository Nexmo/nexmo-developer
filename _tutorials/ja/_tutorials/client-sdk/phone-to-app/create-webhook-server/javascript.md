---
title:  Webhookサーバーを作成する
description:  このステップでは、Webアプリが着信PSTN電話呼び出しを受信できるようにする、適切なWebhookサーバーを作成する方法を学びます。

---

Webhookサーバーを作成する
================

Webhookサーバーを作成する必要があります。着信コールがVonageに着信すると、発信番号をキャプチャし、ダイナミックNCCOを使用してコールをWebアプリケーションに転送できます。これは、`app`タイプの`connect`アクションを使用することによって達成されます。コールは、着信コールを処理するエージェントを表す認証済みユーザーに転送されます。

`server.js`ファイルを作成し、サーバーのコードを追加します：

> **注：** Vonage番号とユーザー名を以下のコードに貼り付けてください。ユーザー名は、前のステップ（Alice）でJWTを作成したものです。

```javascript
'use strict';
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(express.static('node_modules/nexmo-client/dist'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const ncco = [
  {
    "action": "talk",
    "text": "Please wait while we connect you to an agent"
  },
  {
    "action": "connect",
    "from": "NEXMO_NUMBER",
    "endpoint": [
      {
        "type": "app",
        "user": "Alice"
      }
    ]
  }
]

app.get('/webhooks/answer', (req, res) => {
    console.log("Answer:");
    console.log(req.query);
    res.json(ncco);
});

app.post('/webhooks/event', (req, res) => {
    console.log("EVENT:");
    console.log(req.body);
    res.status(200).end();
});

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));

```

このコードの重要な部分は次のとおりです：

1. この例では、スタティックNCCOを使用して、`Alice` によって識別されるエージェントに着信呼び出しを転送します。
2. NCCOは、 `app`タイプの`connect`アクションを使用して、接続先のユーザー名を指定します。

