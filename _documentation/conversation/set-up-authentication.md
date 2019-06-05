---
title: Set Up Authentication
navigation_weight: 3
---

# Set Up Authentication

In order to use the Client SDKs, a User must be:

1. Created by the Conversation API

2. Logged in to the SDK, using a JWT, that your backend provides to your client app.

High-level authentication flow could look as such:

![Programmable Conversation Authentication Set Up](/assets/images/conversation-api/conv-diagram-auth.gif)

**1. A User requests to log in to the SDK**

* Your client-side app makes a request to your backend to authenticate the user.

* In that request your client app sends any credentials that your backend requires for your own authentication system.

**2. Your backend generated a JWT user token**

* Your backend decides whether to enable the user to login, based on your own chosen logic and authentication system.

* If so, your backend generates a JWT for the user.

* **Generating a JWT requires:**

    * Your Nexmo account’s **private key**. For security reasons, this should be generated and always securely  stored on your backend application

    * **A username** that matches the username of the Nexmo User you’ve created with Conversation API

    * **Nexmo Application ID** that contains the User you generate the JWT for

    * [**Access Control List (ACL)**](/conversation/concepts/jwt-acl#acls) that defines the user permissions, or in other words, which API endpoints is the user allowed to hit

> Read more about generating JWT and available ACLs [in this topic].

3. Your backend **sends the JWT** to your client-side application

4. Your client-side application **logs in** to the Nexmo Client SDK, with the provided JWT

5. You can start creating a rich communication experience for your users!
