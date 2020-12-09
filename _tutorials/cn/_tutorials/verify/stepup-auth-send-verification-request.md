---
title:  Send the verification request
description:  Start the verification process with a call to the Verify request endpoint

---

Send the verification request
=============================

Start the verification process by using the [Verify API request endpoint](/api/verify#verifyRequest) to generate a verification code and send it to the user.

Use the Node Server SDK for this. First, instantiate it after the lines of code that read your environment variables from `.env`:

```javascript
const nexmo = new Nexmo(
  {
    apiKey: VONAGE_API_KEY,
		apiSecret: VONAGE_API_SECRET,
	},
	{
		debug: true,
	}
);
```

Then, create the verification request within the `/verify` route handler:

```javascript
app.post('/verify', (req, res) => {
	// Start the verification process
	verifyRequestNumber = req.body.number;
	nexmo.verify.request(
		{
			number: verifyRequestNumber,
			brand: VONAGE_BRAND_NAME,
		},
		(err, result) => {
			if (err) {
				console.error(err);
			} else {
				verifyRequestId = result.request_id;
				console.log(`request_id: ${verifyRequestId}`);
			}
		}
	);
	/* 
    Redirect to page where the user can 
    enter the code that they received
  */
	res.render('entercode');
});
```

> By default, the first verification attempt is sent by SMS. If the user fails to respond within a specified time period then the API makes a second and, if necessary, third attempt to deliver the PIN code using a voice call. You can learn more about the available workflows and customization options [in our guide](/verify/guides/workflows-and-events).

