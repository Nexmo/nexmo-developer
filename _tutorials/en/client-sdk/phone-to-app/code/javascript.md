---
title: Create a client side application
description: In this step you learn how to write the code for your phone to app application.
---

# Create a client side application

Create an HTML file called `index.html` in your project directory. Add the following code, but make sure you paste in the JWT you generated for the user in the [earlier step](/client-sdk/tutorials/phone-to-app/client-sdk/generate-jwt) in this tutorial:

``` html
<!DOCTYPE html>
<html lang="en">
<head>
  <script src="nexmoClient.js"></script>
</head>
<body>

  <h1>Inbound PSTN phone call</h1>
  <p id="notification">Lines are open for calls...</p>
  <br />
  <button type="button" id="answer">Answer</button>
  <button type="button" id="reject">Reject</button>
  <button type="button" id="hangup">Hang Up</button>
  <script>

    const AGENT_JWT = "PASTE ALICE JWT HERE";

    new NexmoClient({ debug: true })
    .login(AGENT_JWT)
    .then(app => {

        const answerBtn = document.getElementById("answer");
        const rejectBtn = document.getElementById("reject");
        const hangupBtn = document.getElementById("hangup");
        const notification = document.getElementById("notification");

        app.on("member:call", (member, call) => {
            notification.textContent = "You are receiving a call";
            // Answer the call.
            answerBtn.addEventListener('click', () => {
                call.answer();
                notification.textContent = "You are in a call";
            });
            // Reject the call
            rejectBtn.addEventListener("click", () => {
                call.reject();
                notification.textContent = `You rejected the call`;
            });
            // Hang-up the call
            hangupBtn.addEventListener("click", () => {
                call.hangUp();
                notification.textContent = `You ended the call`;
            });
        });

        app.on("call:status:changed", (call) => {
          notification.textContent = "Call Status: " + call.status;
        });
    })
    .catch(console.error);
  </script>
</body>
</html>
```

This is your web application that uses the Client SDK to accept an inbound call.

The main features of this code are:

1. A notification box that can be updated with the call status.
2. A button used when the agent wants to answer an inbound call.
3. A button used when the agent wants to reject an inbound call.
4. A button used when the agent wants to hang-up an inbound call.
5. The code logs the agent in using the user JWT generated in an [earlier step](/client-sdk/tutorials/phone-to-app/client-sdk/generate-jwt).
6. The code sets up two main event handlers. The first is fired on the inbound call. This in turn sets up 3 click button event handlers which answers, rejects and hangs-up the inbound call using the Client SDK method `call.answer()`,`call.reject()`, and `call.hangUp()` respectively.
7. The second, the call status changed (`call:status:changed`) event handler sets the text of the notification box to the inbound call status.
