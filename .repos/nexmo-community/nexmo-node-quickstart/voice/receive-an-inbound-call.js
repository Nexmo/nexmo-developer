const app = require('express')()

const onInboundCall = (request, response) => {
  const from = request.query.from
  const fromSplitIntoCharacters = from.split('').join(' ')

  const ncco = [{
    action: 'talk',
    text: `Thank you for calling from ${fromSplitIntoCharacters}`
  }]

  response.json(ncco)
}

app.get('/webhooks/answer', onInboundCall)

app.listen(3000)
