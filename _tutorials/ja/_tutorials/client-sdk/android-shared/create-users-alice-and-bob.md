---
title:  ユーザーの作成
description:  このステップでは、通話に参加するユーザーを作成する方法を学びます。

---

ユーザーを作成する
=========

各参加者は[User](/conversation/concepts/user)オブジェクトで表され、クライアントSDKによって認証される必要があります。本番アプリケーションでは、通常、このユーザー情報をデータベースに格納します。

ターミナルで次のコマンドを実行して、Nexmo Clientにログインして通信する2人のユーザー`Alice`と`Bob`を作成します。

```bash
nexmo user:create name="Alice"
nexmo user:create name="Bob"
```

これにより、次のようなユーザーIDが返されます：

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

JWTトークンを使用してユーザーを認証するため、このユーザーIDを覚えておく必要はありません。

