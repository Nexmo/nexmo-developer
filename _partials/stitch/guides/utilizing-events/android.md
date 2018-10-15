---
title: Android
platform: android
---

# Using more Event Listeners with the Nexmo Stitch Android SDK

In this getting started guide we'll demonstrate how to show previous history of a Conversation we created in the [simple conversation](/stitch/in-app-messaging/guides/simple-conversation/android) getting started guide. From there we'll cover how to show when a member is typing and mark text as being seen.

## Concepts

This guide will introduce you to **Conversation Events**. We'll be attaching the `MarkedAsSeenListener` and `SeenReceiptListener` listeners to a Conversation, after you are a Member.


### Before you begin


* Ensure you have run through the [the first](/stitch/in-app-messaging/guides/simple-conversation/android) and [second](/stitch/in-app-messaging/guides/inviting-members/android) quickstarts.
* Make sure you have two Android devices to complete this example. They can be two emulators, one emulator and one physical device, or two physical devices.

## 1 - Setup

For this quickstart you won't need to emulate any server side events with the Nexmo CLI. You'll just need to be able to login as both users created in quickstarts 1 and 2.

If you're continuing on from the previous guide you may need to regenerate the users JWTs. See quickstarts 1 and 2 for how to do so.

## 2 Update the Android App

We will use the application we already created for quickstarts 1 and 2. With the basic setup in place we can now focus on updating the client-side application. We can leave the LoginActivity as is. For this demo, we'll solely focus on the ChatActivity.

### 2.1 Updating the ChatActivity layout

We're going to be adding some new elements to our chat app so let's update our layout to reflect them. The updated layout should look like so:

```xml
<!--activity_chat.xml-->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context="com.nexmo.a3usingevents.ChatActivity">

    <android.support.v7.widget.RecyclerView
        android:id="@+id/recycler"
        android:layout_marginLeft="8dp"
        android:layout_marginRight="8dp"
        android:layout_marginBottom="16dp"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1" />

    <TextView
        android:id="@+id/typing_notification"
        android:layout_gravity="center"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        tools:text="Someone is typing"/>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content">

        <EditText
            android:id="@+id/chat_box"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:inputType="textAutoComplete"
            tools:text="This is a sample" />

        <ImageButton
            android:id="@+id/send_btn"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:background="@null"
            android:layout_gravity="center"
            android:src="@drawable/ic_send_black_24dp"/>

    </LinearLayout>

</LinearLayout>
```

Notice that we've added the RecyclerView as well as a TextView with the id `typing_notification`. We'll load the messages in the RecyclerView and show a message in the `typing_notification` TextView when a user is typing.


### 2.2 Adding the new UI to the ChatActivity

In the previous examples we showed messages by adding to a TextView. For this example we'll show you how to use the Stitch SDK in a RecyclerView. Let's add our new UI elements to the ChatActivity:

```java
//ChatActivity.java
public class ChatActivity extends AppCompatActivity {
    private String TAG = ChatActivity.class.getSimpleName();

    private EditText chatBox;
    private ImageButton sendBtn;
    private TextView typingNotificationTxt;
    private RecyclerView recyclerView;
    private ChatAdapter chatAdapter;

    private ConversationClient conversationClient;
    private Conversation conversation;
    private SubscriptionList subscriptions = new SubscriptionList();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chat);

        conversationClient = ((ConversationClientApplication) getApplication()).getConversationClient();
        Intent intent = getIntent();
        String conversationId = intent.getStringExtra("CONVERSATION_ID");
        conversation = conversationClient.getConversation(conversationId);

        recyclerView = (RecyclerView) findViewById(R.id.recycler);
        chatAdapter = new ChatAdapter(conversation);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(ChatActivity.this);
        recyclerView.setAdapter(chatAdapter);
        recyclerView.setLayoutManager(linearLayoutManager);

        chatBox = (EditText) findViewById(R.id.chat_box);
        sendBtn = (ImageButton) findViewById(R.id.send_btn);
        typingNotificationTxt = (TextView) findViewById(R.id.typing_notification);

        sendBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sendMessage();
            }
        });
    }

    private void sendMessage() {
        conversation.sendText(chatBox.getText().toString(), new RequestHandler<Event>() {
            @Override
            public void onError(NexmoAPIError apiError) {
                logAndShow("Error sending message: " + apiError.getMessage());
            }

            @Override
            public void onSuccess(Event result) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        chatBox.setText(null);
                    }
                });
            }
        });
    }
}
```

We'll also need to attach the EventListener. We'll do so in `attachListeners()`

```java
@Override
protected void onResume() {
    super.onResume();
    attachListeners();
}

//ChatActivity.java
private void attachListeners() {
    conversation.messageEvent().add(new ResultListener<Event>() {
        @Override
        public void onSuccess(Event result) {
            chatAdapter.notifyDataSetChanged();
            recyclerView.smoothScrollToPosition(chatAdapter.getItemCount());
        }
    }).addTo(subscriptions);
}
```

