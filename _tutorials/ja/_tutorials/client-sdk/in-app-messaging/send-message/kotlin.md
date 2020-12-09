---
title:  メッセージを送信する
description:  このステップでは、会話にメッセージを送信します

---

メッセージを送信する
==========

最初のメッセージを送信します。

`ChatViewModel`クラス内で、`onSendMessage`メソッドを見つけ、その本文を埋めます：

```kotlin
fun onSendMessage(message: String) {
    if (conversation == null) {
        _errorMessage.postValue("Error: Conversation does not exist")
        return
    }

    conversation?.sendText(message, object : NexmoRequestListener<Void> {
        override fun onSuccess(p0: Void?) {
        }

        override fun onError(apiError: NexmoApiError) {
        }
    })
}
```

> **注：** `ChatFragment`クラス内には、あなたのために書かれた`sendMessageButton listener`が含まれています。このメソッドは、ユーザーが`send`ボタンをクリックしたときに呼び出されます。メッセージテキストが上に存在する場合、`viewModel.onSendMessage()`メソッドが呼び出されます。

メッセージが送信されたにもかかわらず、会話には含まれていないことがわかります。メッセージの送信後に`getConversationEvents()`メソッドを呼び出すことは可能ですが、SDKはこのシナリオをより適切に処理する方法を提供します。

