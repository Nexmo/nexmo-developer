---
title:  Initialize your dependencies
description:  Load the modules that your application will use

---

Initialize your dependencies
============================

In `server.js`, write the following code to initialize dependencies and define some variables which you will use to configure your application:

```javascript
require('dotenv').config();

const path = require('path')
const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const app = express();
const Nexmo = require('nexmo');

const VONAGE_API_KEY = process.env.VONAGE_API_KEY;
const VONAGE_API_SECRET = process.env.VONAGE_API_SECRET;
const VONAGE_BRAND_NAME = process.env.VONAGE_BRAND_NAME;

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

// Define your routes here

// Run the web server
const server = app.listen(3000, () => {
    console.log(`Server running on port ${server.address().port}`);
});
```

