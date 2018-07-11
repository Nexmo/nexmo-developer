---
title: Node.js
language: node
menu_weight: 2
---

Install Express by typing: `npm install express`

The code below handles the incoming SMS messages.

```js
var Express = require('express')

let app = Express()

app.get('/incoming-sms', (req, res) => {
  console.log(req.query)
  res.sendStatus(200)
})

app.listen(3000)
```

Store this as `app.js` and run it locally using `node app.js`.
