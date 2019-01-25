---
title: JavaScript
language: javascript
---

# Inviting Members with the Nexmo Client SDK for JavaScript

In this getting started guide we'll cover creating a second user and inviting them to the Conversation we created in the [simple conversation](/client-sdk/in-app-messaging/guides/simple-conversation/javascript) getting started guide. From there we'll list the conversations that are available to the user and upon receiving an invite to new conversations we'll automatically join them.

## Concepts

This guide will introduce you to the following concepts.

- **Invites** - you can invite users to a conversation
- **Application Events** - `member:invited` events that fire on an Application, before you are a Member of a Conversation
- **Conversation Events** - `member:joined` and `text` events that fire on a Conversation, after you are a Member

## Before you begin

- Ensure you have run through the [previous guide](/client-sdk/in-app-messaging/guides/simple-conversation/javascript)
- Ensure you have the previous [application set up in the CLI](https://github.com/Nexmo/nexmo-cli/tree/beta#setup-an-application)

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

_Note: The above command sets the expiry of the JWT to one day from now._

You can see the JWT for the user by running the following:

```bash
$ echo $SECOND_USER_JWT
```

## 2 - Update the JavaScript App

We will use the application we already created for [the first getting started guide](/client-sdk/in-app-messaging/guides/simple-conversation/javascript). With the basic setup in place we can now focus on updating the client-side application.

### 2.1 - Add placeholder UI to list Conversations

Update `index.html` with a placeholder section to list conversations.

```html
<style>
...
    #conversations {
        display: none;
    }
...
</style>
...
<body>
...
    <section id="conversations">
        <h1>Conversations</h1>
    </section>
```

We'll also update the constructor method with a reference to the `conversations` element.

```javascript
constructor() {
    ...
    this.conversationList = document.getElementById('conversations')
}
```

### 2.2 - Update the stubbed out Login

Now, let's update the login workflow to accommodate a second user.

Define a constant with a value of the second User JWT that was created earlier and set the value to the `SECOND_USER_JWT` that was generated earlier.

```html
<script>
...
const SECOND_USER_JWT = 'SECOND USER JWT';

</script>
```

Update the `authenticate` function. We'll return the `USER_JWT` value if the `username` is `'jamie'` or `SECOND_USER_JWT` for any other `username`.

```html
<script>

authenticate(username) {
  return username.toLowerCase() === "jamie" ? USER_JWT : SECOND_USER_JWT;
}
</script>
```

Next, update the login form handler to show the conversation elements instead of the message elements when the form is submitted.

```javascript
this.loginForm.addEventListener('submit', (event) => {
    event.preventDefault()
    const userToken = this.authenticate(this.loginForm.children.username.value)
    if (userToken) {
        this.listConversations(userToken)
    }
})
```

### 2.3 - Update the JS needed to list the Conversations

In the previous quick start guide we retrieved the conversation directly using a hard-coded `YOUR_CONVERSATION_ID`. This time we're going to list the conversations that the user is a member, allowing the user to select the conversation they want to join. We're going to delete the `joinConversation` method and create the `listConversations` method:

```javascript
listConversations(userToken) {
  new ConversationClient({
          debug: false
      })
      .login(userToken)
      .then(app => {
          console.log('*** Logged into app', app)
          return app.getConversations()
      })
      .then((conversations) => {
        console.log('*** Retrieved conversations', conversations);

        this.updateConversationsList(conversations)
      })
      .catch(this.errorLogger)
}
```

We're going to create the `updateConversationsList` method. It will create the HTML wrapper element for the conversations. The code cycles through the conversations, creating HTML elements for each of them, binding a click event listener to each of them, and then adds the element to the wrapper element. The code checks if there were any conversations added, and if not lists a message and then appends the wrapper element to the UI. Finally, it shows the conversations list and hides the login form.

```javascript
updateConversationsList(conversations) {
  let conversationsElement = document.createElement("ul");
  for (let id in conversations) {
      let conversationElement = document.createElement("li");
      conversationElement.textContent = conversations[id].display_name;
      conversationElement.addEventListener("click", () => this.setupConversationEvents(conversations[id]));
      conversationsElement.appendChild(conversationElement);
  }

  if (!conversationsElement.childNodes.length) {
      conversationsElement.textContent = "You are not a member of any conversations"
  }

  this.conversationList.appendChild(conversationsElement)
  this.conversationList.style.display = 'block'
  this.loginForm.style.display = 'none'
}
```


We need to also update `setupConversationEvents` in order to hide the `conversationList` and show the messages.

```javascript
setupConversationEvents(conversation) {
  this.conversationList.style.display = 'none'
  document.getElementById("messages").style.display = "block"
  ...
}
```


### 2.4 - Listening for Conversation invites and accepting them

The next step is to add a listener on the `application` object for the `member:invited` event. Once we receive an invite, we're going to automatically join the user to that Conversation, and re-login the user in order to update the UI. We're going to update the `listConversations` method in order to do that.

```javascript
listConversations(userToken) {

    new ConversationClient({
            debug: false
        })
        .login(userToken)
        .then(app => {
            console.log('*** Logged into app', app)

            app.on("member:invited", (member, event) => {
              //identify the sender and type of conversation.
              if (event.body.cname.indexOf("CALL") != 0 && member.invited_by) {
                console.log("*** Invitation received:", event);

                //accept an invitation.
                app.getConversation(event.cid || event.body.cname)
                  .then((conversation) => {
                    this.conversation = conversation
                    conversation.join().then(() => {
                      var conversationDictionary = {}
                      conversationDictionary[this.conversation.id] = this.conversation
                      this.updateConversationsList(conversationDictionary)
                    }).catch(this.errorLogger)

                  })
                  .catch(this.errorLogger)
              }
            })
            return app.getConversations()
        })
        .then((conversations) => {
            console.log('*** Retrieved conversations', conversations);

            this.updateConversationsList(conversations)

        })
        .catch(this.errorLogger)
}
```

### 2.5 - Listening for members who joined a conversation

Update the `setupConversationEvents` method by adding code to listen for the `member:joined` event on the conversation and then show a message in the UI about a member joining the conversation:

```javascript
setupConversationEvents(conversation) {
  ...

  conversation.on("member:joined", (member, event) => {
    const date = new Date(Date.parse(event.timestamp))
    console.log(`*** ${member.user.name} joined the conversation`)
    const text = `${member.user.name} @ ${date}: <b>joined the conversation</b><br>`
    this.messageFeed.innerHTML = text + this.messageFeed.innerHTML
  })
}
```

Your `index.html` should now look something like [this](https://github.com/Nexmo/stitch-js-quickstart/blob/master/inviting-members/index.html).

### 2.6 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and login as `alice` in the other. Focus the browser window where you're logged in with `alice`.

### 2.7 - Invite the second user to the conversations

Now you will invite `alice` to the conversation that you created. In your terminal, run the following command and remember to replace your `YOUR_CONVERSATION_ID` for the Conversation you created in the first guide and the `SECOND_USER_ID` with the one you got when creating the User for `alice`.

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

Return to the previously opened browser windows so you can see `alice` has a conversation listed now. You can click the conversation name and proceed to chat between `alice` and `jamie`.

## Where next?

- Try out [Quickstart 3](/client-sdk/in-app-messaging/guides/utilizing-events/javascript)
- Have a look at the <a href="/sdk/stitch/javascript/" target="_blank">Nexmo Client SDK for JavaScript API Reference</a>
