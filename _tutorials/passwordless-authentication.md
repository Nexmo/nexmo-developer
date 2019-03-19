---
title: Passwordless authentication
products: verify
description: Use the Verify API to log a user into an application with just their phone number instead of a password.
languages:
    - Node
---
# Passwordless Authentication

Passwords can be hard to remember and insecure. By implementing passwordless login with the Verify API, you can replace passwords with single-use codes delivered to your user's mobile phone by SMS or a voice call. 

This tutorial is based on the [Passwordless Authentication](https://www.nexmo.com/use-cases/passwordless-authentication/) use case. You can [download the source code](https://github.com/nexmo-community/node-passwordless-login) from GitHub.

## In this tutorial

We will build a simple application that uses Node.js and the Nexmo Verify API to authenticate a user without requiring them to use a password.

The following sections explain the code in this tutorial. They show you how to:

* [Create the basic web application](#create-the-basic-web-application) - create the basic web application and login page
* [Collect the user's phone number](#collect-the-user-s-phone-number) - add a form to collect the user's phone number
* [Send the verification request](#send-the-verification-request) - create a verification request to send a verification code to the user's phone number
* [Collect the verification code](#collect-the-verification-code) - add a form to collect the verification code from the user
* [Check the verification code](#check-the-verification-code) - determine if the code that the user provided is valid and, if so, log them in

## Prerequisites

To work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up).
* The [source code](https://github.com/nexmo-community/node-passwordless-login) from GitHub. Installation instructions are in the [README](https://github.com/nexmo-community/node-passwordless-login/blob/master/README.md).

## Create the basic web application

The application uses the [Express](https://expressjs.com/) framework for routing and the [pug](https://www.npmjs.com/package/pug) templating system for building the UI.

### Initialize dependencies

In addition to `express` and `pug`, we will use the following external modules:

* `express-session` - to manage the login state of the user
* `body-parser` - to parse `POST` requests
* `dotenv` - to store your Nexmo API key and secret and the name of your application in a `.env` file

We initialize the dependencies and start the web server in `server.js`: 

```javascript
require('dotenv').load();

const path = require('path')
const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const app = express();
const Nexmo = require('nexmo');

const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;
const NEXMO_BRAND_NAME = process.env.NEXMO_BRAND_NAME;

let verifyRequestId = null;
let verifyRequestNumber = null;

// Location of the application's CSS files
app.use(express.static('public'));

// The session object we will use to manage the user's login state
app.use(session({
    secret: 'loadsofrandomstuff',
    resave: false,
    saveUninitialized: true
}));

app.use(bodyParser.urlencoded({ extended: true }));

// For templating
app.set('view engine', 'pug');

// Run the web server
const server = app.listen(3000, () => {
    console.log(`Server running on port ${server.address().port}`);
});
```

### Define the routes

We will use the following routes in our application:

* `/` - the home page, where we will check if a user is logged in or not.
* `/login` - to display a page (`login.html`) where the user can enter their phone number
* `/verify` - when the user has entered their phone number, we redirect here to create a [verify request](/api/verify#verify-request) to start the verification process and display a page (`entercode.html`) where they can enter the code that they receive
* `/check-code` - when the user has entered the verification code we will perform a [check request](/api/verify#verify-check) to determine if the code that they entered is the one that they were sent. We return them to the home page where they will either be logged in (check successful) or prompted to log in again (check unsuccessful).
* `/logout` - to delete the user's session details and send them back to the home page

```javascript
app.get('/', (req, res) => {
    /*
        If there is a session for the user, the `index.html`
        page will display the number that was used to log
        in. If not, it will prompt them to log in.
    */
});

app.get('/login', (req, res) => {
    // Display the login page
    res.render('login');
});

app.post('/verify', (req, res) => {
    // Start the verification process

    /* 
        Redirect to page where the user can 
        enter the code that they received
     */
    res.render('entercode');
});

app.post('/check-code', (req, res) => {
    // Check the code provided by the user
});

app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/');
});
```

### Display the login page

In the `/` route, you want to provide the `index.html` page with the user's login details (if the user is logged in) and the brand name for the application that you specified in the `.env` file, for example:

```
NEXMO_API_KEY=
NEXMO_API_SECRET=
NEXMO_BRAND_NAME=Acme Inc
```

Code the `/` route handler as shown below:

```javascript
app.get('/', (req, res) => {
    /*
        If there is a session for the user, the `index.html`
        page will display the number that was used to log
        in. If not, it will prompt them to log in.
    */
    if (!req.session.user) {
        res.render('index', {
            brand: NEXMO_BRAND_NAME
        });
    }
    else {
        res.render('index', {
            number: req.session.user.number,
            brand: NEXMO_BRAND_NAME
        });
    }
});
```

This populates the `index.html` page using the variable interpolation and conditional processing provided by the `pug` tempating library.

In the HTML you display the user's phone number and:

* If the user is already logged in, show the number that they are logged in as and a logout button.
* If not, show a login button that redirects to the `/login` route.

```jade
extends layout.pug

block content
    h1 Welcome to #{brand}!
    if number
        p You are logged in using number: #{number}
        a(href="logout")
            button.ghost-button(type="button") Logout
    else
        p Please log in to continue
        a(href="login")
            button.ghost-button(type="button") Login
```

## Collect the user's phone number

When your user clicks the login button on your homepage, redirect to the `/login` route and show them the form where they can enter their number:

```javascript
app.get('/login', (req, res) => {
    // Display the login page
    res.render('login');
});
```

The `login.html` page is generated from the `login.pug` file:

```jade
extends layout.pug

block content
    h1 Log in: Step 1
    fieldset
        form(action='/verify', method='post')
            input.ghost-input(name='number', type='text', placeholder='Enter your mobile number', required='')
            input.ghost-button(type='submit', value='Get Verification Code')
```

> Note: The application expects the phone number your users provide to be in [E.164](/voice/voice-api/guides/numbers) format that includes the country prefix. In a production application you would probably want to format local numbers for them. You can do this using the [Number Insight API](/number-insight/code-snippets/number-insight-basic).

When the user has submitted this form, your application redirects to the `/verify` route where you will send a verification request using the Nexmo Verify API.

## Send the verification request

The [verify request](/api/verify#verify-request) starts the verification process by generating a verification code to send to the user. The first one is sent by SMS. If the user fails to respond within a [specified time period](/verify/guides/verification-events#timing-of-each-event) then the API makes a second and, if necessary, third attempt to deliver the PIN code using a voice call.

To send the verification request, use the [nexmo-node](https://github.com/Nexmo/nexmo-node) REST API client library to your application. Add the following to `server.js`:

```javascript
const nexmo = new Nexmo({
    apiKey: NEXMO_API_KEY,
    apiSecret: NEXMO_API_SECRET
}, {
        debug: true
    });
```

You must configure your [API key and secret](https://dashboard.nexmo.com/settings) in the `.env` file in order to initialize the `nexmo` library:

```
NEXMO_API_KEY=YOUR_NEXMO_API_KEY
NEXMO_API_SECRET=YOUR_NEXMO_API_SECRET
NEXMO_BRAND_NAME=Acme Inc
```

> **Note**: Nexmo recommends that you always store your API credentials in environment variables.

You can then send the verification code to your user in the `/verify` route by making a [verify request](/api/verify#verify-request) to the Verify API:

```javascript
app.post('/verify', (req, res) => {
    // Start the verification process
    verifyRequestNumber = req.body.number;
    nexmo.verify.request({
        number: verifyRequestNumber,
        brand: NEXMO_BRAND_NAME
    }, (err, result) => {
        if (err) {
            console.error(err);
        } else {
            verifyRequestId = result.request_id;
            console.log(`request_id: ${verifyRequestId}`);
        }
    });
    /* 
        Redirect to page where the user can 
        enter the code that they received
     */
    res.render('entercode');
});
```

We store the user's phone number and the `request_id` that the call to the Verify API returns. We will need the `request_id` to check the code that the user enters into our application. We will display the phone number on the home page if the user logs in successfully.

## Collect the verification code

When the user receives the verification code they enter it using the form provided in `entercode.html`:

```jade
extends layout.pug

block content
    h1 Log in: Step 2
    fieldset
        form(action='/check-code', method='post')
            input.ghost-input(name='code', type='text', placeholder='Enter your verification code', required='')
            input.ghost-button(type='submit', value='Verify me!')
```


## Check the verification code

To verify the code submitted by the user you make a [verify check](/api/verify#verify-check) request. You pass in the `request_id` (which we stored in the `/verify` route handler) and the code provided.

The response from the Verify API check request tells you if the user entered the correct code. If the `status` is `0`, log the user in by creating a `user` session object with a `number` property for display on the home page:

```javascript
app.post('/check-code', (req, res) => {
    // Check the code provided by the user
    nexmo.verify.check({
        request_id: verifyRequestId,
        code: req.body.code
    }, (err, result) => {
        if (err) {
            console.error(err);
        } else {
            if (result.status == 0) {
                /* 
                    User provided correct code,
                    so create a session for that user
                */
                req.session.user = {
                    number: verifyRequestNumber
                }
            }
        }
        // Redirect to the home page
        res.redirect('/');
    });
});
```

## Conclusion

You can now log a user into your web application without a password using just their phone number. To achieve this you collected their phone number, used the Verify API to send the user a code, collected this code from the user and sent it back to the Verify API to check.

## Resources

* [Code on GitHub](https://github.com/nexmo-community/node-passwordless-login) - all the code from this application
* [Verify API reference](/api/verify) - detailed API documentation for the Verify API
* [Passwordless authentication use case](https://www.nexmo.com/use-cases/passwordless-authentication/) - upon which this tutorial is based
* [Number Insight API](/number-insight/overview) - if you want to ensure that user-provided phone numbers are in the correct international format that the Verify API requires

