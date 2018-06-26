---
title: Android
platform: android
---

# Inviting Members with the Nexmo Stitch Android SDK

In this getting started guide we'll demonstrate creating a second user and inviting them to the Conversation we created in the [simple conversation](/stitch/in-app-messaging/guides/1-simple-conversation/android) getting started guide. From there we'll list the conversations that are available to the user and upon receiving an invite to new conversations we'll automatically join them.

## Concepts

This guide will introduce you to the following concepts:

* **Invites** - How to invite users to a conversation
* **Application Events** - Attaching the `ConversationInvitedListener` to a `ConversationClient`, before you are a Member of a Conversation
* **Conversation Events** - Attaching the `MemberJoinedListener` and `MessageListener` listeners to a Conversation, after you are a Member


### Before you begin


* Ensure you have run through the [previous guide](/stitch/in-app-messaging/guides/1-simple-conversation/android)
* Make sure you have two Android devices to complete this example. They can be two emulators, one emulator and one physical device, or two physical devices.

## 1 - Setup

_Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through the setup._

### 1.1 - Create another User

Create another user who will participate within the conversation:

```bash
$  nexmo user:create name="alice"
```

The output of the above command will be something like this:

```bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the User ID. Take a note of it as this is the unique identifier for the user that has been created. We'll refer to this as `SECOND_USER_ID` later.

### 1.2 - Generate a User JWT

Generate a JWT for the user. The JWT will be stored to the `SECOND_USER_JWT` variable. Remember to change the `YOUR_APP_ID` value in the command.

```bash
$ SECOND_USER_JWT="$(nexmo jwt:generate ./private.key sub=alice exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID)"
```

*Note: The above command sets the expiry of the JWT to one day from now.*

You can see the JWT for the user by running the following:

```bash
$ echo $SECOND_USER_JWT
```

## 2 Update the Android App

We will use the application we already created for [the first getting started guide](/stitch/in-app-messaging/guides/1-simple-conversation/android). With the basic setup in place we can now focus on updating the client-side application.

### 2.1 Update the stubbed out Login

Now, let's update the login workflow to accommodate a second user.

Define a variable with a value of the second User JWT that was created earlier and set the value to the `SECOND_USER_JWT` that was generated earlier.

```java
//LoginActivity.java
public class LoginActivity extends AppCompatActivity {
    private static final String TAG = LoginActivity.class.getSimpleName();
    private String USER_JWT = YOUR_USER_JWT;
    private String SECOND_USER_JWT = YOUR_SECOND_USER_JWT;
    ...
}
```

Update the authenticate function. We'll return the USER_JWT value if the username is 'jamie' or SECOND_USER_JWT for any other username.


```java
//LoginActivity.java
private String authenticate(String username) {
        return username.toLowerCase().equals("jamie") ? USER_JWT : SECOND_USER_JWT;
    }

    private void login() {
        final EditText input = new EditText(LoginActivity.this);
        final AlertDialog.Builder dialog = new AlertDialog.Builder(LoginActivity.this)
                .setTitle("Enter the username you are logging in as")
                .setPositiveButton("Login", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        String userToken = authenticate(input.getText().toString());
                        loginAsUser(userToken);
                    }
                });

        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
        input.setLayoutParams(lp);
        dialog.setView(input);

        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                dialog.show();
            }
        });
    }

private void loginAsUser(String token) {
    conversationClient.login(token, new RequestHandler<User>() {
        @Override
        public void onSuccess(User user) {
            showLoginSuccessAndAddInvitationListener(user);
            retrieveConversations();
        }

        @Override
        public void onError(NexmoAPIError apiError) {
            logAndShow("Login Error: " + apiError.getMessage());
        }
    });
}

