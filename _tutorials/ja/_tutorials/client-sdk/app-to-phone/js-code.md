---
title:  クライアント側アプリケーションの作成
description:  このステップでは、電話アプリケーションにアプリのコードを記述する方法を学びます。

---

クライアント側アプリケーションの作成
==================

プロジェクトディレクトリに、`index.html`というHTMLファイルを作成します。次のコードを追加しますが、このチュートリアルの[前のステップ](/client-sdk/tutorials/app-to-phone/client-sdk/generate-jwt)でユーザー用に生成したJWTを、`USER_JWT`定数に貼り付けるようにしてください：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
    <style>
        input, button {
            font-size: 1rem;
        }
        #hangup {
            display:none;
        }
    </style>
</head>

<body>
    <h1>Call Phone from App</h1>
    <label for="phone-number">Your Phone Number:</label>
    <input type="text" name="phone-number" value="" placeholder="i.e. 14155550100" id="phone-number" size="30">
    <button type="button" id="call">Call</button>
    <button type="button" id="hangup">Hang Up</button>
    <div id="status"></div>

    <script>
        const USER_JWT = "PASTE YOUR JWT HERE";
        const phoneNumberInput = document.getElementById("phone-number");
        const callButton = document.getElementById("call");
        const hangupButton = document.getElementById("hangup");
        const statusElement = document.getElementById("status");
        new NexmoClient({ debug: true })
            .login(USER_JWT)
            .then(app => {
                callButton.addEventListener("click", event => {
                    event.preventDefault();
                    let number = phoneNumberInput.value;
                    if (number !== ""){
                        app.callServer(number);
                    } else {
                        statusElement.innerText = 'Please enter your phone number.';
                    }
                });
                app.on("member:call", (member, call) => {
                    hangupButton.addEventListener("click", () => {
                        call.hangUp();
                    });
                });
                app.on("call:status:changed",(call) => {
                    statusElement.innerText = `Call status: ${call.status}`;
                    if (call.status === call.CALL_STATUS.STARTED){
                        callButton.style.display = "none";
                        hangupButton.style.display = "inline";
                    }
                    if (call.status === call.CALL_STATUS.COMPLETED){
                        callButton.style.display = "inline";
                        hangupButton.style.display = "none";
                    }
                });
            })
            .catch(console.error);
    </script>

</body>

</html>
```

これは、クライアントSDKを使用して、Vonage経由で宛先電話に音声通話を発信するWebアプリケーションです。

このコードにはいくつかの重要なコンポーネントがあります：

1. 電話番号を入力し、`Call`ボタンをクリックして音声通話を行うことができる、シンプルなUI。
2. ユーザーをログインさせるコード（認証にJWTを使用）。
3. `callServer(number)`通話を発信する関数。`number`は[E.164](/concepts/guides/glossary#e-164-format)形式の宛先電話番号です。

電話番号を入力して`Call`ボタンをクリックすると、通話ステータスに関する音声レポートが聞こえます。その後、通話がつながると、応答することができ、アプリを介して会話が聞こえます。

