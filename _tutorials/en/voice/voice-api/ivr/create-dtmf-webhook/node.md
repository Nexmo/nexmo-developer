---
title: Create the DTMF webhook
description: Create the webhook that responds to digits pressed on the keypad
---

# Create the DTMF webhook

Create the `/webhooks/dtmf` route by entering the following code beneath your `/webhooks/answer` route:

```javascript
app.post('/webhooks/dtmf', (req, res) => {
	let actions = [];
	let ncco = [];
	switch (req.body.dtmf.digits) {
		case '1':
			actions.push({
				action: 'talk',
				text: `It is ${new Intl.DateTimeFormat(undefined, {
					dateStyle: 'full',
					timeStyle: 'long',
				}).format(Date.now())}`,
			});
			break;
		case '2':
			actions.push({
				action: 'stream',
				streamUrl: [
					'https://nexmo-community.github.io/ncco-examples/assets/voice_api_audio_streaming.mp3',
				],
			});
	}
	ncco = actions.concat(mainMenu(req));

	console.log(ncco);

	res.json(ncco);
});
```

This code examines the request to see which digit the user entered (in `req.body.dtmf`) and adds the appropriate action to the existing NCCO. If the user presses `1`, it adds a `talk` action to read out the current date and time. If the user presses `2`, it plays an audio file into the call using a `stream` action. If the user presses any other key, it is ignored and the function returns the original NCCO with the initial menu choices you defined in the `mainMenu` function.

