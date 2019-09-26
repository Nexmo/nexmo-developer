---
title: Create your app to phone code
description: In this step you learn how to write the code for your app to phone application.
---

# Create your app to phone code

Create an HTML file called `index.html` in your project directory. Add the following code, but make sure you paste in the JWT you generated for the user in the [earlier step](/client-sdk/tutorials/app-to-phone/client-sdk/generate-jwt) in this tutorial:

``` html
<!DOCTYPE html>
<html lang="en">

<head>
  <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
</head>

<body>

  <form id="call-phone-form">
    <h1>Call Phone from App</h1>
    <input type="text" name="phonenumber" value="">
    <input type="submit" value="Call" />
  </form>

  <script>

const USER_JWT = "PASTE YOUR JWT HERE";

callPhoneForm = document.getElementById("call-phone-form");

function errorLogger(error) {
  console.log(error);
}

new NexmoClient({ debug: true })
  .login(USER_JWT)
  .then(app => {
    callPhoneForm.addEventListener("submit", event => {
      event.preventDefault();
      let number = callPhoneForm.children.phonenumber.value;
      app.callServer(number);
    });
  })
  .catch(errorLogger);
  </script>
</body>

</html>
```

This is your web application that uses the Client SDK to make a voice call to the destination phone via Nexmo.

There are several key components to this code:

1. A simple UI that allows you to enter a phone number and then click the `Call` button to make the voice call.
2. Code that logs the user in (a JWT is used for authentication).
3. Event handlers for `member:call` and `call:status:changed`.
4. The function to make the call `callServer(number)`, where number is the destination phone number in [E.164](concepts/guides/glossary#e-164-format) format.

Once you enter the phone number and click the `Call` button you will hear a voice reporting on call status. Then when the call goes through you can answer and you will then hear the conversation via the app.

In a later step you learn how to run this app via a local web server.
