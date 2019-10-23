---
title: How to authenticate users
navigation_weight: 2
---

# User Authentication

In order to use the Conversation API, either directly or via [Client SDKs](/client-sdk/overview), a User must be:

1. Created by the Conversation API
2. Have a valid [JWT](https://jwt.io/), provided by your backend. If you are using Client SDK, you User will need to log in to the SDK with the JWT.

## Authentication flow

The steps in authentication flow are:

1. A User requests to log in to your client-side application
2. Your backend generates a JWT user token
3. Your backend sends the JWT to your client-side application
4. Your client-side application can make authenticated requests to the the Conversation API, with the provided JWT

This authentication flow is illustrated in the following diagram:

```sequence_diagram
    participant Client 
    participant Backend
    participant Conversation API
    Client-->>Backend: 1. Requests authentication
    Backend-->>Conversation API: 2. Authenticates user
    Conversation API-->>Backend: 3. Generates JWT
    Backend-->>Client: 4. Returns JWT
    Client-->>Conversation API: 5. Client uses JWT in each request

```

These steps are described in more detail below.

1. **A User requests to log in to the SDK.** Your client-side app makes a request to your backend to authenticate the user. In that request your client app sends any credentials that your backend requires for your own authentication system.

2. **Your backend performs authentication.** If your own authentication process is successful, you send a request to the Conversation API to authenticate the User.

3. **The Conversation API generates a JWT.** If the user is valid your backend calls the Conversation API to generate a JWT for the user. To [generate a JWT](/conversation/guides/jwt-acl) you need:

    a. Your Nexmo application's **private key**. For security reasons, this should be generated and always securely stored on your backend application and not on the client.

    b. **A username** that matches the username of the Nexmo User you’ve created with Conversation API.
    
    c.  **Nexmo Application ID** for the application that contains the User you generated the JWT for.
    
    d. An [Access Control List (ACL)](/conversation/concepts/jwt-acl#acls) that defines the user permissions. These permissions define the API endpoints is the user allowed to access.

4. Your backend **sends the JWT** to your client-side application.

5. Your client-side application can make authenticated requests to the Conversation API, with the provided JWT. If you use the Nexmo Client SDK, your User should log in to the SDK with the JWT. As long as you are logged in, the authentication will be handled for you by the SDK.

You are now ready to start creating a rich communication experience for your users.

## Reference

For further information see the following documentation:

### Guides

* [Application setup](/conversation/guides/application-setup)
* [Event flow](/conversation/guides/event-flow)
* [Generating JWTs](/conversation/guides/jwt-acl)

### API References

* [Conversation API](/api/conversation)
* [Client SDK](/client-sdk/overview)
* [Voice API](/voice/voice-api/overview)
