---
title:  概要
meta_title:  Verify API で 2FA を有効にする
description:  Verify API を使用すると、特定の番号でユーザーに連絡できることを確認できます。(Nexmo は Vonage になりました)

---


Verify API
==========

Verify API を使用すると、特定の番号でユーザーに連絡できることを確認できるため、次のことができます。

* 自分の電話番号が正しいことが保証されるため、いつでもユーザーにリーチできます
* 1 人のユーザーが複数のアカウントを作成できないため、詐欺やスパムから保護されます
* ユーザーが特定のアクティビティを実行するときにユーザーの身元を確認できるように、セキュリティレイヤーを追加できます

仕組み
---

確認は 2 段階のプロセスで、次の 2 つの API 呼び出しが必要です。

### 確認リクエスト

![確認プロセスの開始](/images/verify-request-diag.png)

1. ユーザーは、アプリまたは Web サイト経由でサービスに登録し、電話番号を提供します。

2. ユーザーが登録した番号にアクセスできることを確認するために、アプリケーションは[確認リクエストのエンドポイント](/api/verify#verifyRequest)への API 呼び出しを行います。

3. Verify API は、関連付けられた `request_id` を使用して PIN コードを生成します。
   > 
   > 場合によっては、独自の PIN コードも入力できますので、アカウントマネージャーにお問い合わせください。
4. 次に、Verify API は、この PIN のユーザーへの配信を試みます。これらの試行の形式 (SMS またはテキスト読み上げ (TTS)) とタイミングは、選択した[ワークフロー](/verify/guides/workflows-and-events)によって定義されます。ユーザーが受け取った PIN を入力するためにアプリまたは Web サイトに再度アクセスしなかった場合、確認リクエストは最終的にタイムアウトになります。それ以外の場合は、[確認] チェックを実行して、入力された番号を確認する必要があります。

### 確認チェック

![送信された PIN の確認](/images/verify-check-diag.png)

**5** . ユーザーは PIN を受け取り、アプリケーションに入力します。

**6** .アプリケーションは、[確認チェックのエンドポイント](/api/verify#verifyCheck) に API 呼び出しを行い、ユーザーが入力した `request_id` と PIN を渡します。

**7** . Verify API は、入力された PIN が送信された PIN と一致することを確認し、結果をアプリケーションに返します。

最初のステップ
-------

次のサンプルは、ユーザーに確認コードを送信して確認プロセスを開始する方法を示しています。ユーザーが入力したコードを確認したり、その他の操作を実行したりする方法については、[コードスニペット](/verify/overview#code-snippets)を参照してください。

```code_snippets
source: '_examples/verify/send-verification-request'
```

ガイド
---

```concept_list
product: verify
```

コードスニペット
--------

```code_snippet_list
product: verify
```

ユースケース
------

```use_cases
product: verify
```

関連情報
----

* [Verify API の関連情報](/api/verify)
* [Node.js を使用して Verify API を実装する](https://www.nexmo.com/blog/2018/05/10/nexmo-verify-api-implementation-guide-dr/)
* [iOS アプリで Verify API を使用する](https://www.nexmo.com/blog/2018/05/10/add-two-factor-authentication-to-swift-ios-apps-dr/)
* [Android アプリで Verify API を使用する](https://www.nexmo.com/blog/2018/05/10/add-two-factor-authentication-to-android-apps-with-nexmos-verify-api-dr/)

