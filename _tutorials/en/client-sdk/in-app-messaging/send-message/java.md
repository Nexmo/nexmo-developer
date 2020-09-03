---
title: Send a message
description: In this step you will send a message to the conversation
---

# Send a message

Time to send the first message.

Inside `ChatViewModel` class, locate the `onSendMessage` method and fill its body:

```java
public void onSendMessage(String message) {
    if (conversation == null) {
        _errorMessage.postValue("Error: Conversation does not exist");
        return;
    }

    conversation.sendText(message, new NexmoRequestListener<Void>() {
        @Overridew
        public void onError(@NonNull NexmoApiError apiError) {

        }

        @Override
        public void onSuccess(@Nullable Void aVoid) {

        }
    });
}
```

> **NOTE:** Inside `ChatFragment` class, contains `sendMessageButton listener` that was written for you. This method is called when user click `send` button. If message text exists above `viewModel.onSendMessage()` method is called.

You'll notice that, although the message was sent, the conversation doesn't include it. It is possible to call the `getConversationEvents()` method after the message is sent, but the SDK provides a better way to handle this scenario.
