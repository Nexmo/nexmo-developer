---
title: Display the home page
description: Show the home page and the user's authentication status
---

# Display the home page

In the `/` route, you want to check if a session already exists. If not, you prompt the user to verify their account details using their mobile number before they are allowed to continue.

After being authenticated, a session object will be created and you can use this to retrieve and display the user's mobile number.

Enter the following code in the `/` route handler:

```javascript
app.get('/', (req, res) => {
	if (!req.session.user) {
		res.render('index', {
			brand: NEXMO_BRAND_NAME,
		});
	} else {
		res.render('index', {
			number: req.session.user.number,
			brand: NEXMO_BRAND_NAME,
		});
	}
});
```

Run the following command:

```sh
node server.js
```

Visit `http://localhost:3000` in your browser and make sure that the page appears correctly:

![The home page](/images/tutorials/verify-stepup-auth-home-page.png)

Also ensure that when you click the "Verify me" button, you are redirected to a page where you can enter your mobile number:

![The enter code page](/images/tutorials/verify-stepup-auth-enter-number-page.png)

Although you can enter your number here, you still won't receive a verification code. You'll implement that functionality in the next step!




