---
title:  ユーザーを作成する
description:  このステップでは、通話に参加するユーザーを作成する方法を学びます。

---

ユーザーを作成する
=========

各参加者は[User](/conversation/concepts/user)オブジェクトで表され、クライアントSDKによって認証される必要があります。本番アプリケーションでは、通常、このユーザー情報をデータベースに格納します。

次のコマンドを実行して、Vonageクライアントにログインして通信するユーザー`Alice`を作成します。

```bash
nexmo user:create name="Alice"
```

これにより、次のようなユーザーIDが返されます：

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

JWTトークンを使用してユーザーを認証するため、このユーザーIDを覚えておく必要はありません。

