---
title: JavaScript
language: javascript
---

# Outbound PSTN Calling guide for JavaScript

In this getting started guide we'll cover adding call methods for phone numbers to the Conversation we created in the [simple conversation with user calling](/stitch/in-app-voice/guides/2-calling-users/javascript) getting started guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

## Concepts

This guide will introduce you to the following concepts.

- **Calls** - calling a phone number from your application without creating a Conversation first
- **Call Events** - `member:call` event that fires on an Application
- **Call State Events** - `call:member:state` event that fires on a Call

## Before you begin

- Ensure you have run through the [previous guide](/stitch/in-app-voice/guides/2-calling-users/javascript)
- You should read the [Outbound PSTN Calling NCCO guide](/stitch/in-app-voice/ncco-guide) before completing this quickstart. In order to make an outbound PSTN call, you'll have to correctly link your application to an answer url with an NCCO. The NCCO guide goes into further detail.


## 1 - Update the JavaScript App

We will use the application we already created for [calling users getting started guide](/stitch/in-app-voice/guides/2-calling-users/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 - Add call phone control UI

First, we'll add the UI for a user to call a phone number, and then be able to hang up. Let's add the UI at the top of the conversations area

```html
  <section id="conversations">
    <form id="call-phone-form">
      <h1>Call phone</h1>
      <input type="text" name="phonenumber" value="">
      <input type="submit" value="Call" />
    </form>
    ...
  </section>
```

And add the new UI in the class constructor

```javascript
constructor() {
  ...
  this.callForm = document.getElementById('call-phone-form')
}
```


### 1.2 - Add helper methods

We'll need a few helper methods so we reduce code duplication in our App. We'll be reusing the call handling code in the [previous guide](/stitch/in-app-voice/guides/2-calling-users/javascript) manage the call. So let's refactor that in a `handleCall(call)` method:

```javascript
handleCall(call) {
  this.setupAudioStream(call.application.activeStream.stream)
  this.call = call

  call.on("call:member:state", (from, state, event) => {
    if (state = "ANSWERED") {
      this.showCallControls(from)
    }
    console.log("member: " + from.user.name + " has " + state);
  });
}
```

We were using something similar in the previous guide, so let's refactor our code to use the new helper method we just created. We'll update the event listener for the `callForm` to look something like this:

```javascript
this.callForm.addEventListener('submit', (event) => {
  event.preventDefault()
  var usernames = this.callForm.children.username.value.split(",").map(username => username.trim())

  this.app.call(usernames).then(this.handleCall);
})
```

We'll also add a similar method for calling phones, using the `callPhone` method on the application:

```javascript
this.callPhoneForm.addEventListener('submit', (event) => {
  event.preventDefault()

  this.app.callPhone(this.callPhoneForm.children.phonenumber.value)
    .then(this.handleCall)
})
```

### 1.3 - Open the conversation a browser window

Now run `index.html` in the browser, making sure to login with the user name `jamie`. Call a phone number, accept the call and start talking. You'll also see events being logged in the browser console.

Thats's it! Your page should now look something like [this](https://github.com/Nexmo/conversation-js-quickstart/blob/master/examples/8-calling-phones/index.html).

## Where next?

- Have a look at the [Nexmo Stitch JS SDK API Reference](/sdk/stitch/javascript/)
