---
title:  入力インジケータを追加する
description:  このステップでは、ユーザーが入力しているときにそのことを表示する方法を学びます

---

入力インジケータの追加
===========

アプリケーションをもう少し磨くために、会話に参加している他の当事者が入力しているときに、そのことをユーザーに知らせましょう。

`run`関数の末尾に次のコードを追加します。アプリケーションがメッセージテキスト領域で`keypress`イベントを検出した場合は、`conversation.startTyping`関数を呼び出して、ユーザーが現在入力していることをアプリケーションに通知します。

テキスト領域で`keyup`イベントが1/2秒以上検出された場合、ユーザーが入力を停止し、`conversation.stopTyping`を呼び出してアプリケーションに通知したと仮定できます。

```javascript
messageTextarea.addEventListener('keypress', (event) => {
  conversation.startTyping();
});

var timeout = null;
messageTextarea.addEventListener('keyup', (event) => {
  clearTimeout(timeout);
  timeout = setTimeout(() => {
    conversation.stopTyping();
  }, 500);
});
```

ユーザーが入力を開始または停止したことをアプリケーションが検出すると、イベントの発生元を特定できます。ユーザーがアプリケーションを使用しているユーザー以外のユーザーである場合は、アプリでそのユーザーのステータスを更新します。

`run`関数の一番下に以下を追加します：

```javascript
conversation.on("text:typing:on", (data) => {
  if (data.user.id !== data.conversation.me.user.id) {
    status.innerHTML = data.user.name + " is typing...";
  }
});

conversation.on("text:typing:off", (data) => {
  status.innerHTML = "";
});
```

