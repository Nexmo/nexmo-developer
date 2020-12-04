---
title:  ユーザーの会話への追加
description:  2人の新しいユーザーを[Conversation (カンバセーション)]のメンバーとして追加する

---

ユーザーのカンバセーションへの追加
=================

Nexmo CLIを使用して、[ユーザー](/conversation/concepts/user)を[[Conversation (カンバセーション)]](/conversation/concepts/member)の[メンバー](/conversation/concepts/conversation)として追加する必要があります。
`Alice`を会話に追加するには、以下のコマンドの`CONVERSATION_ID`を、以前に生成された[conversation Id (カンバセーションID)]（`CON-...`）に置き換えて、コマンドを実行します：

```sh
nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=Alice
```

出力は、メンバーのIDです：
````
Member added: MEM-aaaaaaa-bbbb-cccc-dddd-0123456789ab
````
次に、2番目のユーザー`Bob`を[Conversation (カンバセーション)]に追加する必要があります。同様に、`CONVERSATION_ID`を置き換えて、次のコマンドを実行します：

```sh
nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=Bob
Member added: MEM-eeeeeee-...
```

