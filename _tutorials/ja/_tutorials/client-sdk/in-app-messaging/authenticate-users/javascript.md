---
title:  ユーザーを認証する
description:  このステップでは、先ほど作成したJWTを使用してユーザーを認証します

---

ユーザーを認証する
=========

[Conversation (カンバセーション)]に参加するには、ユーザー認証が必要です。この認証は、前のステップで生成したJWTと、[Conversation ID (カンバセーションID)]を使用して実行します。

`chat.js`ファイルの先頭で次の変数を宣言し、`USER1_JWT`、`USER2_JWT`および`CONVERSATION_ID`に独自の値を設定します：

```javascript
const USER1_JWT = '';
const USER2_JWT = '';
const CONVERSATION_ID = '';

const messageTextarea = document.getElementById('messageTextarea');
const messageFeed = document.getElementById('messageFeed');
const sendButton = document.getElementById('send');
const loginForm = document.getElementById('login');
const status = document.getElementById('status');

const loadMessagesButton = document.getElementById('loadMessages');
const messagesCountSpan = document.getElementById('messagesCount');
const messageDateSpan = document.getElementById('messageDate');

let conversation;
let listedEvents;
let messagesCount = 0;
let messageDate;

function authenticate(username) {
  if (username == "USER1_NAME") {
    return USER1_JWT;
  }
  if (username == "USER2_NAME") {
    return USER2_JWT;
  }
  alert("User not recognized");
}
```

また、`login`フォームにイベントリスナーを追加して、ユーザーのJWTを取得し、それを`run`関数に渡す必要があります。`run`関数はまだ何も実行しませんが、この時点で、アプリケーションの構築を開始するための有効なユーザーJWTがあります。

```javascript
loginForm.addEventListener('submit', (event) => {
  event.preventDefault();
  const userToken = authenticate(document.getElementById('username').value);
  if (userToken) {
    document.getElementById('messages').style.display = 'block';
    document.getElementById('login').style.display = 'none';
    run(userToken);
  }
});

async function run(userToken){

}
```

