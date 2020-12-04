---
title:  ユーザーの会話への追加
description:  2人の新しいユーザーを[Conversation (カンバセーション)]のメンバーとして追加する

---

ユーザーの[Conversation (カンバセーション)]への追加
========================================

Nexmo CLIを使用して、[ユーザー](/conversation/concepts/user)を[[Conversation (カンバセーション)]](/conversation/concepts/member)の[メンバー](/conversation/concepts/conversation)として追加する必要があります。
`USER1_NAME`を会話に追加するには、以下のコマンドの`CONVERSATION_ID`を、以前に生成された[conversation Id (カンバセーションID)]（`CON-...`）に置き換えて、コマンドを実行します：

```sh
nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=USER1_NAME
```

出力は、メンバーのIDです：
````
Member added: MEM-aaaaaaa-bbbb-cccc-dddd-0123456789ab
````
次に、2番目のユーザー`USER2_NAME`を[Conversation (カンバセーション)]に追加する必要があります。同様に、`CONVERSATION_ID`を置き換えて、次のコマンドを実行します：

```sh
nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=USER2_NAME
Member added: MEM-eeeeeee-...
```