And since we're attaching the listeners we'll need to remove them as well. Let's do that in the `onPause` part of the lifecycle.

```java
//ChatActivity.java
@Override
protected void onPause() {
    super.onPause();
    subscriptions.unsubscribeAll();
}
```

### 2.3 Creating the ChatAdapter and ViewHolder

Our RecyclerView will need a Adapter and ViewHolder. We can use this:

```java
//ChatAdapter.java
public class ChatAdapter extends RecyclerView.Adapter<ChatAdapter.ViewHolder> {

    private static final String TAG = "ChatAdapter";
    private List<Event> events = new ArrayList<>();

    public ChatAdapter(Conversation conversation) {
        events = conversation.getEvents();
    }

    @Override
    public ChatAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        Context context = parent.getContext();
        LayoutInflater inflater = LayoutInflater.from(context);
        View contactView = inflater.inflate(R.layout.chat_item, parent, false);

        ViewHolder viewHolder = new ViewHolder(contactView);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(ChatAdapter.ViewHolder holder, int position) {
        Text textMessage = events.get(position);
        if (textMessage.getType().equals(EventType.TEXT)) {
            holder.text.setText(textMessage.getText());
        }
    }

    @Override
    public int getItemCount() {
        return events.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final TextView text;
        private final ImageView seenIcon;

        public ViewHolder(View itemView) {
            super(itemView);
            text = (TextView) itemView.findViewById(R.id.item_chat_txt);
            seenIcon = (ImageView) itemView.findViewById(R.id.item_chat_seen_img);
        }
    }
}
```

We'll also need to create a layout for the ViewHolder. Our layout will have a textview to hold the message text. The layout will also have a check mark image that we can make visible or set the visibility to `gone` depending on if the other users of the chat have seen the message or not. The layout will look like so:

```xml
<!-- layout/chat_item.xml -->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:orientation="horizontal"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content">

    <TextView
        android:id="@+id/item_chat_txt"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="center"
        tools:text="Hello World!"/>

    <View
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:layout_weight="1"
        />

    <ImageView
        android:id="@+id/item_chat_seen_img"
        android:layout_gravity="center"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:src="@drawable/ic_done_all_black_24dp"
        android:visibility="gone"/>

</LinearLayout>
```

### 2.4 - Show chat history

The chat history should be ready when we start the `ChatActivity` so we'll fetch the history in `LoginActivity` before we fire the intent to start the next activity. We'll modify the `goToConversation()` method in `LoginActivity` to reflect this.

```java
// LoginActivity.java
private void goToConversation(final Conversation conversation) {
    conversation.updateEvents(null, null, new RequestHandler<Conversation>() {
        @Override
        public void onError(NexmoAPIError apiError) {
            logAndShow("Error Updating Conversation: " + apiError.getMessage());
        }

        @Override
        public void onSuccess(final Conversation result) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Intent intent = new Intent(LoginActivity.this, ChatActivity.class);
                    intent.putExtra("CONVERSATION_ID", conversation.getConversationId());
                    startActivity(intent);
                }
            });
        }
    });
}
```

Calling `updateEvents()` on a conversation retrieves the event history. You can pass in two `Event` ids into the `updateEvents()` method to tell it to only retrieve events within the timeframe of those IDs.  We'll pass `null` into the first two parameters instead since we want to fetch the whole history of the conversation. Now when we fire the intent and start the `ChatActivity` we'll have the history of the chat loaded into the RecyclerView.

### 2.5 - Adding Typing and Seen Listeners

We can add other listeners just like we added our other Listener. The `startTyping` and `stopTyping` is used to indicate when a user is currently typing or not. The `typingEvent()` is used to listen to typing events sent. Finally, the `seenEvent()` will be used to mark our messages as read. We'll add theses listeners to our `attachListeners()` method.

```java
//ChatActivity.java
private void attachListeners() {
  ...

  chatBox.addTextChangedListener(new TextWatcher() {
      @Override
      public void beforeTextChanged(CharSequence s, int start, int count, int after) {
          //intentionally left blank
      }

      @Override
      public void onTextChanged(CharSequence s, int start, int before, int count) {
          //intentionally left blank
      }

      @Override
      public void afterTextChanged(Editable s) {
          if (s.length() > 0) {
              sendTypeIndicator(Member.TYPING_INDICATOR.ON);
          } else {
              sendTypeIndicator(Member.TYPING_INDICATOR.OFF);
          }
      }
  });

  conversation.typingEvent().add(new ResultListener<Member>() {
      @Override
      public void onSuccess(final Member member) {
          runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  String typingMsg = member.getTypingIndicator().equals(Member.TYPING_INDICATOR.ON) ? member.getName() + " is typing" : null;
                  typingNotificationTxt.setText(typingMsg);
              }
          });
      }
  }).addTo(subscriptions);

  conversation.seenEvent().add(new ResultListener<Receipt<SeenReceipt>>() {
      @Override
      public void onSuccess(Receipt<SeenReceipt> result) {
          runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  chatAdapter.notifyDataSetChanged();
              }
          });
      }
  }).addTo(subscriptions);
}

private void sendTypeIndicator(Member.TYPING_INDICATOR typingIndicator) {
    switch (typingIndicator){
        case ON: {
            conversation.startTyping(new RequestHandler<Member.TYPING_INDICATOR>() {
                @Override
                public void onSuccess(Member.TYPING_INDICATOR typingIndicator) {
                    //intentionally left blank
                }

                @Override
                public void onError(NexmoAPIError apiError) {
                    logAndShow("Error start typing: " + apiError.getMessage());
                }
            });
            break;
        }
        case OFF: {
            conversation.stopTyping(new RequestHandler<Member.TYPING_INDICATOR>() {
                @Override
                public void onSuccess(Member.TYPING_INDICATOR typingIndicator) {
                    //intentionally left blank
                }

                @Override
                public void onError(NexmoAPIError apiError) {
                    logAndShow("Error stop typing: " + apiError.getMessage());
                }
            });
            break;
        }
    }
}
```

