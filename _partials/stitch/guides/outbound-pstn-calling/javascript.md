---
title: JavaScript
language: javascript
---

# Outbound PSTN Calling guide for JavaScript

In this getting started guide we'll cover adding call methods for phone numbers to the Conversation we created in the [simple conversation with user calling](/client-sdk/in-app-voice/guides/calling-users/javascript) getting started guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

## Concepts

This guide will introduce you to the following concepts.

- **Calls** - calling a phone number from your application without creating a Conversation first

## Before you begin

- Ensure you have run through the [previous guide](/client-sdk/in-app-voice/guides/calling-users/javascript)
- You should read the [NCCO guide for calling](/client-sdk/in-app-voice/guides/ncco-guide) before completing this quick start guide. In order to make an outbound PSTN call, you'll have to correctly link your application to an answer url with an NCCO. The NCCO guide goes into further detail.


## 1 - Update the JavaScript App

We will use the application we already created for [calling users getting started guide](/client-sdk/in-app-voice/guides/calling-users/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

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
  this.callPhoneForm = document.getElementById('call-phone-form')
}
```


### 1.2 - Add `callPhone` handler

All the call control UI is in place, so we'll need to add only a method for calling phones, using the `callPhone` method on the application. Let's update `setupUserEvents` with a listener for `callPhoneForm`:

```javascript
this.callPhoneForm.addEventListener('submit', (event) => {
  event.preventDefault()

  this.app.callPhone(this.callPhoneForm.children.phonenumber.value)
})
```

### 1.3 - Open the conversation a browser window

Now run `index.html` in the browser, making sure to login with the user name `jamie`. Call a phone number, accept the call and start talking. You'll also see the call status events being logged in the browser console.

Thats's it! Your page should now look something like [this](https://github.com/Nexmo/stitch-js-quickstart/blob/master/calling-phones/index.html).

<!---
## Where next?

- Have a look at the <a href="/sdk/stitch/javascript/" target="_blank">Nexmo Client SDK for JavaScript API Reference</a>
--->
