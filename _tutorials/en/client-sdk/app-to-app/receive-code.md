---
title: Create the code to receive an in-app voice call
description: In this step you learn how to write the code to receive an in-app voice call from another app.
---

# Create the code to receive an in-app voice call

Create an HTML file called `index2.html` in your project directory.

Add the following code, but make sure you paste the JWT you generated for the user _receiving_ the call in the [earlier step](/client-sdk/tutorials/app-to-app/client-sdk/generate-jwts) to the `USER_JWT` constant:

``` html
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="nexmoClient.js"></script>
  </head>
  <body>
    <h1>Inbound app call</h1>
    <p id="notification">Lines are open for calls...</p>
    <br />
    <button id="button">Answer</button>
    <script>
      const USER_JWT ="USER2_JWT";

      new NexmoClient({ debug: true })
        .login(USER_JWT)
        .then(app => {
          let btn = document.getElementById("button");
          let notification = document.getElementById("notification");
          app.on("member:call", (member, call) => {
            notification.innerHTML = "Inbound app call - click to answer...";
            btn.addEventListener("click", event => {
              event.preventDefault();
              call.answer();
            });
          });
          app.on("call:status:changed", call => {
            notification.innerHTML = "Call Status: " + call.status;
          });
        })
        .catch(console.error);
    </script>
  </body>
</html>
```

This is your client application that uses the Client SDK to receive a voice call from the source *user*.

There are several key components to this code:

1. A simple UI that allows you to see if there is an inbound call and click `Answer` to answer it.
2. Code that logs the user into the Client SDK (a JWT is used for authentication), `.login(USER_JWT)`.
3. The event handler to answer the call when the answer button is clicked.
4. An event handler and UI to display when the call status changes through the `call:status:changed` event.
