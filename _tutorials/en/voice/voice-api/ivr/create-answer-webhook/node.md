---
title: Create the answer webhook
description: Answer an incoming call on your Vonage number
---

# Create the answer webhook

When your Vonage number receives a call, the Vonage API platform makes a request to your answer URL webhook endpoint. The webhook must return an NCCO, which is a JSON array of objects. Each object in the array consists of an `action` that determines how the call should progress.

> **Note**: Find out more about NCCOs [here](/voice/voice-api/ncco-reference)

In this step you will build that webhook. Add the following handler for the `/webhooks/answer` route:

```javascript
app.get('/webhooks/answer', (req, res) => {
	res.json(mainMenu(req));
});
```

Beneath it, write the code for the `mainMenu` function, which creates and returns an NCCO. We have wrapped the code that generates the NCCO in a function so that we can call it from elsewhere in our application, and not only from our answer webhook:

```javascript
function mainMenu (req) {
	return [
		{
			action: 'talk',
			bargeIn: true,
			text:
				'Welcome. Press 1 to hear the current date or 2 to play audio. Press any other key to hear these options again.',
		},
		{
			action: 'input',
      type: [ 'dtmf' ],
      dtmf: {
        maxDigits: 1,  
      },
			eventUrl: [ `${req.protocol}://${req.get('host')}/webhooks/dtmf` ],
		},
	];
}
```

The NCCO this function generates consists of two actions:

* `talk` reads the menu options to the caller using text-to-speech. The `bargeIn` property is set to `true`, which enables a user to interrupt the reading of the message
* `input` waits for the user to press a key on the phone's keypad and then makes a request to another webhook (defined in `eventUrl`) with the details of the key they pressed. You will create this webhook in the next step.

