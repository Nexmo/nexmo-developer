require('dotenv').config({path: __dirname + '/../.env'});
const YOUR_SECOND_NUMBER = process.env.YOUR_SECOND_NUMBER;

const app = require('express')()

const onInboundCall = (request, response) => {
  const ncco = [{
    action: 'connect',
    endpoint: [{
      type: 'phone',
      number: YOUR_SECOND_NUMBER
    }]
  }]

  response.json(ncco)
}

app.get('/webhooks/answer', onInboundCall)

app.listen(3000)
