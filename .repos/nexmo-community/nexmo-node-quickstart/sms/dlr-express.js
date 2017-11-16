const app = require('express')()
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

app
  .route('/webhooks/delivery-receipt')
  .get(handleDeliveryReceipt)
  .post(handleDeliveryReceipt)

function handleDeliveryReceipt(request, response) {
  const params = Object.assign(request.query, request.body)
  console.log(params)
  response.status(204).send()
}

app.listen(3000)
