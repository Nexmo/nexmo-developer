---
title:  ユーザーの作成
description:  このステップでは、クライアントSDKユーザーの作成方法を学習します。

---

ユーザーの作成
=======

[ユーザー](/conversation/concepts/user)は、VonageクライアントSDKで作業するときの重要な概念です。ユーザーがクライアントSDKで認証されると、提供される認証情報によって特定のユーザーとして識別されます。認証された各ユーザーは、通常、ユーザーデータベース内の1人のユーザーに対応します。

`Alice`という名前のユーザーを作成するには、Nexmo CLIを使用して次のコマンドを実行します：

```bash
nexmo user:create name="Alice"
```

これにより、次のようなユーザーIDが返されます：

```bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

