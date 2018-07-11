---
title: Getting Started
---

# Concepts

**Conversation**
    -> A conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and and can have associated Users through Memberships.

**User**
    -> The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

**Member**
    -> Memberships connect users with conversations. Each membership has one conversation and one user however a user can have many memberships to conversations just as conversations can have many members.

<br>

# Getting Started

To start you'll need a [Nexmo Account](/account/guides/management#create-and-configure-a-nexmo-account), an [Application](/concepts/guides/applications) and the  private key provided when you created the application. Follow the prerequisites if you've not got an Application already.

| ### Prerequisites
|
| #### Install the Nexmo CLI
|
| * Ensure you have [Node.JS](https://nodejs.org/) installed
| * Create a free Nexmo account - [signup](https://dashboard.nexmo.com)
| * Install the Nexmo CLI:
|
|    ```bash
|    $ npm install -g nexmo-cli@beta
|    ```
|
|    Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the [setting page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.
|
|    ```bash
|    $ nexmo setup api_key api_secret
|    ```
|
| #### Create an Application
|
| Create an application named `My first Stitch Application` and store the returned private key as `private.key` within your current working directory.
|
| ```sh
| $ nexmo app:create "My first Stitch Application" --type=rtc --keyfile=private.key
| ```
|
|
| #### Generate a JWT
|
| With a private key you can generate a JWT with the [Nexmo CLI](/tools):
|
| ```sh
| $ nexmo jwt:generate ./private.key
| ```

### Create a Conversation

```tabbed_examples
source: _examples/stitch/overview/create-a-conversation/
```

### Create a User

```tabbed_examples
source: _examples/stitch/overview/create-a-user/
```

### Join the Conversation

```tabbed_examples
source: _examples/stitch/overview/join-the-conversation/
```

# Next Steps

Read more about:

- [In-App Messaging](/stitch/in-app-messaging/overview)
- [In-App Voice](/stitch/in-app-voice/overview)
