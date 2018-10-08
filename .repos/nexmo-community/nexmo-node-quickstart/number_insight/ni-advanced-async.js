const app = require('express')()
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({
  extended: true
}))

app.post('/webhooks/insight', handleInsight)

function handleInsight(request, response) {
  console.log("params", Object.assign(request.query, request.body))
  response.status(204).send()
}

app.listen(3000)
