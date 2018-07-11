---
title: JavaScript
language: javascript
---

# Call Convenience methods for Stitch and JavaScript

In this getting started guide we'll cover adding call methods to the Conversation we created in the [simple conversation with audio](/stitch/in-app-voice/guides/1-enable-audio/javascript) getting started guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

## Concepts

This guide will introduce you to the following concepts.

- **Calls** - calling an User in your application without creating a Conversation first
- **Call Events** - `member:call` event that fires on an Application
- **Call State Events** - `call:member:state` event that fires on a Call

## Before you begin

- Ensure you have run through the [previous guide](/stitch/in-app-voice/guides/1-enable-audio/javascript)

## 1 - Update the JavaScript App

We will use the application we already created for [the first audio getting started guide](/stitch/in-app-voice/guides/1-enable-audio/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 - Add call control UI

First, we'll add the UI for a user to call another user, and then be able to hang up. We'll hide the `call-controls` using CSS until the user is in a call. Let's add the UI at the top of the conversations area.

```html
  <style>
    #call-controls {
      display: none;
    }
  </style>
  <section id="conversations">
    <form id="call-form">
      <h1>Call User</h1>
      <input type="text" name="username" value="">
      <input type="submit" value="Call" />
    </form>
    <div id="call-controls">
      <span id="call-members">You are in a call with </span><button id="hang-up">Hang Up</button>
    </div>
    ...
  </section>
```

And add the new UI in the class constructor

```javascript
constructor() {
  ...
  this.callForm = document.getElementById('call-form')
  this.callControls = document.getElementById('call-controls')
  this.hangUpButton = document.getElementById('hang-up')
  this.callMembers = document.getElementById('call-members')
}
```


### 1.2 - Add helper methods

We'll need a few helper methods so we reduce code duplication in our App. We'll be reusing the `<audio>` element we added in the [previous guide](/stitch/in-app-voice/guides/1-enable-audio/javascript) to play the audio stream. What this does is take the stream and put it as the source of the `<audio>` tag, and then add a listener to play the audio as soon as the metadata is loaded. So let's add `setupAudioStream(stream)` as a class method:

```javascript
setupAudioStream(stream) {
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
}
```

We were using something similar in the previous guide, so let's refactor our code to use the new helper method we just created. We'll update the event listener for the `enableButton` to look something like this:

```javascript
this.enableButton.addEventListener('click', () => {

  this.conversation.media.enable().then(stream => {
    this.setupAudioStream(stream)

    this.eventLogger('member:media')()
  }).catch(this.errorLogger)
})
```

We hid the `call-control` elements via CSS, so let's add a `showCallControls(member)` as a helper method to display them and add information about the members in a call:

```javascript
showCallControls(member) {
  this.callControls.style.display = "block"
  this.callMembers.textContent = this.callMembers.textContent + " " + member.invited_by || member.user.name
}
```

### 1.3 - Add `member:call` listener

Next, we'll add a listener for `member:call` events on the app, so that we can let the user know when someone calls. We'll add a `window.confirm` modal that either accepts the incoming call or hangs up. If the user answers the call, we'll pass the `stream` to the utility function we created earlier and then show the call controls. Let's update the `app` promise after `login(userToken)` with the code:

```javascript
...
.login(userToken)
.then(app => {
  ...
  this.app = app

  app.on("member:call", (member, call) => {
    if (window.confirm(`Incoming call from ${member.user.name}. Do you want to answer?`)) {
      this.call = call
      call.answer().then((stream) => {
        this.setupAudioStream(stream)
        this.showCallControls(member)
      })
    } else {
      call.hangUp()
    }
  })
})
```

### 1.4 - Add Call functionality

With these first parts we're listening `member:call` events on the application. Now let's see how to trigger those type of events, by making a call. Let's add an event listener for `callForm` inside the `setupUserEvents()` method. We'll take a list of user names from the input and pass those to the `call()` method on the Application object. When the promise returns we can take the `activeStream.stream` and pass that into the helper we created to setup audio.

```javascript
setupUserEvents() {
  ...

  this.callForm.addEventListener('submit', (event) => {
    event.preventDefault()
    var usernames = this.callForm.children.username.value.split(",").map(username => username.trim())

    this.app.call(usernames).then(call => {
      this.setupAudioStream(call.application.activeStream.stream)
      this.call = call

      call.on("call:member:state", (from, state, event) => {
        if (state = "ANSWERED") {
          this.showCallControls(from)
        }
        console.log("member: " + from.user.name + " has " + state);
      });
    });

  })

}
```

If we want the UI to be updated, we need to add a listener for `call:member:state` in the method we just created, that going to listen for state changes in the call, and in case an `ANSWERED` state happens, i.e. someone answers the call, we'll show the UI about who's in the call and a hang up button. So let's go ahead and replace the `callForm` event listener with:

```javascript
setupUserEvents() {
  ...

  this.callForm.addEventListener('submit', (event) => {
    event.preventDefault()
    var usernames = this.callForm.children.username.value.split(",").map(username => username.trim())

    this.app.call(usernames).then(call => {
      this.setupAudioStream(call.application.activeStream.stream)
      this.call = call

      call.on("call:member:state", (from, state, event) => {
        if (state = "ANSWERED") {
          this.showCallControls(from)
        }
        console.log("member: " + from.user.name + " has " + state);
      });
    });

  })

}
```

### 1.5 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Call one from the other, accept the call and start talking. You'll also see events being logged in the browser console.

Thats's it! Your page should now look something like [this](https://github.com/Nexmo/conversation-js-quickstart/blob/master/examples/6-calling-users/index.html).

### 1.6 - Calling a Stitch user from a phone

After you've set up you're app to handle incoming calls, you can follow the [PSTN to IP tutorial](https://www.nexmo.com/blog/2018/05/13/connect-phone-call-to-stitch-in-app-voice-dr/) published on our blog to find out how you can connect a phone call to a Stitch user. Now you can make PSTN Phone Calls via the Nexmo Voice API and receive those calls via the Stitch SDK.

## Where next?

- Have a look at the [Nexmo Stitch JavaScript SDK API Reference](/sdk/stitch/javascript/)
