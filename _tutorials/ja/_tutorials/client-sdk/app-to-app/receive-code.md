---
title:  アプリ内音声通話を受信するコードを作成する
description:  このステップでは、別のアプリからのアプリ内音声通話を受信するためのコードを記述する方法を学びます。

---

アプリ内音声通話を受信するコードを作成する
=====================

プロジェクトディレクトリに、`index2.html`というHTMLファイルを作成します。

次のコードを追加しますが、 [前のステップ](/client-sdk/tutorials/app-to-app/client-sdk/generate-jwts)で *受信* 通話を行ったユーザー用に生成したBob JWTを、`USER_JWT`定数に貼り付けるようにしてください：

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
  </head>
  <body>
    <h1>Inbound app call</h1>
    <p id="notification">Lines are open for calls...</p>
    <br />
    <button id="button">Answer</button>
    <script>
      const USER_JWT ="PASTE BOB JWT HERE";

      new NexmoClient({ debug: true })
        .login(USER_JWT)
        .then(app => {
          let btn = document.getElementById("button");
          let notification = document.getElementById("notification");
          app.on("member:call", (member, call) => {
            notification.innerHTML = "Inbound app call - click to answer...";
            btn.addEventListener("click", event => {
              event.preventDefault();
              call.answer();
            });
          });
          app.on("call:status:changed", call => {
            notification.innerHTML = "Call Status: " + call.status;
          });
        })
        .catch(console.error);
    </script>
  </body>
</html>
```

これは、クライアントSDKを使用してソース *ユーザー* （Alice）から音声通話を受信する、クライアントアプリケーションです。

このコードにはいくつかの重要なコンポーネントがあります：

1. 着信通話があるかどうかを確認し、`Answer`をクリックして応答できるシンプルなUI。
2. ユーザー（Bob）をクライアントSDK（認証にJWTを使用）にログインさせるコード `.login(USER_JWT)`。
3. 応答ボタンがクリックされたときに、呼び出しに応答するイベントハンドラ。
4. `call:status:changed`イベントを通じて通話ステータスが変化したときに表示する、イベントハンドラとUI。