We can tell the Stitch SDK when a member is typing using `TextView`'s `addTextChangedListener`. We'll attach a `TextWatcher` to the `chatBox`. In the `afterTextChanged` callback we'll look at the length of the text in the EditText. If the text is greater than 0, we know that the user is still typing. Depending on if the user is typing we'll call `sendTypeIndicator()` with `Member.TYPING_INDICATOR.ON` or `Member.TYPING_INDICATOR.OFF` as an argument. The `sendTypeIndicator` method just fires either `conversation.startTyping()` or `conversation.stopTyping()` By adding a listener to `conversation.typingEvent()` we can then update our `typingNotificationTxt` with the correct message of who's typing or set the message to null if no one is typing.

Finally we'll add a Listener to the `conversation.seenEvent()` so that when an event is marked as seen, we'll update the `ChatAdapter` and show the events as seen in our UI.


### 2.6 - Marking Text messages as seen

We'll only want to mark our messages as read when the other user has seen the message. If the user has the app in the background, we'll want to wait until they bring the app to the foreground and they have seen the text message in the RecyclerView in the `ChatActivity`. To do so, we'll need to mark messages as seen in the `ChatAdapter.` Let's make the following changes to the `ChatAdapter`

```java
// ChatAdapter.java
public class ChatAdapter extends RecyclerView.Adapter<ChatAdapter.ViewHolder> {

    private static final String TAG = "ChatAdapter";
    private Member self;
    private List<Event> events = new ArrayList<>();

    public ChatAdapter(Conversation conversation) {
        self = conversation.getSelf();
        events = conversation.getEvents();
    }

    ...

    @Override
    public void onBindViewHolder(ChatAdapter.ViewHolder holder, int position) {
        if (events.get(position).getType().equals(EventType.TEXT)) {
            final Text textMessage = (Text) events.get(position);
            if (!textMessage.getMember().equals(self) && !memberHasSeen(textMessage)) {
                textMessage.markAsSeen(new RequestHandler<SeenReceipt>() {
                    @Override
                    public void onSuccess(SeenReceipt result) {
                        //Left blank
                    }

                    @Override
                    public void onError(NexmoAPIError apiError) {
                        Log.d(TAG, "mark as seen onError: " + apiError.getMessage());
                    }
                });
            }
            holder.text.setText(textMessage.getMember().getName() + ": " + textMessage.getText());
            if (textMessage.getSeenReceipts().isEmpty()) {
                holder.seenIcon.setVisibility(View.INVISIBLE);
            } else {
                holder.seenIcon.setVisibility(View.VISIBLE);
            }
        }
    }

    private boolean memberHasSeen(Text textMessage) {
      boolean seen = false;
      for (SeenReceipt receipt : textMessage.getSeenReceipts()) {
          if (receipt.getMember().equals(self)) {
              seen = true;
              break;
          }
      }
      return seen;
    }
    ...
}
```

We've added `Member self` to our constructor and as a member variable to the `ChatAdapter`. We've also made some changes to the `onBindViewHolder` method. Before we start marking something as read, we want to ensure that we're referring to a `Text` message. That's what the `events.get(position).getType().equals(EventType.TEXT)` check is doing. We only want to mark a message as read if it the sender of the message is not our `self`. That's why `!textMessage.getMember().equals(self)` is there. We also don't want to mark something as read if it's already been marked read. The `memberHasSeen` method looks up all of the `SeenReceipt`s and will only mark the method as read if the current user hasn't created a `SeenReceipt`. Then, we only want to show the `seenIcon` if the message has been marked as read. That's what `!textMessage.getSeenReceipts().isEmpty()` is for.

## Try it out

Run the apps on both of your emulators. On one of them, login with the username "jamie". On the other emulator login with the username "alice"
Once you've completed this quickstart, you can run the sample app on two different devices. You'll be able to login as a user, join an existing conversation, chat with users, show a typing indicator, and mark messages as read.

## Where next?

Try out [Enabling Audio in your App](/stitch/in-app-voice/guides/enable-audio/android)
