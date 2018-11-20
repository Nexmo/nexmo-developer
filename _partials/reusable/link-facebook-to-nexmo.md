## Link your Facebook Page to your Nexmo account

Next you'll need to link your Facebook Page to your Nexmo account. This will allow Nexmo to handle the inbound messages and allow you to send messages from the Nexmo Messages API.

> **IMPORTANT:** This process needs to be authenticated by JWT. The JWT generated in this case can be based on any Application ID in your account, as this JWT is only used to authenticate the linking process, and it not used to authenticate application-specific API calls.

You will need to paste in a valid JWT. If you don't have one you can create one as follows:

**1.** Create a temporary application:

``` shell
nexmo app:create "Delete Me Later" https://example.com/inbound https://example.com/status --keyfile=temp.key --type=messages
```

**2.** Copy the generated Application ID to the clipboard.

**3.** Generate a JWT with the following command, pasting in your Application ID:

``` shell
JWT="$(nexmo jwt:generate ./temp.key application_id=YOUR_APP_ID)"
```

> **TIP:** This JWT will expire after the default 15 minutes.

**4.** Display the generated JWT:

``` shell
echo $JWT
```

**5.** Copy the JWT to the clipboard.

You are now ready to link your Facebook Page to Nexmo:

**6.** Click the following link when you have your JWT pasted to the clipboard and you are ready to link your Facebook Page to Nexmo:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

You will see your Facebook Pages listed.

**7.** Select the Facebook Page you want to connect to your Nexmo account from the drop down list.

**8.** Paste in your JWT in the box provided (2. Provide a valid JWT token).

**9.** You will receive a message confirm successful subscription.

At this point your Nexmo Account and this Facebook Page are linked.

> **NOTE:** If at some point in the future you want to further link a specific application to this page you can now do this from the Dashboard on the External Accounts tab for the specific Messages and Dispatch application you want to link.
