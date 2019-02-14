---
title: JavaScript
language: javascript
---

# Getting Started with Screen Sharing

In this getting started guide we'll cover updating media streams to add screen sharing to the Conversation we created in the [simple conversation with video](/client-sdk/in-app-video/guides/enable-video/javascript) getting started guide. We'll deal with updating media stream events, the ones that come via the conversation.

We’ll also build a Chrome extension needed for capturing our screen and update our media object with the screen stream.

## Concepts

This guide will introduce you to the following concepts:

- **Media** updates - updating the media stream in a Conversation
- [Chrome extensions](https://developer.chrome.com/extensions) - creating and installing a simple dedicated chrome extension for capturing the screen.

## Before you begin

- Ensure you have run through the [previous guide.](/client-sdk/in-app-video/guides/enable-video/javascript)

## 1 - Creating the Nexmo Client SDK compatible Chrome extension

In order to enable screen sharing into our application, we'll need to create a Chrome extension. First, let's create a new folder, call it `chrome-extension`.

### 1.1 -  Creating the manifest file

We’ll have to create a `manifest.json` file that contains the metadata on how the extension behaves and Chrome will interpret. We’ll have to fill a few of the non-mandatory fields, making it externally connectable and dealing with permissions in order to capture either desktop, screen or tab. We'll also tell the extension to use the file `screen-capture.js` for the code. The manifest file should look like this:

``` json
{
  "name": "Nexmo Screen Share Helper",
  "description": "Allows you to capture your desktop for use in video applications",
  "version": "0.0.1",
  "manifest_version": 2,
  "permissions": [
    "desktopCapture",
    "activeTab",
    "tabs",
    "http://*/*", "https://*/*"
  ],
  "externally_connectable": {
    "matches": ["*://localhost/*", "https://*.my-dns.com/*"]
  },
  "background": {
    "scripts": ["screen-capture.js"],
    "persistent": false
  }
}
```

### 1.2 - Adding the extension’s JavaScript code

We’ll have to create the file `screen-capture.js` we referenced in the manifest, which is the code the extension will run. Nexmo Client SDK sends a `screenshare-extension-installed` message to the extension and expects a `success` answer, so we'll need to add code to check for that message. On any other message, we'll make the extension reply with the proper stream id from the screen capture. The code looks like this:

```javascript
chrome.runtime.onMessageExternal.addListener((message, sender, sendResponse) => {
  if (message === 'screenshare-extension-installed') {
    sendResponse({type: 'success', version: '0.1.0'});
  } else {
    const sources = message.sources;
    const tab = sender.tab;
    chrome.desktopCapture.chooseDesktopMedia(sources, tab, (streamId) => {
      if (!streamId) {
        sendResponse({type: 'error', message: 'Failed to get stream ID'});
      } else {
        sendResponse({type: 'success', streamId: streamId});
      }
    });
  }
  return true;
});
```

### 1.3 - Installing the extension

We'll need to install the extension on Chrome. There are a few ways to do that, the first being to publish it in the Chrome App store. But that's a lengthy process so we're opting for enabling developer extensions and installing it from there. You'll need to open [chrome://extensions/](chrome://extensions/) an toggle `Developer Mode` in the right hand corner. A few more buttons just appeared in the UI and we'll use `LOAD UNPACKED` and point that to the folder we just created for our extension, `chrome-extension`. That automatically installs and enables the extension we just created, and lists the extension id. It looks something like `aaaabbbbccccddddeeeeffffgggghhhh` and we'll have to make a note of it, we'll be using it later.

### 2 - Updating the JavaScript application

Next we'll have to update the existing JavaScript application we created in the [previous guide](/client-sdk/in-app-video/guides/enable-video/javascript).

### 2.1 -  Adding the extension’s id to ConversationClient

We will need to update the `ConversationClient` instantiation with the extension id we installed in the previous section, so let's find that in the code and update it:

``` javascript
const YOUR_EXTENSION_ID = 'aaaabbbbccccddddeeeeffffgggghhhh'

listConversations(userToken) {

  new ConversationClient({
      debug: false,
      screenShareExtensionId: YOUR_EXTENSION_ID
    })
    .login(userToken)
    ...
}
```

### 2.2 -  Updating the UI

First, we'll add the UI for user to enable screen sharing in the video stream. Let's add the UI at the top of the messages area, where the other video UI lives:


```html
<section id="messages">
  <div>
    ...
    <button id="enable-screenshare">Enable Screen Share</button>
  </div>
  ...
</section>
```

And add the button in the class constructor

```javascript
constructor() {
...
  this.enableScreenShareButton = document.getElementById('enable-screenshare')
}
```

### 2.3 - Add enable screen share handler

We'll then update the `setupUserEvents` method to trigger `conversation.media.enable({screenshare: true})` when the user clicks the `Enable Screen Share` button.

```javascript
setupUserEvents() {
...
    this.enableScreenShareButton.addEventListener('click', () => {
      this.conversation.media.enable({
        screenshare: true
      }).then(this.eventLogger('member:media')).catch(this.errorLogger)
    })
}
```

### 2.4 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Enable video on both and then enable screen sharing and start talking. You'll also see events being logged in the browser console.

Thats's it! You can see a full example of what your project should look like in [the source code for this quickstart on GitHub](https://github.com/Nexmo/stitch-js-quickstart/blob/master/enable-screen-share/index.html).

## Where next?

<!---
- Have a look at the <a href="/sdk/stitch/javascript/" target="_blank">Nexmo Client SDK for JavaScript API Reference</a>
--->
- Have a look at the documentation about [creating](https://developer.chrome.com/extensions/getstarted) and [publishing](https://developer.chrome.com/webstore/publish) Chrome extensions
