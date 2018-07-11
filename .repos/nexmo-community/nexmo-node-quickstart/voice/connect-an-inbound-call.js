require('dotenv').config({path: __dirname + '/../.env'});
const NEXMO_TO_NUMBER = process.env.NEXMO_TO_NUMBER;

const app = require('express')()

const onInboundCall = (request, response) => {
  const ncco = [{
    action: 'connect',
    endpoint: [{
      type: 'phone',
      number: NEXMO_TO_NUMBER
    }]
  }]

  response.json(ncco)
}

app.get('/webhooks/answer', onInboundCall)

app.listen(3000)
