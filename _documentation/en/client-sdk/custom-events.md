---
title: Custom Events
---

# Custom Events

Custom events allow you to add custom metadata to conversations by recording data alongside your text or audio events. You can add events [using the REST API](/conversation/code-snippets/event/create-custom-event) or using the JavaScript SDK.

## Creating a custom event

Each custom event consists of a unique `type` and a `body`. The `type` has the following restrictions:

* Must not exceed 100 characters
* Must only contain alphanumeric, `-` and `_` characters

In addition, the event body must not exceed 4096 bytes.

Once you've installed the JavaScript Client SDK and [have a `conversation` object](/client-sdk/in-app-messaging/guides/simple-conversation/javascript), you can call `sendCustomEvent` to add a custom event to the conversation.

```javascript
conversation.sendCustomEvent({ type: 'my_custom_event', body: { your: 'data' }}).then((custom_event) => {
  console.log(custom_event);
});
```

## Listening to custom events
In addition to adding custom events to the conversation, you can listen for custom events using the Client SDK. Register an event handler that listens for your custom event name:

```javascript
conversation.on('my_custom_event', (from, event) => {
  console.log(event.body);
});
```

## Complete example

Here's an example application that registers a listener for `my_custom_event`, then emits that event:

> Make sure to replace `YOUR_JWT` and `YOUR_CONVERSATION_ID` with the relevant values.

```javascript
<script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
<script>
  (async function() {
    let nexmo = new NexmoClient();
    let app = await nexmo.login(YOUR_JWT);
    let c = await app.getConversation(YOUR_CONVERSATION_ID);

    c.on('my_custom_event', (from, event) => {
        console.log(event.body);
    });

    c.sendCustomEvent({ type: 'my_custom_event', body: { your: 'data' }}).then((custom_event) => {
        console.log(custom_event);
    });
  })();
</script>
```

## Troubleshooting
<div class="Vlt-callout Vlt-callout--warning">
	<i></i>
	<div class="Vlt-callout__content">
		<h4>Object is missing self (me)</h4>
		<p>If you receive an error that states <code>Object is missing self (me)</code>, ensure that the user you're authenticating as is a member of the conversation</p>
	</div>
</div>
