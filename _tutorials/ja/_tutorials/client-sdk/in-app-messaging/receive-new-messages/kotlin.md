---
title:  新しいメッセージを受信する
description:  このステップでは、新しいメッセージを表示します

---

新しいメッセージを受信する
=============

会話リスナーを実装すると、着信メッセージを表示できます。

次に、`ChatFragment`クラスで`private val messageListener = object : NexmoMessageEventListener`プロパティを見つけ、会話リスナー`onTextEvent(textEvent: NexmoTextEvent)`メソッドを実装します:

```kotlin
private val messageListener = object : NexmoMessageEventListener {
    override fun onTypingEvent(typingEvent: NexmoTypingEvent) {}

    override fun onAttachmentEvent(attachmentEvent: NexmoAttachmentEvent) {}

    override fun onTextEvent(textEvent: NexmoTextEvent) {
        updateConversation(textEvent)
    }

    override fun onSeenReceipt(seenEvent: NexmoSeenEvent) {}

    override fun onEventDeleted(deletedEvent: NexmoDeletedEvent) {}

    override fun onDeliveredReceipt(deliveredEvent: NexmoDeliveredEvent) {}
}
```

これで、新しいメッセージを受信するたびに、`onTextEvent(textEvent: NexmoTextEvent)`リスナーが呼び出され、新しいメッセージが`updateConversation(textEvent: NexmoTextEvent)`メソッドに渡され、`conversationMessages``LiveData`を介してビューに配信されます（カンバセーションイベントの読み込み後にすべてのメッセージを配信するために使用される同じ`LiveData`）。

最後に行うことは、たとえばユーザーが戻ったときなど、`ChatViewModel`が破棄されたときにすべてのリスナーが削除されるようにすることです。`ChatViewModel`クラス内の`onCleared()`メソッドの本文を入力します。

```kotlin
override fun onCleared() {
    conversation?.removeMessageEventListener(messageListener)
}
```

