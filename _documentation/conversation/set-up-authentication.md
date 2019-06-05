---
title: Set Up Authentication
---

# Set Up Authentication

In order to use the Client SDKs, a User must be:

1. Created by the Conversation API

2. Logged in to the SDK, using a JWT, that your backend provides to your client app.

![Programmable Conversation Authentication Set Up](/assets/images/conversation-api/conv-diagram-auth.gif)



High-level authentication flow should look as such:

1. Your client app should make a request to your backend to authenticate a user. Your client app should send the user’s credential.

2. Your backend should decide if to allow access to the user, based on the given credentials. If so, your backend generates a JWT for the User.

3. Generating a JWT requires: 

    * Your account’s private key. For security reasons, this should be generated and always securely  stored on your backend application.

    * A username that matches the username of the Nexmo User you’ve created with Conversation API.

    * ACLs that define the allowed permissions for the User to the API endpoints.

    * Nexmo Application ID that contains the User you generate the JWT for.

    > Read more about generating JWT and available ACLs [in this topic].

3. Your backend should send the JWT to your client-side application.

4. Your client-side application should log in to the Nexmo Client SDK.

5. You can start creating rich communication experience!


## Reference

* [Conversation API Reference](/api/conversation)
* [Client SDK](/client-sdk/overview)
