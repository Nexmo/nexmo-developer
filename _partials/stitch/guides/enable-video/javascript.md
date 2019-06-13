---
title: JavaScript
language: javascript
---

# Getting Started with the Nexmo In-App Video

In this getting started guide we'll cover adding video events to the Conversation we created in the [simple conversation with audio](/client-sdk/in-app-voice/guides/enable-audio/javascript) getting started guide. We'll deal with video and media stream events, the ones that come via the conversation, and the ones we send to the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Video Conversations** - creating Video enabled Conversations.
- **Video** - enabling and disabling Video streams in a Conversation.
- **Media Stream Events** - `media:stream:on` events that fire on a Member in a Conversation when media streams are available.

## Before you begin

Ensure you have run through the [previous guide](/client-sdk/in-app-voice/guides/enable-audio/javascript).

## 1 - Extra Setup

_Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through setup and simulate the server-side logic using the Nexmo CLI._

### 1.1 - Create a new video enabled Conversation

The conversation we've been using in the other quick start guides was not video enables, so let's go ahead and create a new conversation that supports video:

```bash
$ nexmo conversation:create display_name="Nexmo Video Chat" properties='{"video":"true"}'
```

The output of the above command will be something like this:

```bash
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

That is the Conversation ID. Take a note of it as this is the unique identifier for the conversation that has been created. We'll refer to this as `YOUR_VIDEO_CONVERSATION_ID` later.

### 1.2 - Add the Users to the Conversation

In the previous guides we've created two users, `jamie` and `alice`, so let's add the users to the video enabled conversation that we created. Remember to replace the `YOUR_VIDEO_CONVERSATION_ID`, `JAMIE_USER_ID` and `ALICE_USER_ID` values:

```bash
$ nexmo member:add YOUR_VIDEO_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=JAMIE_USER_ID
$ nexmo member:add YOUR_VIDEO_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=ALICE_USER_ID
```

The output of these commands will confirm that the user has been added to the "Nexmo Video Chat" conversation:

```bash
Member added: MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You can also check this by running the following request, replacing `YOUR_VIDEO_CONVERSATION_ID`:

```bash
$ nexmo member:list YOUR_VIDEO_CONVERSATION_ID -v
```

Where you should see an output similar to the following:

```bash
name                                     | user_id                                  | user_name | state
---------------------------------------------------------------------------------------------------------
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | jamie     | JOINED
MEM-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab | alice     | JOINED
```

We don't need to generate new JWTs for `jamie` and `alice` because JWTs are user based and not member based, so we're good to go to the next section and start updating the JavaScript application we've been building.

## 2 - Update the JavaScript App

We will use the application we already created for [the audio quick start guide](/client-sdk/in-app-voice/guides/enable-audio/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 2.1 - Add video UI

First, we'll add the UI for a user to enable and disable video, as well as two `<video>` elements that we'll use to play the Video streams we're sending and receiving in the conversation. Let's add the UI at the top of the messages area:

```html
<section id="messages">
  <div>
    <button id="enable-video">Enable Video</button>
    <button id="disable-video">Disable Video</button>
  </div>
  <div>
    <video id="self-video" autoplay muted></video>
    <video id="conversation-video" autoplay></video>
  </div>
  ...
</section>
```

And add the buttons and `<video>` elements in the class constructor:

```javascript
constructor() {
...
  this.selfVideo = document.getElementById('self-video')
  this.conversationVideo = document.getElementById('conversation-video')
  this.enableVideoButton = document.getElementById('enable-video')
  this.disableVideoButton = document.getElementById('disable-video')
}
```

### 2.2 - Add enable and disable video handler

We'll then update the `setupUserEvents` method to trigger `conversation.media.enable({video: "both"})` when the user clicks the `Enable Video` button. We'll also add the corresponding `conversation.media.disable({video: "both"})` trigger for disabling the video stream:

```javascript
setupUserEvents() {
...
  this.enableVideoButton.addEventListener('click', () => {
    this.conversation.media.enable({
      video: "both"
    }).then(this.eventLogger('member:media')).catch(this.errorLogger)
  })
  this.disableVideoButton.addEventListener('click', () => {
    this.conversation.media.disable().then(this.eventLogger('member:media')).catch(this.errorLogger)
  })
}
```

### 2.3 - Change member:media listener

We already have a listener for `member:media` events from the conversation dealing with audio events. Now we're going to change that listener to handle video events as well and update the `messageFeed`. In order to do that, we'll change the listener for `member:media` events at the end of the `setupConversationEvents` method:

```javascript
setupConversationEvents(conversation) {
  ...

  conversation.on("member:media", (member, event) => {
    console.log(`*** Member changed media state`, member, event)
    var text
    if (event.body.audio !== undefined) {
      text = `${member.user.name} <b>${event.body.audio ? 'enabled' : 'disabled'} audio in the conversation</b><br>`
    } else {
      text = `${member.user.name} <b>${event.body.video ? 'enabled' : 'disabled'} video in the conversation</b><br>`
    }
  })

}
```

If we want the conversation history to be updated accordingly, we need to update the case for `member:media` in the `showConversationHistory` switch:

```javascript
showConversationHistory(conversation) {
  ...
  switch (value.type) {
    ...
    case 'member:media':
      if (value.body.audio !== undefined) {
        eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>${value.body.audio ? "enabled" : "disabled"} audio</b><br>` + eventsHistory
      } else {
        eventsHistory = `${conversation.members.get(value.from).user.name} @ ${date}: <b>${value.body.video ? "enabled" : "disabled"} video</b><br>` + eventsHistory
      }
      break;
    ...
  }
}
```

### 2.4 - Add media:stream:on listeners

With these first parts we're listening and reacting to `member:media` events that occur in the conversation. In order to get access to the video streams, we need to listen to `media:stream:on` events as well. These events don't fire on the Conversation though, they fire on a Member. Now we're going to register a listener on `conversation.me` in order to get our own video feed. Let's add a helper method `setupVideoStream` and then use that in the listener at the end of the `setupConversationEvents` method:

```javascript
setupVideoStream(video, stream) {
  if ("srcObject" in video) {
    video.srcObject = stream;
  } else {
    // Avoid using this in new browsers, as it is going away.
    video.src = window.URL.createObjectURL(stream);
  }
}

setupConversationEvents(conversation) {
  ...

  conversation.me.on("media:stream:on", (stream) => this.setupVideoStream(this.selfVideo, stream.stream))
}
```

In order to get the video from the other members of the conversation, we'll have to add a listener for each Member of the Conversation. We'll add the `media:stream:on` listener on `conversation.members` at the end of the `setupConversationEvents` method:

```javascript
setupConversationEvents(conversation) {
  ...

  for (let member of conversation.members.values()) {
    if (member.user.name != conversation.me.user.name) {
      member.on("media:stream:on", (stream) => this.setupVideoStream(this.conversationVideo, stream.stream))
    }
  }
}
```

### 2.5 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Enable video on both and start talking. You'll also see events being logged in the browser console.

That's it! You can see a full example of what your project should look like in [the source code for this quickstart on GitHub](https://github.com/Nexmo/stitch-js-quickstart/blob/master/enable-video/index.html).
