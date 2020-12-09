---
title:  ユーザーの作成
description:  このステップでは、カンバセーションに参加するユーザーを作成する方法を学びます。

---

ユーザーを作成する
=========

[カンバセーション](/conversation/concepts/conversation)内の各参加者は[User](/conversation/concepts/user)オブジェクトで表され、クライアントSDKによって認証される必要があります。本番アプリケーションでは、通常、このユーザー情報をデータベースに格納します。

次のコマンドを実行して、Vonageクライアントにログインしてチャット（Conversation）に参加する2人のユーザー`USER1_NAME`と`USER2_NAME`を作成します。

```bash
nexmo user:create name="USER1_NAME"
nexmo user:create name="USER2_NAME"
```

これにより、次のようなユーザーIDが返されます：

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

このユーザーIDを覚えておく必要はありません。ユーザー名（ユーザーIDの代わりに）を使用してカンバセーションに追加します。

