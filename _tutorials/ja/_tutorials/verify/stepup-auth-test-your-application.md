---
title:  お試しください！
description:  アプリケーションをテストします

---

試行手順
====

まず、アプリケーションの実行中のインスタンスをすべて停止し、次を使用してプログラムを再度実行します：

```sh
node server.js
```

`http://localhost:3000`にブラウザでアクセスし、[Verify me (認証する)]ボタンをクリックします：

![ホームページ](/images/tutorials/verify-stepup-auth-home-page.png)

[E.164形式](/concepts/guides/glossary#e-164-format)で携帯電話番号を入力し、[Get Verification Code (確認コードを取得)]ボタンをクリックします：

![携帯電話番号の入力](/images/tutorials/verify-stepup-auth-enter-number-filled.png)

すぐにその番号へコードを含むSMSが届きます。コードを入力し、[Verify me\! (認証する！)]をクリックします：

![PINコードを入力する](/images/tutorials/verify-stepup-auth-enter-code-filled.png)

ホームページに戻り、番号が正しく入力されていれば、それが表示されます：

![認証に成功しました](/images/tutorials/verify-stepup-auth-success.png)

