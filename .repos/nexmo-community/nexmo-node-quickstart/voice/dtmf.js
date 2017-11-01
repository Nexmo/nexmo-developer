const app = require('express')()
const bodyParser = require('body-parser')

app.use(bodyParser.json())

const onInboundCall = (request, response) => {
  const ncco = [
    {
      action: 'talk',
      text: 'Please enter a digit'
    },
    {
      action: 'input'
    }
  ]

  response.json(ncco)
}

const onEvent = (request, response) => {
  const dtmf = request.query.dtmf || request.body.dtmf

  if (!dtmf) {
    return response.status(204).send()
  }

  const ncco = [{
    action: 'talk',
    text: `You pressed ${dtmf}`
  }]

  response.json(ncco)
}

app
  .get('/webhooks/answer', onInboundCall)
  .post('/webhooks/answer', onInboundCall)
  .get('/webhooks/event', onEvent)
  .post('/webhooks/event', onEvent)

app.listen(3000)
