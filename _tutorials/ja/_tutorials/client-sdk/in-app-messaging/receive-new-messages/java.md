---
title:  新しいメッセージを受信する
description:  この手順では、新しいメッセージを表示します

---

新しいメッセージを受信する
=============

会話リスナーを実装すると、着信メッセージを表示できます。

次に、`ChatFragment`クラスで`private val messageListener = object : NexmoMessageEventListener`プロパティを見つけ、会話リスナー`onTextEvent(textEvent: NexmoTextEvent)`メソッドを実装します:

```java
private NexmoMessageEventListener messageListener = new NexmoMessageEventListener() {
    @Override
    public void onTextEvent(@NonNull NexmoTextEvent textEvent) {
        updateConversation(textEvent);
    }

    @Override
    public void onAttachmentEvent(@NonNull NexmoAttachmentEvent attachmentEvent) {

    }

    @Override
    public void onEventDeleted(@NonNull NexmoDeletedEvent deletedEvent) {

    }

    @Override
    public void onSeenReceipt(@NonNull NexmoSeenEvent seenEvent) {

    }

    @Override
    public void onDeliveredReceipt(@NonNull NexmoDeliveredEvent deliveredEvent) {

    }

    @Override
    public void onTypingEvent(@NonNull NexmoTypingEvent typingEvent) {

    }
};
```

これで、新しいメッセージを受信するたびに、`onTextEvent(textEvent: NexmoTextEvent)`リスナーが呼び出され、新しいメッセージが`updateConversation(textEvent: NexmoTextEvent)`メソッドに渡され、`conversationMessages``LiveData`を介してビューに配信されます（カンバセーションイベントの読み込み後にすべてのメッセージを配信するために使用される同じ`LiveData`）。

最後に行うことは、たとえばユーザーが戻ったときなど、`ChatViewModel`が破棄されたときにすべてのリスナーが削除されるようにすることです。`ChatViewModel`クラス内の`onCleared()`メソッドの本文を入力します。

```java
@Override
protected void onCleared() {
    conversation.removeMessageEventListener(messageListener);
}
```

