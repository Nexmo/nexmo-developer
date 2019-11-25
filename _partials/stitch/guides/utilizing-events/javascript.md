---
title: JavaScript
language: javascript
---

# Using more Event Listeners with the Nexmo Client SDK for JavaScript

In this getting started guide we'll cover adding more events to the Conversation we created in the [simple conversation with member invites](/client-sdk/in-app-messaging/guides/inviting-members/javascript) getting started guide. We'll deal with multiple types of events, the ones that come via the conversation, and the ones we send to the conversation.

## Concepts

This guide will introduce you to the following concepts.

- **Conversation Events** - `member:left` and `text:` events that fire on a Conversation when someone does an Action
- **Conversation Actions** - actions that trigger events on a Conversation
- **Conversation History** - an `events` object that stores all text Events happening on a conversation

## Before you begin

- Ensure you have run through the [previous guide](/client-sdk/in-app-messaging/guides/inviting-members/javascript)

## 1 - Update the JavaScript App

We will use the application we already created for [the second getting started guide](/client-sdk/in-app-messaging/guides/inviting-members/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 - Add conversation history

The first thing we're going to do is add history to the existing conversation. 

We will use the `getEvents` method to retrieve all the events that occurred in the context of the conversation and display this history in the message feed.

The `getEvents` method returns a subset or "page" of events with each invocation. The number of events it returns is based on the `page_size` parameter. The default is 10 results, the maximum is 100.

> **Note**: See the [EventsPage](/sdk/stitch/javascript/EventsPage.html) documentation for helper methods you can use to work with this paginated data.

```javascript
showConversationHistory(conversation) {
  conversation
    .getEvents({ page_size: 20 })
    .then((events_page) => {
      var eventsHistory = ""

      events_page.items.forEach((value, key) => {
        if (conversation.members.get(value.from)) {
          const date = new Date(Date.parse(value.timestamp))
          
          switch (value.type) {
            case 'text:seen':
              break;
            case 'text:delivered':
              break;
            case 'text':
              eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>${value.body.text}</b><br>` + eventsHistory
              break;

            case 'member:joined':
              eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>joined the conversation</b><br>` + eventsHistory
              break;
            case 'member:left':
              eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>left the conversation</b><br>` + eventsHistory
              break;
            case 'member:invited':
              eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>invited to the conversation</b><br>` + eventsHistory
              break;

            default:
              eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>unknown event</b><br>` + eventsHistory
          }
        }
      })

      this.messageFeed.innerHTML = eventsHistory + this.messageFeed.innerHTML
    })
    .catch(this.errorLogger)
}
```

Next, update `setupConversationEvents` to call the method we just created

```javascript
setupConversationEvents(conversation) {
  ...

  this.showConversationHistory(conversation)
}
```

### 1.2 - Add text:seen events

Now that we've done that, it's time to learn about sending events into a conversation. In order to do that, we'll update the `text` event listener to acknowledge when a user received a message. We'll update the relevant bit from `setupConversationEvents` to check if a message in the conversation was not sent by the current user, and then call `message.seen()`. What this does, is it fires a `text:seen` event on the conversation.

```javascript
setupConversationEvents(conversation) {
...
  // Bind to events on the conversation
  conversation.on('text', (sender, message) => {
    console.log('*** Message received', sender, message)
    const date = new Date(Date.parse(message.timestamp))
    const text = `${sender.user.name} @ ${date}: <b>${message.body.text}</b><br>`
    this.messageFeed.innerHTML = text + this.messageFeed.innerHTML

    if (sender.user.name !== this.conversation.me.user.name) {
      message
        .seen()
        .then(this.eventLogger('text:seen'))
        .catch(this.errorLogger)
    }
  })
...
}
```

We're going to add a listener as well on the conversation for `text:seen`, notifying other members in the conversation that their message was seen by other members of the conversation.

```javascript
setupConversationEvents(conversation) {
...
  conversation.on("text:seen", (data, text) => console.log(`${data.user.name} saw text: ${text.body.text}`))
}
```

### 1.3 - Add text:typing events

We're going to update the conversation so that we can see when someone in typing. There are two events that enable us to do so, `text:typing:on` and `text:typing:off`, with their corresponding methods on the `conversation` object that fires them, `startTyping()` and `stopTyping()`. We'll fist update `setupConversationEvents` to listen for those events

```javascript
setupConversationEvents(conversation) {
...
  conversation.on("text:typing:off", data => console.log(`${data.user.name} stopped typing...`))
  conversation.on("text:typing:on", data => console.log(`${data.user.name} started typing...`))
}
```

Now we're going to fire those events when the user focuses or blurs the message box. We'll update the `setupUserEvents` method in order to do that

```javascript
setupUserEvents() {
...
  this.messageTextarea.addEventListener('focus', () => {
    this.conversation
      .startTyping()
      .then(this.eventLogger('text:typing:on'))
      .catch(this.errorLogger)
  });
  this.messageTextarea.addEventListener('blur', () => {
    this.conversation
      .stopTyping()
      .then(this.eventLogger('text:typing:off'))
      .catch(this.errorLogger)
  })
}
```

### 1.4 - Leave a conversation

Finally, we'll add the UI for user to leave a conversation. Let's add the button at the top of the messages area.

```html
<section id="messages">
  <button id="leave">Leave Conversation</button>
  ...
</section>
```

And add the button in the class constructor

```javascript
constructor() {
...
  this.leaveButton = document.getElementById('leave')
}
```

We'll then update the `setupUserEvents` method to trigger `conversation.leave()` when the user clicks the button

```javascript
setupUserEvents() {
...
  this.leaveButton.addEventListener('click', () => {
    this.conversation.leave().then(this.eventLogger('member:left')).catch(this.errorLogger)
  })
}
```

To finish, we're going to add a listener for `member:left` in the `setupConversationEvents` method. We'll also add a helper function to handle updating the message feed when a user joins or leaves a conversation. And refactor the `member:joined` handler to use the new helper function.

```javascript
memberEventHandler(type) {
  return (member, event) => {
    const date = new Date(Date.parse(event.timestamp))
    console.log(`*** ${member.user.name} ${type} the conversation`)
    const text = `${member.user.name} @ ${date}: <b>${type} the conversation</b><br>`
    this.messageFeed.innerHTML = text + this.messageFeed.innerHTML
  }
}

setupConversationEvents(conversation) {
  ...
  conversation.on("member:joined", this.memberEventHandler('joined'))
  conversation.on("member:left", this.memberEventHandler('left'))
}
```


### 1.5 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Open the developer tools console and start chatting. You'll see events being logged in the console.

That's it! Your page should now look something like [this](https://github.com/Nexmo/stitch-js-quickstart/blob/master/utilizing-events/index.html).


## Where next?

- Try out [Quickstart 4](/client-sdk/in-app-voice/guides/enable-audio/javascript)
