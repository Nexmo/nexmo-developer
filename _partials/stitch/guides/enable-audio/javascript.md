---
title: JavaScript
language: javascript
---

# Enable Audio in your Application

In this guide we'll cover adding audio events to the Conversation we have created in the [simple conversation with events](/client-sdk/in-app-messaging/guides/utilizing-events/javascript) guide. We'll deal with sending and receiving  media events to and from the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Stream** - The stream that the SDK gives you in your browser to listen to audio and send audio
- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created
- **Media Event** - a `member:media` event that fires on a Conversation when the media state changes for a member

## Before you begin

- Run through the [previous guide](/client-sdk/in-app-messaging/guides/utilizing-events/javascript)

## 1 - Update the JavaScript App

We will use the application we created for [the third getting started guide](/client-sdk/in-app-messaging/guides/utilizing-events/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 - Add audio UI

First, we'll add the UI for the user to enable and disable audio, as well as an `<audio>` element that we'll use to play the Audio stream from the conversation. Let's add the UI at the top of the messages area.

```html
<section id="messages">
  <div>
    <audio id="audio">
      <source>
    </audio>
    <button id="enable">Enable Audio</button>
    <button id="disable">Disable Audio</button>
  </div>
  ...
</section>

```

And add the buttons and `<audio>` element in the class constructor

```javascript
constructor() {
...
  this.audio = document.getElementById('audio')
  this.enableButton = document.getElementById('enable')
  this.disableButton = document.getElementById('disable')
}
```

### 1.2 - Add enable audio handler

We'll then update the `setupUserEvents` method to trigger `conversation.media.enable()` when the user clicks the `Enable Audio` button. The `conversation.media.enable()` returns a promise with a stream object, which we'll use as the source for our `<audio>` element. We'll then add a listener on the `<audio>` element to start playing as soon as the metadata has been loaded.

```javascript
setupUserEvents() {
...
  this.enableButton.addEventListener('click', () => {
    this.conversation.media.enable().then(stream => {
      // Older browsers may not have srcObject
      if ("srcObject" in this.audio) {
        this.audio.srcObject = stream;
      } else {
        // Avoid using this in new browsers, as it is going away.
        this.audio.src = window.URL.createObjectURL(stream);
      }

      this.audio.onloadedmetadata = () => {
        this.audio.play();
      }

      this.eventLogger('member:media')()
    }).catch(this.errorLogger)
  })
}
```

Note that enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

### 1.3 - Add disable audio handler

Next, we'll add the ability for a user to disable the audio stream as well. In order to do this, we'll update the `setupUserEvents` method to trigger `conversation.media.disable()` when the user clicks the `Disable Audio` button.

```javascript
setupUserEvents() {
...
  this.disableButton.addEventListener('click', () => {
    this.conversation.media.disable().then(this.eventLogger('member:media')).catch(this.errorLogger)
  })
}
```

### 1.4 - Add member:media listener

With these first parts we're sending `member:media` events into the conversation. Now we're going to register a listener for them as well that updates the `messageFeed`. In order to do that, we'll add a listener for `member:media` events at the end of the `setupConversationEvents` method

```javascript
setupConversationEvents(conversation) {
  ...

  conversation.on("member:media", (member, event) => {
    console.log(`*** Member changed media state`, member, event)
    const text = `${member.user.name} <b>${event.body.audio ? 'enabled' : 'disabled'} audio in the conversation</b><br>`
    this.messageFeed.innerHTML = text + this.messageFeed.innerHTML
  })

}
```

If we want the conversation history to be updated, we need to add a case for `member:media` in the `showConversationHistory` switch:

```javascript
showConversationHistory(conversation) {
  ...
  switch (value.type) {
    ...
    case 'member:media':
      eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>${value.body.audio ? "enabled" : "disabled"} audio</b><br>` + eventsHistory
      break;
    ...
  }
}
```


### 1.5 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Enable audio on both and start talking. You'll also see events being logged in the browser console.

That's it! Your page should now look something like [this](https://github.com/Nexmo/stitch-js-quickstart/blob/master/enable-audio/index.html).
