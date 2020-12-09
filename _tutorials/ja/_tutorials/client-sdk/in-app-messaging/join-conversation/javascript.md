---
title:  カンバセーションを取得する
description:  このステップでは、ユーザーをカンバセーションに参加させます

---

カンバセーションを取得する
=============

有効なユーザートークンを取得したので、新しい`NexmoClient`インスタンスを初期化し、チャットアプリで使用するカンバセーションを取得します。

```javascript
async function run(userToken) {
  let client = new NexmoClient({ debug: true });
  let app = await client.login(userToken);
  conversation = await app.getConversation(CONVERSATION_ID);
}
```

