Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a `JWT` user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

We'll update the empty `<script>` tag that's at the bottom of your `<body>` tag to login with a `USER_JWT`, and update the `notification` paragraph when the login was successful. We'll create a new `NexmoClient`, and then call the `login` method, with a string for the user JWT. That returns a promise containing an `application` object, and we'll use that to check we're logged in with the correct user.

```html
<script>
  const USER_JWT = "YOUR USER JWT";

  let notification = document.getElementById("notification");

  new NexmoClient()
      .login(USER_JWT)
      .then(application => {
          notification.textContent = `You've logged in with the user ${application.me.name}`
      })
      .catch(console.log);
</script>
```

At this point you should already be able to run the app and see that you can login successfully with the SDK. Because the Nexmo Client uses IndexedDB for its sync mechanism, we suggest you don't serve `index.html` using the `file://` protocol. That corrupts the IndexedDB for any other users and makes the SDK behave inconsistently. You can use any HTTP server, like `http-server`. If you want to install it from NPM and then run it with cache disabled, here are the terminal commands:

```bash
$ npm install -g http-server
$ http-server -c-1
```
