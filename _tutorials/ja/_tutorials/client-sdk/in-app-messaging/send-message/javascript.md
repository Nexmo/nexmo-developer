---
title:  メッセージを送信する
description:  このステップでは、ユーザーがメッセージを送信できるようにします

---

メッセージを送信する
==========

カンバセーションの他の参加者にメッセージを送信するには、`conversation.sendText()`メソッドを呼び出す必要があります。

これを行うには、`run`関数の最後にメッセージボックスの[Submit (送信)]ボタンのハンドラを追加します：

```javascript
// Listen for clicks on the submit button and send the existing text value
sendButton.addEventListener('click', async () => {
  await conversation.sendText(messageTextarea.value);
  messageTextarea.value = '';
});
```

