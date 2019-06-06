---
title: How to authenticate users
navigation_weight: 2
---

# User Authentication

In order to use the Client SDKs, a User must be:

1. Created by the Conversation API
2. Logged in to the Nexmo Client SDK, using a JWT, that your backend provides to your client app.

## Authentication flow

The steps in authentication flow are:

1. A User requests to log in to the SDK
2. Your backend generates a JWT user token
3. Your backend sends the JWT to your client-side application
4. Your client-side application logs in to the Nexmo Client SDK, with the provided JWT

This authentication flow is illustrated in the following diagram:

![Programmable Conversation Authentication Set Up](/assets/images/conversation-api/conv-diagram-auth.gif)

These steps are described in more detail below.

1. **A User requests to log in to the SDK.** Your client-side app makes a request to your backend to authenticate the user. In that request your client app sends any credentials that your backend requires for your own authentication system.

2. **Your backend generates a JWT user token.** Your backend decides whether to enable the user to login, based on your own chosen logic and authentication system. If the user is valid your backend generates a JWT for the user. To [generate a JWT](/conversation/guides/jwt-acl) you need:

    a. Your Nexmo application's **private key**. For security reasons, this should be generated and always securely stored on your backend application and not on the client.

    b. **A username** that matches the username of the Nexmo User you’ve created with Conversation API.
    
    c.  **Nexmo Application ID** for the application that contains the User you generated the JWT for.
    
    d. An [Access Control List (ACL)](/conversation/concepts/jwt-acl#acls) that defines the user permissions. These permissions define the API endpoints is the user allowed to access.

3. Your backend **sends the JWT** to your client-side application.

4. Your client-side application **logs in** to the Nexmo Client SDK, with the provided JWT.

You are now ready to start creating a rich communication experience for your users.
