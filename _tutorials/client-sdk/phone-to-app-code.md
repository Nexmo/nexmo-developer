---
title: Create your phone to app code
description: In this step you learn how to write the code for your phone to app application.
---

# Create your phone to app code

Create an HTML file called `index.html` in your project directory. Add the following code, but make sure you paste in the JWT you generated for the user in the [earlier step](/client-sdk/tutorials/phone-to-app/client-sdk/generate-jwt) in this tutorial:

``` html
<!DOCTYPE html>
<html lang="en">
<head>
  <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
</head>
<body>

  <h1>Inbound PSTN phone call</h1>
  <p id="console">Lines are open for calls...</p>
  <br/>
  <button id="button">Answer</button>

  <script>

    function errorLogger(error) {
        console.log(error);
    }

    const AGENT_JWT = "PASTE YOUR USER JWT HERE";

    new NexmoClient({ debug: false })
    .login(AGENT_JWT)
    .then(app => {

        let btn = document.getElementById('button');
        let con = document.getElementById('console');
    
        app.on("member:call", (member, call) => {
            con.innerHTML = "Inbound call - click to answer..."
            btn.addEventListener('click', (event) => {
                event.preventDefault();
                call.answer();
            });
        });
  
        app.on("call:status:changed", (call) => {
          con.innerHTML = call.status;
        });
    })
    .catch(errorLogger);
  </script>
</body>
</html>
```

This is your web application that uses the Client SDK to accept an inbound call.

The main features of this code are:

1. A simple text paragraph that can be updated with the call status.
2. A button used when the agent wants to answer an inbound call.
3. The code logs the agent in using the user JWT generated in an [earlier step](/client-sdk/tutorials/phone-to-app/client-sdk/generate-jwt).
4. The code sets up two main event handlers. The first is fired on the inbound call. This in turn sets up a click button event handler which answers the inbound call using the Client SDK method `call.answer()`.
5. The call status changed (`call:status:changed`) event handler simple sets the text of the text paragraph to the inbound call status.

In a later step you learn how to run this app via a local web server. You will then be able to dial the Nexmo number associated with this application and have your app handle receive the inbound call.
