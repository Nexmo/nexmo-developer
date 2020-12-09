---
title:  UIを作成する
description:  チャットをホストするWebページを作成する

---

UIを作成する
=======

Webチャットのユーザーインターフェースを作成します。

次のHTMLは、表示に使用する`<section>`を定義します：

* 現在ログインしているユーザーの名前
* ユーザーの現在のステータス（ユーザーが現在メッセージを入力しているかどうか）
* これまでに送受信されたメッセージ
* ユーザーが新しいメッセージを入力するためのテキスト領域

ページ本文がレンダリングされると、Webページは3つのスクリプトをロードします：

* `nexmo-client` Nodeモジュールからの`nexmoClient.js`ファイル
* `moment.js` を使用して、受信したメッセージの日付と時刻のフォーマットに役立ちます。実行してこのモジュールをインストールする `npm install moment`
* アプリケーションのコードを含む`chat.js`ファイル。プロジェクトのルートディレクトリにこの空のファイルを作成します

プロジェクトディレクトリに、次の内容を含む`index.html`という名前のファイルを作成します：

```html
<!DOCTYPE html>
<html>

<head>
  <style>
    body {
      font: 13px Helvetica, Arial;
    }

    #login,
    #messages {
      width: 80%;
      height: 500px;
    }

    form input[type=text] {
      font-size: 20px;
      height: 35px;
      padding: 0px;
    }

    button {
      height: 35px;
      background-color: blue;
      color: white;
      width: 75px;
      position: relative;
      font-size: 15px;
    }

    textarea {
      width: 85%;
      font-size: 20px;
    }

    #messageFeed {
      font-size: 18px;
      padding-bottom: 20px;
      line-height: 22pt;
    }

    #status {
      height: 35px;
      font-size: 12px;
      color: blue;
    }

    #send {
      width: 85%;
    }

    #messages {
      display: none;
    }
  </style>
</head>

<body>

  <form id="login">
    <h1>Login</h1>
    <input type="text" id="username" name="username" value="" class="textbox">
    <button type="submit">Login</button>
  </form>

  <section id="messages">
    <h1 id="sessionName"></h1>

    <div id="loadSection">
      <button id="loadMessages">
        Load Previous Messages
      </button>
      &nbsp; &nbsp;<h3>Showing <span id="messagesCount"></span> starting at <span id="messageDate"></span></h3>
    </div>

    <div id="messageFeed"></div>

    <div>
      <textarea id="messageTextarea"></textarea>
      <button id="send">Send</button>
      <div id="status"></div>
    </div>
  </section>

  <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
  <script src="./node_modules/moment/moment.js"></script>
  <script src="./chat.js"></script>

</body>

</html>
```

