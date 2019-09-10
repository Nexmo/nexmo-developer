---
title: JavaScript
language: javascript
---

# Getting Started with the Nexmo Client SDK for JavaScript

In this getting started guide you'll see how to build a simple conversation app with IP messaging using the Nexmo Client SDK for JavaScript.

## Concepts

This guide will introduce you to the following concepts:

* **Nexmo Applications** - These contain configuration for the application that you are building.
* **JWTs** ([JSON Web Tokens](https://jwt.io/)) - the Client SDK API uses JWTs for authentication. JWTs contain all the information the Nexmo platform needs to authenticate requests. JWTs also contain information such as the associated Applications, Users and permissions.
* **Users** - users who are associated with the Nexmo Application. It's expected that Users will have a one-to-one mapping with your own authentication system.
* **Conversations** - A thread of conversation between two or more Users.
* **Members** - Users that are part of a conversation.

## Before you begin

There are certain prerequisites you need to have in place before you begin this tutorial:

* Ensure you have [Node.JS](https://nodejs.org/) installed.
* Create a free Nexmo account - [sign up](https://dashboard.nexmo.com)
* Install the Nexmo CLI:

```bash
$ npm install -g nexmo-cli@beta
```

* Initialize the CLI:

Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the [setting page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard. The following command will create a `.nexmorc` file in your home directory, containing your API secret and API key. This is required for some of the other command line operations.

```bash
$ nexmo setup api_key api_secret
```

## 1 - Setup

_Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through setup._

### 1.1 - Create a Nexmo Application

Create a Nexmo application within the Nexmo platform to use within this guide.

```bash
$ nexmo app:create "My Client SDK App" https://example.com/answer https://example.com/event --type=rtc --keyfile=private.key
```

The output of the above command will be something like this:

```bash
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
No existing config found. Writing to new file.
Credentials written to /path/to/your/local/folder/.nexmo-app
Private Key saved to: private.key
```

The first item is the Application ID which you should take a note of. We'll refer to this as `YOUR_APP_ID` later. The last value is a private key location. The private key is used to generate JWTs that are used to authenticate your interactions with Nexmo.


### 1.2 - Create a Conversation

Create a conversation within the application:

```bash
$ nexmo conversation:create display_name="Nexmo Chat"
```

The output of the above command will be something like this:

```bash
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the Conversation ID. Take a note of it as this is the unique identifier for the conversation that has been created. We'll refer to this as `YOUR_CONVERSATION_ID` later.


### 1.3 - Create a User

Create a user who will participate within the conversation:

```bash
$  nexmo user:create name="jamie"
```

The output of the above command will be something like this:

```bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the User ID. Take a note of it as this is the unique identifier for the user that has been created. We'll refer to this as `YOUR_USER_ID` later.

> **Note:** If you used a name other than 'jamie' you will need to specify your new name when you generate your JWT later.

### 1.4 - Add the User to the Conversation

Now you will add the user to the conversation that we created. Remember to replace `YOUR_CONVERSATION_ID` and `YOUR_USER_ID` values:

```bash
$ nexmo member:add YOUR_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=YOUR_USER_ID
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

```

### 1.5 - Generate a User JWT

Generate a JWT for the user and take a note of it. Remember to change the `YOUR_APP_ID` value in the command. Also, if you used a username other than 'jamie' you will need to specify that in the following command:

```bash
$ USER_JWT="$(nexmo jwt:generate ./private.key sub=jamie exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID)"
```

> **Note:** The above command saves the generated JWT to a `USER_JWT` constant. It also sets the expiry of the JWT to one day from now.

You can see the JWT for the user by running the following:

```bash
$ echo $USER_JWT
```

> **Tip:** It can be useful to test the validity of your JWT using [this website](https://jwt.io/). Make sure that `sub` matches the username you specified when you created a user.

## 2 - Create the JavaScript App

With the basic setup in place you can now develop the client-side application.

### 2.1 - An HTML Page with a Basic UI

Create an `index.html` page and add a very basic UI for the conversation functionality.

The UI contains:

* A simple login area. You will stub out a fake login process, but in a real application it would be expected for you to integrate with your chosen login system.
* A list of messages. All the messages will be output to this area.
* An input area. You will use this to send a new message.

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    #login, #messages {
      width: 80%;
      height: 300px;
    }

    #messages {
      display: none;
    }
  </style>
</head>
<body>

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

  <script>
    // Your code will go here
  </script>

</body>
</html>
```

### 2.2 - Add the Nexmo Client SDK for JavaScript

Install the Nexmo Client SDK for JavaScript:

```bash
$ npm install nexmo-client
```

Include the Nexmo Client SDK for JavaScript in the `<head>`:

```html
<script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
```

> **Note:** Depending on where your Node modules are installed you may need to modify the path given here.

### 2.3 - Stubbed Out Login

Next, let's stub out the login workflow.

Define a constant with a value of the User JWT that was created earlier and set the value to the `USER_JWT` that was generated earlier. Create a `YOUR_CONVERSATION_ID` with the value of the Conversation ID that was created earlier to indicate the conversation we're going to be using.

You will also create a class called `ChatApp` that creates some instance variables selecting our HTML elements for use later, an error logging method, an event logging method and stub out the functions you'll be creating later:

```html
<script>
const USER_JWT = 'YOUR USER JWT';
const YOUR_CONVERSATION_ID = 'YOUR CONVERSATION ID';

class ChatApp {
  constructor() {
    this.messageTextarea = document.getElementById('messageTextarea')
    this.messageFeed = document.getElementById('messageFeed')
    this.sendButton = document.getElementById('send')
    this.loginForm = document.getElementById('login')
    this.setupUserEvents()
  }

  errorLogger(error) {
    console.log(error)
  }

  eventLogger(event) {
    return () => {
      console.log("'%s' event was sent", event)
    }
  }

  authenticate() {
    // TODO 
  }

  setupConversationEvents(conversation) {
    // TODO
  }

  joinConversation(userToken) {
    // TODO
  }

  setupUserEvents() {
    // TODO
  }
}

new ChatApp()
</script>
```

Let's fill in the `authenticate` function. For now, stub it out to always return the `USER_JWT` value. This is where you would normally use the user's session to authenticate the user and return their JWT:

```js
authenticate() {
  // Your authentication logic would go here.
  return USER_JWT
}
```

Within `setupUserEvents` we'll bind to `submit` events on the form. When this form is submitted then call `authenticate` to get the user token. Then, hide the login, show the message elements and call `joinConversation`, passing the user token:

```js
setupUserEvents() {
  this.loginForm.addEventListener('submit', (event) => {
    event.preventDefault()
    const userToken = this.authenticate()
    if (userToken) {
      document.getElementById('messages').style.display = 'block'
      document.getElementById('login').style.display = 'none'
      this.joinConversation(userToken)
    }
  })
}
```

### 2.4 - Connect and Login to Nexmo

Within the `joinConversation` function, create an instance of the `NexmoClient` and login the current user using the User JWT:

```js
joinConversation(userToken) {
  new NexmoClient({ debug: false })
    .login(userToken)
    .then(app => console.log('*** Logged into app', app))
    .catch(this.errorLogger)
}
```

### 2.5 - Accessing the Conversation Object

The next step is to have a user to retrieve the Conversation that was created. The `login` method returns a promise with the `app`. A user can be a member of many conversations you can call `app.getConversations()` to get them all. In this case we know the conversation you want so we'll request it with `app.getConversation(YOUR_CONVERSATION_ID)`:

```js
joinConversation(userToken) {
  new NexmoClient({ debug: false })
    .login(userToken)
    .then(app => {
        console.log('*** Logged into app', app)
        return app.getConversation(YOUR_CONVERSATION_ID)
    })
    .catch(this.errorLogger)
}
```

### 2.6 - Receiving and Sending `text` Events

Once we have found the conversation let's pass it to `setupConversationEvents`. We then want to listen for `text` event on the `conversation` and show them in the UI:

```js
setupConversationEvents(conversation) {
  this.conversation = conversation
  console.log('*** Conversation Retrieved', conversation)
  console.log('*** Conversation Member', conversation.me)

  // Bind to events on the conversation
  conversation.on('text', (sender, message) => {
    console.log('*** Message received', sender, message)
    const date = new Date(Date.parse(message.timestamp))
    const text = `${sender.user.name} @ ${date}: <b>${message.body.text}</b><br>`
    this.messageFeed.innerHTML = text + this.messageFeed.innerHTML
  })
}

joinConversation(userToken) {
  new NexmoClient({ debug: false })
    .login(userToken)
    .then(app => {
        console.log('*** Logged into app', app)
        return app.getConversation(YOUR_CONVERSATION_ID)
    })
    .then(this.setupConversationEvents.bind(this))
    .catch(this.errorLogger)
}
```

You will now add another event listener in the `setupUserEvents` function. When the user clicks the `send` button in the UI send whatever text has been placed in the `textarea`. This is achieved by calling `sendText` on the `conversation` reference you created in `setupConversationEvents`:

```js
setupUserEvents() {
  this.sendButton.addEventListener('click', () => {
    this.conversation.sendText(this.messageTextarea.value).then(() => {
        this.eventLogger('text')()
        this.messageTextarea.value = ''
    }).catch(this.errorLogger)
  })

  this.loginForm.addEventListener('submit', (event) => {
    event.preventDefault()
    const userToken = this.authenticate()
    if (userToken) {
      document.getElementById('messages').style.display = 'block'
      document.getElementById('login').style.display = 'none'
      this.joinConversation(userToken)
    }
  })
}
```

Your `index.html` file should now look something like [this](https://github.com/Nexmo/stitch-js-quickstart/blob/master/simple-conversation/index.html).

### Test your application

To test your application:

1. Run a local webserver using `static`, `http-server` on any free port. The default port is `8080`.
2. Load two browser windows side-by-side using address `localhost`:*port*. This will automatically load `index.html`. Note: *port* is the port you're running your local web server on.
3. Type any user name and click the Login button.
4. Type a message and send it. You can create a two-way conversation by switching between the browser tabs or windows.

## Where next?

* Try out [Quickstart 2](/client-sdk/in-app-messaging/guides/inviting-members/javascript)

