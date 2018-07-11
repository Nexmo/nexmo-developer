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
      action: 'input',
      eventUrl: [`${request.protocol}://${request.get('host')}/webhooks/dtmf`]
    }
  ]

  response.json(ncco)
}

const onInput = (request, response) => {
  const dtmf = request.body.dtmf

  const ncco = [{
    action: 'talk',
    text: `You pressed ${dtmf}`
  }]

  response.json(ncco)
}

app
  .get('/webhooks/answer', onInboundCall)
  .post('/webhooks/dtmf', onInput)

app.listen(3000)
