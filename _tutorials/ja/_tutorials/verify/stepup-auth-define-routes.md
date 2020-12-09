---
title:  ルートを定義する
description:  アプリケーションのエンドポイントを設定します

---

ルートを定義する
========

アプリケーションでは次のルートを使用します：

* `/` - ホームページ。ユーザーが認証されているかどうかを判断し、認証されていない場合は認証を要求します
* `/authenticate` - ユーザーが自分の電話番号を入力できるページを表示します
* `/verify` - ユーザーが自分の電話番号を入力したら、ここにリダイレクトして確認プロセスを開始し、受信したコードを入力できるページを表示します
* `/check-code` - ユーザーが確認コードを入力すると、このエンドポイントはVerify APIを使用して、入力したコードが送信されたコードであるかどうかを確認します
* `/cancel` - セッションの詳細を削除し、ユーザーをホームページに戻します

サーバーを初期化して実行するコードの直前に、`server.js`でこれらのルートを作成します：

```javascript
app.get('/', (req, res) => {

});

app.get('/authenticate', (req, res) => {
  res.render('authenticate');
});

app.post('/verify', (req, res) => {
	res.render('entercode');
});

app.post('/check-code', (req, res) => {

});

app.get('/cancel', (req, res) => {
	req.session.destroy();
	res.redirect('/');
});
```

