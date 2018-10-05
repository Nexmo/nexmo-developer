---
title: Simple chat system
products: stitch
description: "Simple chat system. Clients can connect via the web browser and chat with others who have logged into the Conversation."
languages:
    - Node
---

# Intro

This tutorial presents a simple chat system where users can connect into the chat system via their web browser and communicate with others who are logged into the chat room.

## In this tutorial

In this tutorial you see how to build a simple browser-based chat system:

1. Install command line tool (Beta)
2. Create a Nexmo Application
3. Install Stitch
4. Create a Conversation
5. Create a User
6. Add User to the Conversation
7. Create a JWT
8. Create a Stitch app using Node

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)

## Install Nexmo Command Line Interface (CLI) Beta

In this tutorial you will use the Nexmo CLI to create your Nexmo application and perform some other housekeeping tasks - you can also perform these operations in the Nexmo Dashboard if you find that easier.

To install the Nexmo CLI:

``` bash
$ npm install -g nexmo-cli@beta
```

You now need to initialize your project directory:

``` bash
$ nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```

This will create a `.nexmorc` file in your home directory. This is required for other command line operations to work correctly.

You can obtain your `NEXMO_API_KEY` and `NEXMO_API_SECRET` from your Nexmo dashboard.

## Create a Nexmo Application

To create a Stitch application within the Nexmo platform you execute the following command:

``` bash
$ nexmo app:create "Simple Chat" https://example.com/webhooks/answer https://example.com/webhooks/event --type=rtc --keyfile=private.key
```

This will return an Application UUID:

``` bash
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

This is your `NEXMO_APPLICATION_ID`. Make a note of your `NEXMO_APPLICATION_ID` as you will use it when linking a Nexmo number to your application and also when creating a JWT.

The parameters to the `app:create` command are as follows:

* The name of the app "Simple Chat".
* Answer webhook URL that will be called by Nexmo when you make a call (not used in this example).
* Event webhook URL that Nexmo will call back on with details of events (not used in this example).
* The name of the generated private key to be associated with the application.

> **Note:** The actual values you use for the Event webhook URL and the Answer webhook URL will depend on whether you are hosting your webhook server on the web or testing locally using Ngrok. In this example they are not used.

## Install Stitch

In the directory where you are keeping the code for your project:

``` bash
npm install nexmo-stitch
```

## Create a Conversation

To create a Conversation:

```
nexmo conversation:create display_name="Old School Chat"
```

This will return :

```
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Make a note of this Conversation ID.

## Create a User

Create a User:

``` bash
$ nexmo user:create name="John"
```

``` bash
$ nexmo user:create name="Kevin"
```

``` bash
$ nexmo user:create name="Larry"
```

## Add User to the Conversation

Add three users.

Add John:

``` bash
$ nexmo member:add CON-c57324d0-602f-42fe-9ab6-771e676a5a38 action=join channel='{"type":"app"}' user_id=USR-be623fbb-8baf-41d0-bb78-c804a847a00f
```

Add Kevin:

``` bash
$ nexmo member:add CON-c57324d0-602f-42fe-9ab6-771e676a5a38 action=join channel='{"type":"app"}' user_id=USR-81346640-8145-4dde-8ad0-66bf4613b771
```

Add Larry:

``` bash
nexmo member:add CON-c57324d0-602f-42fe-9ab6-771e676a5a38 action=join channel='{"type":"app"}' user_id=USR-ff17a309-4daa-4b95-bc7d-ed083b12e852
```

## Create JWTs for each User

Create a JWT for each user:

``` bash
USER_JWT="$(nexmo jwt:generate ./private.key sub=John exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=NEXMO_APPLICATION_ID)"
```

``` bash
USER2_JWT="$(nexmo jwt:generate ./private.key sub=Kevin exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=NEXMO_APPLICATION_ID)"
```

``` bash
USER3_JWT="$(nexmo jwt:generate ./private.key sub=Larry exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=NEXMO_APPLICATION_ID)"
```

You can see the generated JWT in each case by using a command such as:

``` bash
$ echo USER_JWT
```

Make a note of these JWTs, you will add them into your app code.

## Create your Stitch app

You now need to create the code for your Stitch application. This code allows a user to log in via a simple login box. The user is then validated and assigned the correct JWT accordingly (alternatively a JWT could be generated dynamically for the user once authenticated). There is a text area for entering a message and an associated button for submitting the message.

Here's the complete code:

