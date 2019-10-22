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

* The `nexmoClient.js` file from the `nexmo-client` Node module
* `moment.js` to help format the received message’s date and time. Install this module by running `npm install moment`
* The `chat.js` file that will contain your application's code. Create this empty file in the project's root directory

Create a file named `index.html` in your project directory with the following contents:

```html
<!DOCTYPE html>
<html>

<head>
  <style>
    body {
      font: 13px Helvetica, Arial;
    }

    #login, #messages {
      width: 80%;
      height: 500px;
    }

    form input[type=text] {
      font-size: 20px;
      height: 35px;
      padding: 0px;
    }

    button {
      height: 35px;
      background-color: blue;
      color: white;
      width: 75px;
      position: relative;
      font-size: 15px;
    }

    textarea {
      width:85%;
      font-size: 20px;
    }

    #messageFeed {
      font-size: 18px;
      padding-bottom: 20px;
      line-height: 22pt;
    }

    #status {
      height: 35px;
      font-size: 12px;
      color: blue;
    }

    #send {
      width: 85%;
    }

    #messages {
      display: none;
    }
  </style>
</head>

<body>

  <form id="login">
    <h1>Login</h1>
    <input type="text" id="username" name="username" value="" class="textbox">
    <button type="submit">Login</button>
  </form>

  <section id="messages">
    <h1 id="sessionName"></h1>
    <div id="messageFeed"></div>

    <div>
      <textarea id="messageTextarea"></textarea>
      <button id="send">Send</button>
      <div id="status"></div>
    </div>

  </section>

  <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
  <script src="./node_modules/moment/moment.js"></script>
  <script src="./chat.js"></script>

</body>

</html>
```
