---
title:  ユーザーの作成
description:  このステップでは、アプリ内音声通話に参加するユーザーを作成する方法を学びます。

---

ユーザーを作成する
=========

[アプリ内音声](/client-sdk/in-app-voice/overview)通信の各参加者は[ユーザー](/conversation/concepts/user)オブジェクトで表され、クライアントSDKによって認証される必要があります。本番アプリケーションでは、通常、このユーザー情報をデータベースに格納します。

次のコマンドを実行して、Vonageクライアントにログインして通話に参加する、2人のユーザー`Alice`と`Bob`を作成します。

```bash
nexmo user:create name="Alice"
nexmo user:create name="Bob"
```

これにより、次のようなユーザーIDが返されます：

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

このユーザーIDを覚えておく必要はありません。（ユーザーIDの代わりに）ユーザー名を使用して音声通話に追加します。

