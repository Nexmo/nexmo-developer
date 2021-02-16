---
title: Create a client side application
description: In this step you learn how to write the code for your app to phone application.
---

# Create a client side application

Create an HTML file called `index.html` in your project directory. Add the following code, but make sure you paste the JWT you generated for the user in the [earlier step](/client-sdk/tutorials/app-to-phone/client-sdk/generate-jwt) in this tutorial in to the `USER_JWT` constant:

``` html
<!DOCTYPE html>
<html lang="en">

<head>
    <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
    <style>
        button {
            font-size: 1rem;
        }
        #hangup {
            display:none;
        }
    </style>
</head>

<body>
    <h1>Call Your Phone from App</h1>
    <button type="button" id="call">Call Your Phone</button>
    <button type="button" id="hangup">Hang Up</button>
    <div id="status"></div>

    <script>
        const USER_JWT = "PASTE YOUR JWT HERE";
        const callButton = document.getElementById("call");
        const hangupButton = document.getElementById("hangup");
        const statusElement = document.getElementById("status");
        new NexmoClient({ debug: true })
            .login(USER_JWT)
            .then(app => {
                callButton.addEventListener("click", event => {
                    event.preventDefault();
                    app.callServer("The number in the static NCCO created earlier will be used");
                });
                app.on("member:call", (member, call) => {
                    hangupButton.addEventListener("click", () => {
                        call.hangUp();
                    });
                });
                app.on("call:status:changed",(call) => {
                    statusElement.innerText = `Call status: ${call.status}`;
                    if (call.status === call.CALL_STATUS.STARTED){
                        callButton.style.display = "none";
                        hangupButton.style.display = "inline";
                    }
                    if (call.status === call.CALL_STATUS.COMPLETED){
                        callButton.style.display = "inline";
                        hangupButton.style.display = "none";
                    }
                });
            })
            .catch(error => console.error(error));
    </script>
</body>
</html>
```

This is your web application that uses the Client SDK to make a voice call to your phone via Vonage.

There are several key components to this code:

1. A UI that allows you to click the `Call Your Phone` button to make the voice call.
2. Code that logs the user in (a JWT is used for authentication).
3. The function to make the call `callServer`. More information on `callServer` can be found [here](/sdk/stitch/javascript/Application.html#callServer__anchor).

Once you click the `Call Your Phone` button you will hear a voice reporting on call status. Then when the call goes through, you can answer, and you will then hear the conversation via the app.

> **NOTE:** To enable calling other phone numbers requires that the NCCO be dynamically created on a server. This is out of the scope for this tutorial, but more information can be found in the Vonage [Voice API documentation](/voice/voice-api/overview).

