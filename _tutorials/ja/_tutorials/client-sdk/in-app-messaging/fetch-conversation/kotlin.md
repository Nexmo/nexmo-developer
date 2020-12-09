---
title:  カンバセーションを取得する
description:  このステップでは、ユーザーをカンバセーションに参加させます

---

カンバセーションを取得する
=============

チャット画面（`ChatFragment`および`ChatViewModel`クラス）では、カンバセーションとすべてのカンバセーションイベントを取得します。

ビュー（`ChattFragment`）を作成すると、カンバセーションをロードする`viewModel.getConversation()`メソッドが呼び出されます。

`ChatViewModel`クラス内で、次の行を見つけ、`getConversation()`メソッドの実装を埋めます：

```kotlin
private fun getConversation() {
    client.getConversation(Config.CONVERSATION_ID, object : NexmoRequestListener<NexmoConversation> {

        override fun onSuccess(conversation: NexmoConversation?) {
            this@ChatViewModel.conversation = conversation

            conversation?.let {
                getConversationEvents(it)
            }
        }

        override fun onError(apiError: NexmoApiError) {
            this@ChatViewModel.conversation = null
            _errorMessage.postValue("Error: Unable to load conversation ${apiError.message}")
        }
    })
}
```

`client`の使用に注意してください。これは、`LoginViewModel`で参照されている`client`とまったく同じオブジェクトを参照します（インスタンスは`NexmoClient.get()`によっても取得されます）。

> **注：** カンバセーションIDは、前のステップで提供された`Config.CONVERSATION_ID`から取得されます。

カンバセーションが取得されている場合は、カンバセーションのイベントの取得という次のステップに進む準備が整いました。

