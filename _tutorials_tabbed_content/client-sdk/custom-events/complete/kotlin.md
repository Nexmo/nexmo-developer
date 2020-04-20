---
title: Kotlin
language: kotlin
---

```kotlin
class SendCustomEventActivity : AppCompatActivity() {

    private val customEventListener = NexmoCustomEventListener {
        Log.d("TAG", "Incoming custom event of type ${it.customType} : ${it.data}")
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        // No need for client initialization here. Client initialization is already done in BaseApplication class.
        // NexmoClient.Builder().build(this)
        val client = NexmoClient.get()
        getConversation(client)
    }

    private fun getConversation(client: NexmoClient) {
        client.getConversation("CONVERSATION_ID", object : NexmoRequestListener<NexmoConversation> {
            override fun onSuccess(conversation: NexmoConversation?) {
                Log.d("TAG", "Conversation loaded")

                conversation?.let {
                    it.addCustomEventListener(customEventListener)
                    sendCustomEvent(it, "my_custom_event", hashMapOf("my_key" to "my_data"))
                }
            }

            override fun onError(apiError: NexmoApiError) {
                Log.d("TAG", "Error: Unable to load conversation ${apiError.message}")
            }
        })
    }

    private fun sendCustomEvent(conversation: NexmoConversation, eventType: String, data: HashMap<String, Any>) {
        conversation.sendCustomEvent(eventType, data, object : NexmoRequestListener<Void> {
            override fun onSuccess(p0: Void?) {
                Log.d("TAG", "Custom event sent")
            }

            override fun onError(apiError: NexmoApiError) {
                Log.d("TAG", "Custom event error")
            }
        })
    }
}
```
