---
title:  アプリ内音声通話を行うコードを作成する
description:  このステップでは、別のアプリにアプリ内音声通話を行うコードを記述する方法を学びます。

---

アプリ内音声通話を行うコードを作成する
===================

プロジェクトディレクトリに、`index1.html`というHTMLファイルを作成します。

次のコードを追加しますが、 [前のステップ](/client-sdk/tutorials/app-to-app/client-sdk/generate-jwts)で *呼び出し* 通話を行うユーザー用に生成したAlice JWTを、`USER_JWT`定数に貼り付けるようにしてください：

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
  </head>
  <body>
    <form id="call-app-form">
      <h1>Call App from App</h1>
      <input type="text" name="username" value="" />
      <input type="submit" value="Call" />
    </form>
    <button id="btn-hangup" type="button">Hang Up</button>
    <script>
      const USER_JWT = "PASTE ALICE JWT HERE";
      const callAppForm = document.getElementById("call-app-form");
      const btnHangUp = document.getElementById("btn-hangup");
      new NexmoClient({ debug: true })
        .login(USER_JWT)
        .then(app => {
          callAppForm.addEventListener("submit", event => {
            event.preventDefault();
            let username = callAppForm.children.username.value;
            app.callServer(username, "app");
          });

          app.on("member:call", (member, call) => {
            btnHangUp.addEventListener("click", () => {
              console.log("Hanging up...");
              call.hangUp();
            });
          });
        })
        .catch(console.error);
    </script>
  </body>
</html>
```

これは、クライアントSDKを使用して宛先 *ユーザー* （Bob）への音声通話を行う、クライアントアプリケーションです。

このコードにはいくつかの重要なコンポーネントがあります。

1. ユーザー名を入力し、`Call`ボタンをクリックして、指定したユーザー（Bob）にアプリ内通話を行うことができる、シンプルな UI。
2. `.login(USER_JWT)`を使用して、ユーザー（Alice）をクライアントSDK（認証にJWTを使用）にログインさせるコード。
3. 通話を行う関数は`callServer(username, type)`です。宛先は指定されたユーザー（Bob）であるため、この場合の`type`は「アプリ」です。  
   > 
   > **注** ：音声通話を行うもう一つの方法は、`inAppCall(username)`でP2P通話機能を使用します。[`inAppCall()`の詳細情報](/sdk/stitch/javascript/Application.html#inAppCall__anchor)
4. 通話すると、ボタンハンドラがロードされます。`Hang Up`ボタンをクリックすると、`call.hangUp()`が通話を終了させます。

