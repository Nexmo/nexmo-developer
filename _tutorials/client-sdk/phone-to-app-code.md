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

  <script>

    function errorLogger(error) {
        console.log(error);
    }

    const AGENT_JWT = "PASTE YOUR USER JWT HERE";

    let textarea = document.createElement("TEXTAREA");
    document.body.appendChild(textarea);
    
    new NexmoClient({ debug: true })
    .login(AGENT_JWT)
    .then(app => {
        app.on("member:call", (member, call) => {
            node = document.createTextNode("Inbound call...");
            textarea.appendChild(node)
            call.answer();
        });
    })
    .catch(errorLogger);
  </script>
</body>
</html>

```

This is your web application that uses the Client SDK to accept an inbound call.

In a later step you learn how to run this app via a local web server. You will then be able to dial the Nexmo number associated with this application and have your app handle receive the inbound call.
