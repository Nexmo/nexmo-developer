---
title: Create the server
description: Initialize your dependencies and run the server
---

# Create the server

In this step, you will initialize your dependencies and create a server that listens to incoming requests.

Create a file called `index.js` in your `phone-ivr` directory and populate it with the following code:

```javascript
const app = require('express')();
const bodyParser = require('body-parser');

app.use(bodyParser.json());

app.get('/', (req, res) => {
	res.send("I'm listening!");
});

app.listen(3000);
```

Run your application using `node index.js` and visit `http://localhost:3000` in your browser. If everything is working correctly you should see the "I'm listening!" message.
