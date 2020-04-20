---
title: Java
language: java
---

```java
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import com.nexmo.client.NexmoClient;
import com.nexmo.client.NexmoConversation;
import com.nexmo.client.NexmoCustomEvent;
import com.nexmo.client.NexmoCustomEventListener;
import com.nexmo.client.request_listener.NexmoApiError;
import com.nexmo.client.request_listener.NexmoRequestListener;
import org.jetbrains.annotations.NotNull;

import java.util.HashMap;

public class SendCustomEventActivity extends AppCompatActivity {

    private NexmoCustomEventListener customEventListener = new NexmoCustomEventListener() {
        @Override
        public void onCustomEvent(NexmoCustomEvent event) {
            Log.d("TAG", "Incoming custom event of type " + event.getCustomType() + ": " + event.getData());
        }
    };

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        super.onCreate(savedInstanceState, persistentState);

        // No need for client initialization here. Client initialization is already done in BaseApplication class.
        // new NexmoClient.Builder().build(this);
        NexmoClient client = NexmoClient.get();
        client.login("JWT token");
        getConversation(client);

    }

    private void getConversation(NexmoClient client) {
        client.getConversation("CONVERSATION_ID", new NexmoRequestListener<NexmoConversation>() {
            @Override
            public void onSuccess(@Nullable NexmoConversation conversation) {
                Log.d("TAG", "Conversation loaded");

                conversation.addCustomEventListener(customEventListener);

                HashMap<String, Object> data = new HashMap<>();
                data.put("my_key", "my_data");
                sendCustomEvent(conversation, "my_custom_event", data);
            }

            @Override
            public void onError(@NonNull NexmoApiError apiError) {
                Log.d("TAG", "Error: Unable to load conversation" + apiError.getMessage());
            }
        });
    }

    private void sendCustomEvent(@NonNull NexmoConversation conversation, String eventType, HashMap<String, Object> data) {
        conversation.sendCustomEvent(eventType, data, new NexmoRequestListener<Void>() {
            public void onSuccess(@Nullable Void p0) {
                Log.d("TAG", "Custom event sent");
            }

            public void onError(@NotNull NexmoApiError apiError) {
                Log.d("TAG", "Custom event error");
            }
        });
    }
}
```
