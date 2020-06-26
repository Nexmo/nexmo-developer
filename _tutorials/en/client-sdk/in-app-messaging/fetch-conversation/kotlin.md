---
title: Fetch the conversation
description: In this step you join your Users to your Conversation
---

# Fetch the Conversation

Chat screen (`ChatFragment` and `ChatViewModel` classes) is responsible for fetching the conversation and all the conversation events.

View (`ChattFragment`) creation results in calling `viewModel.getConversation()` method that loads the conversation.

Inside `ChatViewModel` class, locate the following line and fill in the `getConversation()` method implementation:

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

Notice the use of the `client` - this references the exact same object as the  `client` referred in the `LoginViewModel` (instance is also retrieved by `NexmoClient.get()`).

> **Note:** Conversation id is retrieved from `Config.CONVERSATION_ID` provided in the previous step.

If a conversation has been retrieved, you're ready to process to the next step: getting the events for your conversation.
