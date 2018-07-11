---
title: Android
platform: android
---

# Getting Started with the Nexmo Stitch Android SDK

In this getting started guide we'll demonstrate how to build a simple conversation app with IP messaging using the Nexmo Stitch Android SDK.

## Concepts

This guide will introduce you to the following concepts.

* **Nexmo Applications** - contain configuration for the application that you are building
* **JWTs** ([JSON Web Tokens](https://jwt.io/)) - the Stitch API uses JWTs for authentication. JWTs contain all the information the Nexmo platform needs to authenticate requests. JWTs also contain information such as the associated Applications, Users and permissions.
* **Users** - users who are associated with the Nexmo Application. It's expected that Users will have a one-to-one mapping with your own authentication system.
* **Conversations** - A thread of conversation between two or more Users.
* **Members** - Users that are part of a conversation.

### Before you begin

* Ensure you have [Node.JS](https://nodejs.org/en/download/) and NPM installed (you'll need it for the CLI)
* Ensure you have Android Studio installed
* Create a free Nexmo account - [signup](https://dashboard.nexmo.com)
* Install the Nexmo CLI:

    ```bash
    $ npm install -g nexmo-cli@beta
    ```

    Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the [setting page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

    ```bash
    $ nexmo setup api_key api_secret
    ```

## 1 - Setup

_Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through setup._

### 1.1 - Create a Nexmo application

Create an application within the Nexmo platform.

```bash
$ nexmo app:create "Stitch Android App" http://example.com/answer http://example.com/event --type=rtc --keyfile=private.key
```

Nexmo Applications contain configuration for the application that you are building. The output of the above command will be something like this:

```bash
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
No existing config found. Writing to new file.
Credentials written to /path/to/your/local/folder/.nexmo-app
Private Key saved to: private.key
```

The first item is the Application ID and the second is a private key that is used generate JWTs that are used to authenticate your interactions with Nexmo. You should take a note of it. We'll refer to this as `YOUR_APP_ID` later.


### 1.2 - Create a Conversation

Create a conversation within the application:

```bash
$ nexmo conversation:create display_name="Nexmo Chat"
```

The output of the above command will be something like this:

```sh
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the Conversation ID. Take a note of it as this is the unique identifier for the conversation that has been created. We'll refer to this as YOUR_CONVERSATION_ID later.

### 1.3 - Create a User

Create a user who will participate within the conversation.

```bash
$ nexmo user:create name="jamie"
```

The output will look as follows:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Take a note of the `id` attribute as this is the unique identifier for the user that has been created. We'll refer to this as `YOUR_USER_ID` later.

### 1.4 - Add the User to the Conversation

Finally, let's add the user to the conversation that we created. Remember to replace `YOUR_CONVERSATION_ID` and `YOUR_USER_ID` values.

```bash
$ nexmo member:add YOUR_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=YOUR_USER_ID
```

The output of this command will confirm that the user has been added to the "Nexmo Chat" conversation.

```sh
Member added: MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You can also check this by running the following request, replacing `YOUR_CONVERSATION_ID`:

```bash
$ nexmo member:list YOUR_CONVERSATION_ID -v
```

Where you should see a response similar to the following:

```sh
name                                     | user_id                                  | user_name | state  
---------------------------------------------------------------------------------------------------------
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | jamie     | JOINED
```

### 1.5 - Generate a User JWT

Generate a JWT for the user and take a note of it. Remember to change the `YOUR_APP_ID` value in the command.

```bash
$ USER_JWT="$(nexmo jwt:generate ./private.key sub=jamie exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID)"
```

*Note: The above command saves the generated JWT to a `USER_JWT` variable. It also sets the expiry of the JWT to one day from now.*

You can see the JWT for the user by running the following:

```bash
$ echo $USER_JWT
```

## 2 - Create the Android App

With the basic setup in place we can now focus on the client-side application

### 2.1 Start a new project and add the Nexmo Stitch SDK

Open Android Studio and start a new project. We'll name it "Stitch Android Quickstart 1". The minimum SDK will be set to API 19. We can start with an empty activity named "Login Activity".

In the `build.gradle` file we'll add the Nexmo Stitch Android SDK and the WebRTC dependency.

```groovy
//app/build.gradle
dependencies {
...
  compile 'com.nexmo:stitch:1.7.1'
  compile 'com.android.support:appcompat-v7:25.3.1'
...
}

//build.gradle
allprojects {
    repositories {
        ...
        //WebRTC dependency for Stitch
        maven { url 'https://artifactory.ess-dev.com/artifactory/gradle-dev' }
    }
}
```

Then sync your project.

### 2.2 Add ConversationClient to your app

Before we change our activity, we're going to set up a custom application to share a reference to the `ConversationClient` across activities.

```java
// ConversationClientApplication.java
public class ConversationClientApplication extends Application {
    private ConversationClient conversationClient;

    @Override
    public void onCreate() {
        super.onCreate();
        this.conversationClient = new ConversationClient.ConversationClientBuilder().context(this).build();
    }

    public ConversationClient getConversationClient() {
        return this.conversationClient;
    }
}
```

Make sure you also add `android:name=".ConversationClientApplication"` to the `application` tag in your `AndroidManifest.xml`

```xml
<!--AndroidManifest.xml-->
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.nexmo.androidquickstart1">

    <application
        ...
        android:name=".ConversationClientApplication">
    </application>

</manifest>
```

### 2.3 Creating the login layout

We're going to create a simple layout for the first activity in our app. There will be buttons for the user to log in and start chatting.

```xml
<!--activity_login.xml-->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <TextView
        android:id="@+id/login_text"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:gravity="center"
        android:text="Welcome to Awesome Chat. Login to continue" />

    <LinearLayout
        android:id="@+id/login_layout"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_margin="16dp"
        android:orientation="horizontal">

        <Button
            android:id="@+id/login"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Login"/>

        <View
            android:layout_width="0dp"
            android:layout_height="match_parent"
            android:layout_weight="1"/>


        <Button
            android:id="@+id/chat"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Chat"/>

    </LinearLayout>

</LinearLayout>
```
### 2.3 - Create the LoginActivity

We're creating an instance of `ConversationClient` and saving it as a member variable in the activity.

We also need to wire up the buttons in `LoginActivity.java` Don't forget to replace `USER_JWT` with the JWT generated from the Nexmo CLI in step 1.5 and `CONVERSATION_ID` with the id generated in step 1.2

```java
//LoginActivity.java
public class LoginActivity extends AppCompatActivity {
    private final String TAG = LoginActivity.this.getClass().getSimpleName();
    private String CONVERSATION_ID = YOUR_CONVERSATION_ID;
    private String USER_JWT = YOUR_USER_JWT;

    private ConversationClient conversationClient;
    private TextView loginTxt;
    private Button loginBtn;
    private Button chatBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        ConversationClientApplication application = (ConversationClientApplication) getApplication();
        conversationClient = application.getConversationClient();

        loginTxt = (TextView) findViewById(R.id.login_text);
        loginBtn = (Button) findViewById(R.id.login);
        chatBtn = (Button) findViewById(R.id.chat);

        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                login();
            }
        });
        chatBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                goToChatActivity();
            }
        });
    }

    private void logAndShow(final String message) {
        Log.d(TAG, message);
        Toast.makeText(LoginActivity.this, message, Toast.LENGTH_SHORT).show();
    }
}
```

### 2.4 Stubbed Out Login

Next, let's stub out the login workflow.

Create an authenticate function that takes a username. For now, stub it out to always return the `USER_JWT` value. Also create a login function that takes a userToken (a JWT).

```java
//LoginActivity.java
private String authenticate() {
    return USER_JWT;
}

private void login() {
    loginTxt.setText("Logging in...");

    String userToken = authenticate();
    conversationClient.login(userToken, new RequestHandler<User>() {
        @Override
        public void onSuccess(User user) {
            showLoginSuccess(user);
        }

        @Override
        public void onError(NexmoAPIError apiError) {
            logAndShow("Login Error: " + apiError.getMessage());
        }
    });
}

private void showLoginSuccess(final User user) {
    loginTxt.setText("Logged in as " + user.getName() + "\nStart a new conversation");
}


```

To log in a user, you simply need to call `login` on the `conversationClient` passing in the user JWT and a `RequestHandler<User>` as arguments.

The `RequestHandler<User>` gives you two callbacks, `onSuccess` when a user has succeeded logging in and `onError` when there was an error.

After the user logs in, they'll press the "Chat" button which will take them to the ChatActivity and let them begin chatting in the conversation we've already created.

### 2.5 Navigate to ChatActivity

When we construct the intent for `ChatActivity` we'll pass the conversation's ID so that the new activity can look up which conversation to join. Remember that `CONVERSATION_ID` comes from the id generated in [step 1.3](#13---create-a-conversation).

```java
//LoginActivity.java
private void goToChatActivity() {
    Intent intent = new Intent(LoginActivity.this, ChatActivity.class);
    intent.putExtra("CONVERSATION-ID", CONVERSATION_ID);
    startActivity(intent);
}
```

### 2.6 Create the Chat layout

We'll make a `ChatActivity` with this as the layout

```xml
<!--activity_chat.xml-->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical">

            <TextView
                android:id="@+id/chat_txt"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                tools:text="Here's a chat \nThere's a chat \nEverywhere's a chat-chat"/>

        </LinearLayout>

    </ScrollView>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_gravity="bottom">

        <EditText
            android:id="@+id/msg_edit_txt"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:imeOptions="actionSend"
            android:hint="Type a message"/>

        <Button
            android:id="@+id/send_msg_btn"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Send"/>

    </LinearLayout>

</LinearLayout>
```

### 2.7 Create the ChatActivity

Like last time we'll wire up the views in `ChatActivity.java` We also need to grab the `conversationId` from the incoming intent so we can look up the appropriate conversation.

```java
//ChatActivity.java
public class ChatActivity extends AppCompatActivity {
  private final String TAG = ChatActivity.this.getClass().getSimpleName();

  private TextView chatTxt;
  private EditText msgEditTxt;
  private Button sendMsgBtn;

  private ConversationClient conversationClient;
  private Conversation conversation;
  private SubscriptionList subscriptions = new SubscriptionList();

  @Override
  protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_chat);

      chatTxt = (TextView) findViewById(R.id.chat_txt);
      msgEditTxt = (EditText) findViewById(R.id.msg_edit_txt);
      sendMsgBtn = (Button) findViewById(R.id.send_msg_btn);
      sendMsgBtn.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View v) {
              sendMessage();
          }
      });

      ConversationClientApplication application = (ConversationClientApplication) getApplication();
      conversationClient = application.getConversationClient();

      Intent intent = getIntent();
      String conversationId = intent.getStringExtra("CONVERSATION-ID");
      conversation = conversationClient.getConversation(conversationId);
  }

    private void logAndShow(final String message) {
        Log.d(TAG, message);
        Toast.makeText(ChatActivity.this, message, Toast.LENGTH_SHORT).show();
    }
}
```

### 2.8 - Sending `text` Events

To send a message we simply need to call `sendText` on our instance of `Conversation conversation`. `sendText` takes two arguments, a `String message`, and an `EventSendListener`
In the `EventSendListener` we'll get two call backs: `onSuccess()` and `onError()`. If there's an error we'll just show an error in the logs and in a toast. We'll just log out the message in the `onSuccess()` callback since we'll handle messages as they're received instead of as they're sent. You might notice that I'm checking the type of the message before I log it out. That's because a `Message` can be `Text` or an `Image`. For now we'll just worry about `Text`.

```java
//ChatActivity.java
private void sendMessage() {
    conversation.sendText(msgEditTxt.getText().toString(), new RequestHandler<Event>() {
        @Override
        public void onSuccess(Event event) {
            if (event.getType().equals(EventType.TEXT)) {
                Log.d(TAG, "onSent: " + ((Text) event).getText());
            }
        }

        @Override
        public void onError(NexmoAPIError apiError) {
            logAndShow("Error sending message: " + apiError.getMessage());
        }
    });
}
```

### 2.9 - Receiving `text` Events

We want to know when text messages are being received so we need to add a `ResultListener<Event>` to the `messageEvent()` on the `conversation`. We can do this like so:

```java
//ChatActivity.java
private void addListener() {
    conversation.messageEvent().add(new ResultListener<Event>() {
        @Override
        public void onSuccess(Event message) {
            showMessage(message);
        }
    }).addTo(subscriptions);
}

private void showMessage(final Event message) {
    if (message.getType().equals(EventType.TEXT)) {
        Text text = (Text) message;
        msgEditTxt.setText(null);
        final String prevText = chatTxt.getText().toString();
        chatTxt.setText(prevText + "\n" + text.getText());
    }
}
```

Adding a new `ResultListener<Event>` to a `conversation.messageEvent()` allows us to add a callback when a message is received.
There's only one callback `onSuccess` that gets fired whenever an `Event` is received. An `Event` can be some text or an image. When `onSuccess` is fired we'll call our `showMessage()` method.

You'll also notice this bit of code `.addTo(subscriptions)` We'll talk more about that in the next section.

Before we handle the `message` we need to ensure that it's a `Text` message. As stated earlier, `Event`s can also be an image. We won't implement images in this guide, but it's good practice for the future. `showMessage()` removes the text from the `msgEditTxt` and appends the text from the `message` to our `chatTxt` along with any previous messages.

### 2.10 - Adding and removing listeners

Finally, we need to call `addListener()` in order to send and receive messages. We should also unsubscribe from all of the `ResultListener`s when our Activity is winding down.

```java
//ChatActivity.java
@Override
protected void onResume() {
    super.onResume();
    addListener();
}

@Override
protected void onPause() {
    super.onPause();
    subscriptions.unsubscribeAll();
}
```

When we created our `ChatActivity` we added a member variable to our activity with `SubscriptionList subscriptions = new SubscriptionList();` A `SubscriptionList` is a utility list that the library provides to make it easier to manage subscriptions within the app lifecycle. Basically, when we add a new `ResultListener` we should call `.addTo(subscriptions)` on that `ResultListener` so that we can call `subscriptions.unsubscribeAll();` when our activity winds down. We do this to minimize memory leaks.

## Try it out

After this you should be able to run the app and send messages to a conversation like so:

![Hello world!](http://g.recordit.co/sky00C231e.gif)

## Where next?

Try out [Quickstart 2](/stitch/in-app-messaging/guides/2-inviting-members/android)
