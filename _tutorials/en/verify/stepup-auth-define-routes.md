---
title: Define the routes
description: Configure your application's endpoints
---

# Define the routes

You will use the following routes in your application:

* `/` - the home page, where you will determine if a user is authenticated and prompt them to authenticate if not
* `/authenticate` - to display a page where the user can enter their phone number
* `/verify` - when the user has entered their phone number, redirect here to start the verification process and display a page where they can enter the code that they receive
* `/check-code` - when the user has entered the verification code, this endpoint will use the Verify API to check if the code that they entered is the one that they were sent
* `/cancel` - to remove any session details and send the user back to the home page

Create these routes in `server.js`, immediately before the code that initializes and runs the server:

```javascript
app.get('/', (req, res) => {

});

app.get('/authenticate', (req, res) => {
  res.render('authenticate');
});

app.post('/verify', (req, res) => {
	res.render('entercode');
});

app.post('/check-code', (req, res) => {

});

app.get('/cancel', (req, res) => {
	req.session.destroy();
	res.redirect('/');
});
```