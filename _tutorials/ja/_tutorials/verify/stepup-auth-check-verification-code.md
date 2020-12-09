---
title:  確認コードを確認する
description:  ユーザーが入力したコードが、送信されたコードと同じであることを確認してください

---

確認コードをチェックする
============

ユーザーが提出したコードを確認するには、[検証チェックエンドポイント](/api/verify#verifyCheck)を呼び出します。`request_id`を渡します（前のステップで検証リクエストエンドポイントへの呼び出しによって返されました）。

応答は、ユーザーが正しいコードを入力したかどうかを伝えます。ステータスが0の場合、入力したコードは送信されたコードと同じです。その場合は、ユーザーセッションオブジェクトを作成します。

コードを確認したら、ユーザーをホームページに戻します。

これを実現するには、`/check-code`ルートハンドラに次のコードを入力します：

```javascript
app.post('/check-code', (req, res) => {
	// Check the code provided by the user
	nexmo.verify.check(
		{
			request_id: verifyRequestId,
			code: req.body.code,
		},
		(err, result) => {
			if (err) {
				console.error(err);
			} else {
				if (result.status == 0) {
					// User provided correct code, so create a session for that user
					req.session.user = {
						number: verifyRequestNumber,
					};
				}
			}
			// Redirect to the home page
			res.redirect('/');
		}
	);
});
```

