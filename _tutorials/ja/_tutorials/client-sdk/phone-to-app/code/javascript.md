---
title:  クライアント側アプリケーションの作成
description:  このステップでは、アプリのアプリケーションに携帯電話のコードを記述する方法を学びます。

---

クライアント側アプリケーションの作成
==================

プロジェクトディレクトリに、`index.html`というHTMLファイルを作成します。次のコードを追加しますが、このチュートリアルの[前の手順](/client-sdk/tutorials/phone-to-app/client-sdk/generate-jwt)でユーザー用に生成したJWTに貼り付けてください：

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <script src="nexmoClient.js"></script>
</head>
<body>

  <h1>Inbound PSTN phone call</h1>
  <p id="notification">Lines are open for calls...</p>
  <br />
  <button type="button" id="answer">Answer</button>
  <button type="button" id="reject">Reject</button>
  <button type="button" id="hangup">Hang Up</button>
  <script>

    const AGENT_JWT = "PASTE ALICE JWT HERE";

    new NexmoClient({ debug: true })
    .login(AGENT_JWT)
    .then(app => {

        const answerBtn = document.getElementById("answer");
        const rejectBtn = document.getElementById("reject");
        const hangupBtn = document.getElementById("hangup");
        const notification = document.getElementById("notification");

        app.on("member:call", (member, call) => {
            notification.textContent = "You are receiving a call";
            // Answer the call.
            answerBtn.addEventListener('click', () => {
                call.answer();
                notification.textContent = "You are in a call";
            });
            // Reject the call
            rejectBtn.addEventListener("click", () => {
                call.reject();
                notification.textContent = `You rejected the call`;
            });
            // Hang-up the call
            hangupBtn.addEventListener("click", () => {
                call.hangUp();
                notification.textContent = `You ended the call`;
            });
        });

        app.on("call:status:changed", (call) => {
          notification.textContent = "Call Status: " + call.status;
        });
    })
    .catch(console.error);
  </script>
</body>
</html>
```

これは、クライアントSDKを使用して着信呼び出しを受け入れるWebアプリケーションです。

このコードの主な機能は次のとおりです:

1. 呼び出しステータスで更新できる通知ボックス。
2. エージェントが着信呼び出しに応答するときに使用するボタン。
3. エージェントが着信呼び出しを拒否するときに使用するボタン。
4. エージェントが着信呼び出しを切断するときに使用するボタン。
5. このコードは、[前のステップ](/client-sdk/tutorials/phone-to-app/client-sdk/generate-jwt)で生成されたユーザーJWTを使用してエージェントをログに記録します。
6. コードでは、2つのメインイベントハンドラを設定します。最初のコールは着信呼び出しで起動されます。これにより、クライアントSDKメソッド`call.answer()`、`call.reject()`および`call.hangUp()`をそれぞれ使用して、着信呼び出しに応答、拒否、および切断する3つのクリックボタンイベントハンドラが設定されます。
7. 2つ目は、コールステータス変更（`call:status:changed`）イベントハンドラは、通知ボックスのテキストを受信コールのステータスに設定します。

