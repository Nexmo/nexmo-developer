---
title:  ホームページを表示する
description:  ホームページとユーザーの認証ステータスを表示します

---

ホームページを表示する
===========

`/`ルートでは、セッションがすでに存在するかどうかをチェックします。存在しない場合は、続行する前に、携帯電話番号を使用してアカウントの詳細を確認するようユーザーに要求します。

認証された後、セッションオブジェクトが作成され、これを使用してユーザーの携帯電話番号を取得して表示できます。

`/`ルートハンドラに次のコードを入力します：

```javascript
app.get('/', (req, res) => {
	if (!req.session.user) {
		res.render('index', {
			brand: NEXMO_BRAND_NAME,
		});
	} else {
		res.render('index', {
			number: req.session.user.number,
			brand: NEXMO_BRAND_NAME,
		});
	}
});
```

次のコマンドを実行します：

```sh
node server.js
```

ブラウザで`http://localhost:3000`にアクセスし、ページが正しく表示されることを確認します：

![ホームページ](/images/tutorials/verify-stepup-auth-home-page.png)

また、[Verify me (確認する)]ボタンをクリックすると、携帯電話番号を入力できるページにリダイレクトされることを確認してください：

![コード入力ページ](/images/tutorials/verify-stepup-auth-enter-number-page.png)

ここに番号を入力することはできますが、確認コードは届きません。その機能は、次のステップで実装します！

