---
title: Create the event webhook
description: Listen for call progress events
---

# Create the event webhook

Finally, you need to create the event webhook to receive call progress events and output them to the console.

Add the following route below your `/webhooks/dtmf` route:

```javascript
app.post('/webhooks/events', (req, res) => {
	console.log(req.body);
	res.sendStatus(204);
});
```

> **Note**: This route returns `HTTP 204 No Content` to acknowledge receipt of the data to the Vonage API platform and prevent it from making multiple requests to the webhook with the same event data.
