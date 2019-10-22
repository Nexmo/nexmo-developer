## Part 1: Link your Facebook Page to your Nexmo account

Linking your Facebook page to your Nexmo account allows Nexmo to handle inbound messages and enables you to send messages from the Nexmo Messages API.

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

**8.** Paste your JWT into the box labeled "2. Provide a valid JWT token".

**9.** You will receive a message confirm successful subscription.

At this point your Nexmo Account and this Facebook Page are linked.


## Part 2: Link your Facebook Page to your Nexmo application

Once your Facebook page is linked to your Nexmo account, it becomes available for use by any of your applications. Here is how to link the page to a Nexmo application:

**1.** Navigate to the [Messages and Dispatch applications page](https://dashboard.nexmo.com/messages/applications).

**2.** From the list, select the application you want to link to.

**3.** Then, select the "External Accounts" tab from the top navigation.

**4.** Finally, click the "Link" button beside your Facebook Page (the `Provider` should be `messenger`).

You're now ready to receive messages users send on your Facebook Page.


> **NOTE:** If at some point in the future you want to link a different application to this Facebook Page, you can simply redo Part 2 for the new application.



## Re-linking your Facebook page to your Nexmo account

The link between your Nexmo account and Facebook page expires after 90 days. You can re-link it by performing the following steps:

**1.** Generate a new temporary application and an associated JWT using the same process that you used to [create the initial link](#link-your-facebook-page-to-your-nexmo-account).

**2.** Visit the following page and select the page you want to re-link from the drop down list:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

**3.** Paste the JWT you generated in step 1 into the "Provide a valid JWT token" text box.

**4.** Click "Unsubscribe".

**5.** When the page is successfully unsubscribed, re-link it by clicking "Subscribe".
