---
title: via npm
---

### Install the Client SDK package

Install the Client SDK using `npm`:

```
npm install nexmo-client -s
```

### Import the Client SDK into your code

If your application is using ES6 module syntax, you can import the client module near the top of your application code:

```
import NexmoClient from 'nexmo-client';
```

If your application will run on a single page, you can load the module in your HTML using a script tag:

```
<script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
```

Be sure to check that the path to `nexmoClient.js` is correct for your project structure.