``` html
<!DOCTYPE html>
<html>

<head>
    <style>
        #login,
        #messages {
            width: 80%;
            height: 300px;
        }

        #messages {
            display: none;
        }

        #conversations {
            display: none
        }
    </style>
    <script src="./node_modules/nexmo-stitch/dist/conversationClient.js"></script>
</head>

<body>
    <p>You are logged in as: <div id="logged-in-as"></div></p> 

    <form id="login">
        <h1>Login</h1>
        <input type="text" name="username" value="">
        <input type="submit" value="Login" />
    </form>

    <section id="messages">
        <h1>Messages</h1>

        <div id="messageFeed"></div>

        <textarea id="messageTextarea"></textarea>
        <br>
        <button id="send">Send</button>
    </section>

    <section id="conversations">
        <h1>Conversations</h1>
    </section>

    <script>
        const USER_JWT = 'eyJhbGciOiJSUzI....1cKuF8OVYg';
        const USER2_JWT = 'eyJhbGciOiJSUz....wit2sIR5lA';
        const USER3_JWT = 'eyJhbGciOiJSUz....rQFwKEGAgw';
        const YOUR_CONVERSATION_ID = 'CON-c57324d0-602f-42fe-9ab6-771e676a5a38';

        class ChatApp {
            constructor() {
                // Get control IDs
                this.messageTextarea = document.getElementById('messageTextarea');
                this.messageFeed = document.getElementById('messageFeed');
                this.sendButton = document.getElementById('send');
                this.loginForm = document.getElementById('login');
                // Attach event handlers
                this.setupUserEvents();
            }

            errorLogger(error) {
                console.log('errorLogger.');
                console.log('The error was: ', error);
            }

            eventLogger(event) {
                return () => {
                    console.log("'%s' event was sent", event);
                }
            }

            // Authenticate the user is valid and assign corresponding JWT (JWTs expire after a day so they may
            // need to be re-generated).
            authenticate(username) {

                var user = username.toLowerCase();

                switch (user) {

                    case "john":
                        return USER_JWT;
                        break;

                    case "kevin":
                        return USER2_JWT;
                        break;

                    case "larry":
                        return USER3_JWT;
                        break;

                    // Not a known user so bail out
                    default:
                        console.log(`ERROR: user ${user} not recognized.`);
                        return null;
                        break;
                }
            }

            // Chat events
            setupConversationEvents(conversation) {
                this.conversation = conversation
                console.log('*** Conversation Retrieved', conversation);
                console.log('*** Conversation Member', conversation.me);

                // Bind to events on the conversation
                conversation.on('text', (sender, message) => {
                    console.log('*** Message received', sender, message);
                    const date = new Date(Date.parse(message.timestamp));
                    const text = `${sender.user.name} @ ${date}: <b>${message.body.text}</b><br>`;
                    this.messageFeed.innerHTML = text + this.messageFeed.innerHTML;
                })
            }

            // Log into chat once a valid JWT has been obtained
            loginToConversation(userToken) {
                new ConversationClient({ debug: false })
                    .login(userToken)
                    .then(app => {
                        console.log(`DEBUG: ${app.me.name} Logged into app.`);
                        document.getElementById('logged-in-as').innerHTML = app.me.name;
                        return app.getConversation(YOUR_CONVERSATION_ID);
                    })
                    .then(this.setupConversationEvents.bind(this))
                    .catch(this.errorLogger)
            }

            // Event handlers for Message Send button and Login button
            setupUserEvents() {

                // Send a message into the conversation
                this.sendButton.addEventListener('click', () => {
                    this.conversation.sendText(this.messageTextarea.value).then(() => {
                        this.eventLogger('text')();
                        this.messageTextarea.value = '';
                    }).catch(this.errorLogger)
                })

                // When the user logs in with a username authenticate them, obtain the right JWT
                // and then log them into the conversation
                this.loginForm.addEventListener('submit', (event) => {
                    event.preventDefault();
                    var user = this.loginForm.username.value;
                    const userToken = this.authenticate(user);
                    if (userToken) {
                        document.getElementById('messages').style.display = 'block';
                        document.getElementById('login').style.display = 'none';
                        this.loginToConversation(userToken);
                    }
                })
            }
        }

        new ChatApp()
    </script>

</body>

</html>
```

Review the code comments to help understand how the code works.

## Try it out

Open three browser tabs. Log in as the three users (one user per tab) and chat away.

## Conclusion

In this tutorial you have seen how to create a simple browser-based chat system.

## Resources

* [In-App Messaging documentation](/stitch/in-app-messaging/overview)
