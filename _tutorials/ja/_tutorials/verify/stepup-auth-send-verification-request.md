---
title:  確認リクエストを送信する
description:  検証リクエストエンドポイントへの呼び出しで確認プロセスを開始します

---

確認リクエストを送信する
============

[Verify APIリクエストエンドポイント](/api/verify#verifyRequest)を使用して確認プロセスを開始し、確認コードを生成してユーザーに送信します。

これには、NodeサーバーSDKを使用します。まず、`.env`から環境変数を読み取るコードの行の後にインスタンス化します：

```javascript
const nexmo = new Nexmo(
  {
    apiKey: VONAGE_API_KEY,
		apiSecret: VONAGE_API_SECRET,
	},
	{
		debug: true,
	}
);
```

次に、`/verify`ルートハンドラ内で検証要求を作成します：

```javascript
app.post('/verify', (req, res) => {
	// Start the verification process
	verifyRequestNumber = req.body.number;
	nexmo.verify.request(
		{
			number: verifyRequestNumber,
			brand: VONAGE_BRAND_NAME,
		},
		(err, result) => {
			if (err) {
				console.error(err);
			} else {
				verifyRequestId = result.request_id;
				console.log(`request_id: ${verifyRequestId}`);
			}
		}
	);
	/* 
    Redirect to page where the user can 
    enter the code that they received
  */
	res.render('entercode');
});
```

> デフォルトでは、最初の検証試行はSMSによって送信されます。指定された期間内にユーザーが応答しなかった場合、APIは2回目の試行を行い、必要に応じて、音声通話を使用してPINコードを配信する3回目の試行を行います。利用可能なワークフローとカスタマイズオプションの詳細については、[ガイド](/verify/guides/workflows-and-events)を参照してください。

