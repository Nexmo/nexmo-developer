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
        input, button {
            font-size: 1rem;
        }
        #hangup {
            display:none;
        }
    </style>
</head>

<body>
    <h1>Call Phone from App</h1>
    <label for="phone-number">Your Phone Number:</label>
    <input type="text" name="phone-number" value="" placeholder="i.e. 14155550100" id="phone-number" size="30">
    <button type="button" id="call">Call</button>
    <button type="button" id="hangup">Hang Up</button>
    <div id="status"></div>

    <script>
        const USER_JWT = "PASTE YOUR JWT HERE";
        const phoneNumberInput = document.getElementById("phone-number");
        const callButton = document.getElementById("call");
        const hangupButton = document.getElementById("hangup");
        const statusElement = document.getElementById("status");
        new NexmoClient({ debug: true })
            .login(USER_JWT)
            .then(app => {
                callButton.addEventListener("click", event => {
                    event.preventDefault();
                    let number = phoneNumberInput.value;
                    if (number !== ""){
                        app.callServer(number);
                    } else {
                        statusElement.innerText = 'Please enter your phone number.';
                    }
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
            .catch(console.error);
    </script>

</body>

</html>
```

This is your web application that uses the Client SDK to make a voice call to the destination phone via Nexmo.

There are several key components to this code:

1. A simple UI that allows you to enter a phone number and then click the `Call` button to make the voice call.
2. Code that logs the user in (a JWT is used for authentication).
3. The function to make the call `callServer(number)`, where `number` is the destination phone number in [E.164](/concepts/guides/glossary#e-164-format) format.

Once you enter the phone number and click the `Call` button you will hear a voice reporting on call status. Then when the call goes through you can answer and you will then hear the conversation via the app.
