const app = require('express')()
const bodyParser = require('body-parser')

app.use(bodyParser.json())

const onInboundCall = (request, response) => {
  const ncco = [
    {
      action: 'talk',
      text: 'Please leave a message after the tone, then press pound.'
    },
    {
      action: 'record',
      endOnKey : '#',
      beepStart: 'true',
      eventUrl: [
        `${request.protocol}://${request.get('host')}/webhooks/recording`
      ]
    },
    {
      action: 'talk',
      text: 'Thank you for your message.'
    }
  ]

  response.json(ncco)
}

const onRecording = (request, response) => {
  const recording_url = request.body.recording_url
  console.log(`Recording URL = ${recording_url}`)

  response.status(204).send()
}

app
  .get('/webhooks/answer', onInboundCall)
  .post('/webhooks/recording', onRecording)

app.listen(3000)
