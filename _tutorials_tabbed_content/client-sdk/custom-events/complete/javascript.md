---
title: Javascript
language: javascript
menu_weight: 1
---

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

