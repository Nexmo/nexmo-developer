const app = require('express')()
const bodyParser = require('body-parser')

app.use(bodyParser.json())

const onInboundCall = (request, response) => {
  const ncco = [
    {
      action: 'talk',
      text: 'Welcome to a Nexmo powered conference call'
    },
    {
      action: 'conversation',
      name: 'room-name'
    }
  ]

  response.json(ncco)
}

app.get('/webhooks/answer', onInboundCall)

app.listen(3000)
