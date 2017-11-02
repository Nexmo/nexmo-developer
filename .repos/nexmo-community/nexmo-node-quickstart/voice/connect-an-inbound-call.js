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

app
  .get('/webhooks/answer', onInboundCall)
  .post('/webhooks/answer', onInboundCall)

app.listen(3000)
