---
title: Create the code to make an in-app voice call
description: In this step you learn how to write the code to make an in-app voice call to another app.
---

# Create the code to make an in-app voice call

Create an HTML file called `index1.html` in your project directory.

Add the following code, but make sure you paste the JWT you generated for the user _making_ the call in the [earlier step](/client-sdk/tutorials/app-to-app/client-sdk/generate-jwts) to the `USER_JWT` constant:

``` html
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="nexmoClient.js"></script>
  </head>
  <body>
    <form id="call-app-form">
      <h1>Call App from App</h1>
      <input type="text" name="username" value="" />
      <input type="submit" value="Call" />
    </form>
    <button id="btn-hangup" type="button">Hang Up</button>
    <script>
      const USER_JWT = "USER1_JWT";
      const callAppForm = document.getElementById("call-app-form");
      const btnHangUp = document.getElementById("btn-hangup");
      new NexmoClient({ debug: true })
        .login(USER_JWT)
        .then(app => {
          callAppForm.addEventListener("submit", event => {
            event.preventDefault();
            let username = callAppForm.children.username.value;
            console.log("username: --> ", username);
            app.callServer(username, "app");
          });

          app.on("member:call", (member, call) => {
            btnHangUp.addEventListener("click", () => {
              console.log("Hanging up...");
              call.hangUp();
            });
          });
        })
        .catch(console.error);
    </script>
  </body>
</html>
```

This is your client application that uses the Client SDK to make a voice call to the destination *user*.

There are several key components to this code:

1. A simple UI that allows you to enter a username and then click the `Call` button to make the the in-app call to the specified user.
2. Code that logs the user into the Client SDK (a JWT is used for authentication) using `.login(USER_JWT)`.
3. The function to make the call is `callServer(username, type)`, where `type` in this case is "app", as the destination is the specified user.
4. When a call is made, a button handler is loaded. When the `Hang Up` button is clicked `call.hangUp()` terminates the call.
