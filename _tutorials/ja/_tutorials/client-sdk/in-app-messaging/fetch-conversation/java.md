---
title:  カンバセーションを取得する
description:  このステップでは、ユーザーをカンバセーションに参加させます

---

カンバセーションを取得する
=============

チャット画面（`ChatFragment`および`ChatViewModel`クラス）では、カンバセーションとすべてのカンバセーションイベントを取得します。

ビュー（`ChattFragment`）を作成すると、カンバセーションをロードする`viewModel.getConversation()`メソッドが呼び出されます。

`ChatViewModel`クラス内で、次の行を見つけ、`getConversation()`メソッドの実装を埋めます：

```java
private void getConversation() {
    client.getConversation(Config.CONVERSATION_ID, new NexmoRequestListener<NexmoConversation>() {
        @Override
        public void onSuccess(@Nullable NexmoConversation conversation) {
            ChatViewModel.this.conversation = conversation;

            if (ChatViewModel.this.conversation != null) {
                getConversationEvents(ChatViewModel.this.conversation);
                ChatViewModel.this.conversation.addMessageEventListener(messageListener);
            }
        }

        @Override
        public void onError(@NonNull NexmoApiError apiError) {
            ChatViewModel.this.conversation = null;
            _errorMessage.postValue("Error: Unable to load conversation " + apiError.getMessage());
        }
    });
}
```

`client`の使用に注意してください。これは、`LoginViewModel`で参照されている`client`とまったく同じオブジェクトを参照します（インスタンスは`NexmoClient.get()`によっても取得されます）。

> **注：** カンバセーションIDは、前のステップで提供された`Config.CONVERSATION_ID`から取得されます。

カンバセーションが取得されている場合は、カンバセーションのイベントの取得という次のステップに進む準備が整いました。

