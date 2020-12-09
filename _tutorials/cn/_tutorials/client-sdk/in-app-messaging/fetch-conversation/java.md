---
title:  Fetch the conversation
description:  In this step you join your Users to your Conversation

---

Fetch the Conversation
======================

Chat screen (`ChatFragment` and `ChatViewModel` classes) is responsible for fetching the conversation and all the conversation events.

View (`ChattFragment`) creation results in calling `viewModel.getConversation()` method that loads the conversation.

Inside `ChatViewModel` class, locate the following line and fill in the `getConversation()` method implementation:

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

Notice the use of the `client` - this references the exact same object as the  `client` referred in the `LoginViewModel` (instance is also retrieved by `NexmoClient.get()`).

> **Note:** Conversation id is retrieved from `Config.CONVERSATION_ID` provided in the previous step.

If a conversation has been retrieved, you're ready to process to the next step: getting the events for your conversation.