```

We'll be running this device on two different devices (on an emulator or physical devices), so we'll first ask which user you're logging in as. When you enter a username we'll login with their JWT. We'll also add an invitation listener and retrieve any conversations that user is already a part of. Let's cover what the `showLoginSuccessAndAddInvitationListener(user)` method will do.

### 2.2 Listening for Conversation invites and accepting them

The next step is to update the login method to listen on the application with the ConversationInvitedListener. Once we receive an invite, we're going to automatically join the user to that Conversation.

```java
//LoginActivity.java
private void showLoginSuccessAndAddInvitationListener(final User user) {
    conversationClient.invitedEvent().add(new ResultListener<Invitation>() {
        @Override
        public void onSuccess(Invitation result) {
            logAndShow(result.getInvitedBy() + " invited you to their chat");
            result.getConversation().join(new RequestHandler<Member>() {
                @Override
                public void onSuccess(Member result) {
                    goToConversation(result.getConversation());
                }

                @Override
                public void onError(NexmoAPIError apiError) {
                    logAndShow("Error joining conversation: " + apiError.getMessage());
                }
            });
        }
    });
    runOnUiThread(new Runnable() {
        @Override
        public void run() {
            loginTxt.setText("Logged in as " + user.getName() + "\nStart chatting!");
        }
    });
}
```

To respond to events where a user is invited to a conversation, you can add a `ResultListener<Invitation>` to a `invitedEvent()` on an instance of `ConversationClient`. In this example we're going to show that the user was invited, join the conversation, and then navigate to our `ChatActivity` to participate in that conversation. The `ResultListener<Invitation>` only has a success callback: `onSuccess`, which means the user successfully received the invite.

Now let's go back to our `retrieveConversations()` method:

### 2.3 List the Conversations and handle selecting one

```java
//LoginActivity.java
private void retrieveConversations() {
    conversationClient.getConversations(new RequestHandler<List<Conversation>>() {
        @Override
        public void onSuccess(List<Conversation> conversationList) {
            if (conversationList.size() > 0) {
                showConversationList(conversationList);
            } else {
                logAndShow("You are not a member of any conversations");
            }
        }

        @Override
        public void onError(NexmoAPIError apiError) {
            logAndShow("Error listing conversations: " + apiError.getMessage());
        }
    });
}
```

There are two ways to see what conversations a member is a part of. `conversationClient.getConversations()` retrieves the full list of conversations the logged in user is a Member of asynchronously. If you want retrieve the list of conversations a user is a part of in a synchronous manner, you can call `conversationClient.getConversationList()`

If there wasn't an error retrieving the list of conversations, we'll check if the user has more than one conversation that they are a part of. If there is more than one conversation, then we'll show a dialog allowing the user to select a conversation to enter. If the user doesn't have any conversations then we'll show a message telling them so.

For now, let's show the list of conversations.

```java
//LoginActivity.java
private void showConversationList(final List<Conversation> conversationList) {
    List<String> conversationNames = new ArrayList<>(conversationList.size());
    for (Conversation convo : conversationList) {
        conversationNames.add(convo.getDisplayName());
    }

    final AlertDialog.Builder dialog = new AlertDialog.Builder(LoginActivity.this)
            .setTitle("Choose a conversation")
            .setItems(conversationNames.toArray(new CharSequence[conversationNames.size()]), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    goToConversation(conversationList.get(which));
                }
            });

    runOnUiThread(new Runnable() {
        @Override
        public void run() {
            dialog.show();
        }
    });
}
```

We'll loop through the conversations the user is a member of and then show that list in a AlertDialog. When the user selects on of the already created conversations, we'll go to the `ChatActivity` with that conversation, passing along the conversation ID in an extra like in our first quickstart.

### 2.4 - Run the apps

Run the apps on both of your emulators. On one of them, login with the username "jamie". On the other emulator login with the username "alice"

### 2.5 - Invite the second user to the conversations

Finally, let's invite the user to the conversation that we created. In your terminal, run the following command and remember to replace `YOUR_APP_ID` and `YOUR_CONVERSATION_ID` ID of the Application and Conversation you created in the first guide and the `SECOND_USER_ID` with the one you got when creating the User for `alice`.

```bash
$ nexmo member:add YOUR_CONVERSATION_ID action=invite channel='{"type":"app"}' user_id=SECOND_USER_ID
```

The output of this command will confirm that the user has been added to the "Nexmo Chat" conversation.

```bash
Member added: MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You can also check this by running the following request, replacing `YOUR_CONVERSATION_ID`:

```bash
$ nexmo member:list YOUR_CONVERSATION_ID -v
```

Where you should see an output similar to the following:

```bash
name                                     | user_id                                  | user_name | state  
---------------------------------------------------------------------------------------------------------
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | jamie     | JOINED
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | alice     | INVITED

```

Return to your emulators so you can see `alice` has a conversation listed now. You can click the conversation name and proceed to chat between `alice` and `jamie`.


## Try it out

Once you've completed this quickstart, you can run the sample app on two different devices. You'll be able to login as a user, join an existing conversation or receive invites, and chat with users.

## Where next?

Try out [Quickstart 3](/stitch/in-app-messaging/guides/3-utilizing-events/android)
