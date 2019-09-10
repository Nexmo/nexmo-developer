---
title: Create your app to phone code
description: In this step you see write the code for your app to phone application.
---

# Create your app to phone code

Create an HTML file in your project directory congtaining the following code:

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

    const USER_JWT = 'eyJh...qqSHNXd3A';

    class PhoneApp {

      constructor() {
        this.callPhoneForm = document.getElementById('call-phone-form');
        this.setupUserEvents();
        this.createClient();
      }

    createClient() {
        console.log("DEBUG: creating client with JWT:  ", USER_JWT);
        new NexmoClient({ debug: false })
          .login(USER_JWT)
          .then(app => {
            console.log('DEBUG: Logged into app', app);
            this.app = app;

            app.on("member:call", (member, call) => {
              this.call = call;
              console.log("DEBUG: member:call - ", call);
            })

            app.on("call:status:changed", (call) => {
              console.log("DEBUG: call:status:changed - ", call.status);
            })
          })
          .catch(this.errorLogger)
      }

      setupUserEvents() {
        this.callPhoneForm.addEventListener('submit', (event) => {
          event.preventDefault();
          this.app.callServer(this.callPhoneForm.children.phonenumber.value);
        })
      }

      errorLogger(error) {
        console.log("ERROR: ", error);
      }

    }
    new PhoneApp();
  </script>
</body>

</html>
```
