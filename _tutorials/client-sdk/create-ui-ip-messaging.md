---
title: Create the UI
description: Create a web page to host your chat
---

# Create the UI

Create the user interface for your web chat.

The following HTML defines a `<section>` that you will use to display:

* The name of the currently logged-in user
* The user's current status - that is, whether they are currently typing a message
* The messages sent and received so far
* A text area for your user to type a new message

The web page loads three scripts once the page body has rendered:

* The `conversationClient.js` file from the `nexmo-client@beta` Node module
* `moment.js` to help format the message received date and time. Install this module by running `npm install moment`
* The `chat.js` file that will contain your application's code. Create this file in the project's root directory.

```html
<!DOCTYPE html>
<html>

<head>
  <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

  <form id="login">
    <h1>Login</h1>
    <input type="text" id="username" name="username" value="" class="textbox">
    <button type="submit">Login</button>
  </form>

  <section id="messages">
    <h1 id="sessionName"></h1>
    <div id="status"></div>
    <div id="messageFeed"></div>

    <div>
      <textarea id="messageTextarea"></textarea>
      <button id="send">Send</button>
    </div>

  </section>

  <script src="./node_modules/nexmo-client/dist/conversationClient.js"></script>
  <script src="./node_modules/moment/moment.js"></script>
  <script src="./chat.js"></script>

</body>

</html>
```