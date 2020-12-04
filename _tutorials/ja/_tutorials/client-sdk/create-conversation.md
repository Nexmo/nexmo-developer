---
title:  会話を作成する
description:  ユーザーが通信できるようにする[Conversation (カンバセーション)]を作成する

---

[Conversation (カンバセーション)]を作成する
====================================

ユーザーが相互に通信するために使用する[[Conversation (カンバセーション)]](/conversation/concepts/conversation)を作成します。

```bash
nexmo conversation:create display_name="CONVERSATION_NAME"
```

出力は次のようになります：
````
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
````
この新しく生成された[conversation Id (カンバセーションID)]（`CON-...`）を書き留めます。後でそれを使用して、[ユーザー](/conversation/concepts/user)を[メンバー](/conversation/concepts/conversation)として[[Conversation (カンバセーション)]](/conversation/concepts/member)に追加します。

