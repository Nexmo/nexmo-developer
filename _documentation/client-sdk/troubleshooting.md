---
title: Troubleshooting
navigation_weight: 1
---

# Troubleshooting

## Working with the Nexmo CLI

### Nexmo Application setup

Since you can create multiple Nexmo applications, the commands you run refer to the application that was set up. For example, when you create a user, you must make sure to create it on the application you intended.

    * Check the app your CLI refers to by running:

    ```sh
     cat .nexmo-app
     ```

    * If you need to change the setup application, run: 
    
     ```sh
     nexmo app:setup YOU_APPLICATION_ID YOUR_PRIVATE_KEY_FILE
     ```

     for example:

     ```sh
    nexmo app:setup abababa-ababa-123123-123123-abababa private.key
    ```

### No response to commands

It you run a command and don't get a response
    * Try making sure that all the JSON objects in you command are closed objects, and not missing any `}` or `'` for example.

## JWTs

> Remember that a JWT is per user per Nexmo Application

### Invalid Token Error

* [Decode your JWT](https://jwt.io/)

* Make sure the `"application_id"` claim is correct.

* Make sure the `“sub”` is correct. Meaning, a user with this user name exists in your Nexmo Application.

* Make sure the JWT hasn't expired.

    * You can find the expiration date on `“exp”`, in Unix time, which is seconds since Jan 01 1970(UTC).
    
    * You can [convert it to human time](https://www.epochconverter.com/).
    
    * Make sure the expiration time is the future, meaning the jwt hasnt expired yet.

### Connection error or Connection Timeout 

Getting Connection error or Connection Timeout while trying to login to the SDK:

* Check the internet connection on your device

* Then `JWT` might be valid on JWT standards, however to have some claims might be incorrect per Nexmo requirements. Try generating a new `JWT`, while ensuring the correctness of your the Nexmo specific claims.


### Errors while generating to JWT

* Make sure the private key file exists. It was generated on the machine you’ve created the application.
    
    * In our docs, while using the CLI, we guide to generate and use the path`./private.key`.
    
    * Make sure your private key exist on the machine you are generating the JWT with, and that the path is correct.
    
* If you need an new private key:
    
    * You can obtain one from the [Dashboard](https://dashboard.nexmo.com/voice/your-applications). On the left hand side menu select Voice → Your Applications → select the application → Edit. On the bottom click on `Generate public / private key pair`. Remember to click `Save changes`.

    * Save the file on you machine, and update the path to it when generating the JWT.


## Push notifications

* Make sure you’ve uploaded the certificate to Nexmo's server.

* Make sure that you've enabled push notifications, and that the method `client.enablePushNotifications()` was successful. You might even want to put a log or a break point to ensure that.

* You need to have a valid admin `JWT`, meaning a `JWT` without “sub” claim. You can [Decode your JWT](https://jwt.io/) to make sure.


# Have more Questions?
Should you have any further questions, issues or feedback, please contact us on `support@nexmo.com` or at [Nexmo community Slack](https://developer.nexmo.com/community/slack)