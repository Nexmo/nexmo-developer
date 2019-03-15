require('dotenv').config({path: __dirname + '/../.env'});
const VBC_EXTENSION = process.env.VBC_EXTENSION;

const app = require('express')()

const onInboundCall = (request, response) => {
  const ncco = [{
    action: 'connect',
    endpoint: [{
      type: 'vbc',
      extension: VBC_EXTENSION
    }]
  }]

  response.json(ncco)
}

app.get('/webhooks/answer', onInboundCall)

app.listen(3000)
