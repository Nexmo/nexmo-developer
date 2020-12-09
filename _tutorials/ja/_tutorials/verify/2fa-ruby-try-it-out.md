---
title:  お試しください！
description:  アプリケーションの2fa機能をテストする

---

試行手順
====

アプリケーションを実行する：

```sh
rails server
```

`http://localhost:3000`を訪問します。まだログインしている場合は、ログアウトします。

確認コードがSMS経由で送信されます：

![確認コードが送信されました](/images/2fa-ruby-code-sent.png)

次のページが表示されます：

![確認コードを入力してください](/images/2fa-ruby-check-code.png)

受け取ったコードを入力すると、ログインします：

![検証に成功しました](/images/2fa-ruby-verification-success.png)

