---
title: Overview
---

# In-App Voice Overview [Developer Preview]

Nexmo In-App Voice uses WebRTC and includes all the essentials you need to build a feature rich voice experience.

- User Control – Users can control whether their audio stream is muted or unmuted.

- Notifications  – Users can be notified when they receive a call or when participants are muted.

- Group Calls – Configure call settings so users can start a group call by adding participants in real time.

## Concepts

**Conversation**
    -> A conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and and can have associated Users through Memberships.

**User**
    -> The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

**Member**
    -> Memberships connect users with conversations. Each membership has one conversation and one user however a user can have many memberships to conversations just as conversations can have many members.

**Audio**
    -> Audio streams can be enabled and disabled in a Conversation so that Members can communicate with voice.

**Media Events**
    -> Media events will fire in a Conversation when media state changes for a member. This can be when an Audio stream is started or ended.

## Getting Started

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

## Try out the quickstarts

* [JavaScript Quickstarts](/stitch/in-app-voice/guides/1-enable-audio/javascript)
* [iOS Quickstarts](/stitch/in-app-voice/guides/1-enable-audio/ios)
* [Android Quickstarts](/stitch/in-app-voice/guides/1-enable-audio/android)

## SDK Documentation

<div class="row">
  <div class="columns small-12 medium-4">
    <a href="/stitch/sdk-documentation/javascript" class="card spacious card--image card--javascript">
      <h2>JavaScript</h2>
    </a>
  </div>
  <div class="columns small-12 medium-4">
    <a href="/stitch/sdk-documentation/android" class="card spacious card--image card--android">
      <h2>Android</h2>
    </a>
  </div>
  <div class="columns small-12 medium-4">
    <a href="/stitch/sdk-documentation/ios" class="card spacious card--image card--ios">
      <h2>iOS</h2>
    </a>
  </div>
</div>

## References

* [API Reference](/api/stitch)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli/tree/beta)
* [Node.JS and Angular Demo](https://github.com/Nexmo/stitch-demo) with an [Android](https://github.com/Nexmo/stitch-demo-android) client demo

## Find the SDKs online

<div class="row">
  <div class="columns small-12 medium-4">
    <a href="https://www.npmjs.com/package/nexmo-stitch" class="card spacious card--image card--javascript-outline">
      <h2>JavaScript</h2>
    </a>
  </div>
  <div class="columns small-12 medium-4">
    <a href="https://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22com.nexmo%22%20AND%20a%3A%22stitch%22" class="card spacious card--image card--android-outline">
      <h2>Android</h2>
    </a>
  </div>
  <div class="columns small-12 medium-4">
    <a href="https://github.com/nexmo/stitch-ios-sdk" class="card spacious card--image card--ios-outline">
      <h2>iOS</h2>
    </a>
  </div>
</div>
