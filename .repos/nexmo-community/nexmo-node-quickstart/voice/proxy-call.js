/* Voice Tutorial 4: Making a Proxy Call
   API Reference: https://docs.nexmo.com/voice/voice-api/api-reference
 */

'use strict';
require('dotenv').config({path: __dirname + '/../.env'});
const app = require('express')();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const NEXMO_FROM_NUMBER = process.env.NEXMO_FROM_NUMBER;
const NEXMO_TO_NUMBER = process.env.NEXMO_TO_NUMBER;

const server = app.listen(process.env.PORT || 4004, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});

app.get('/proxy-call', (req, res) => {
  const ncco = [
    {
      'action': 'connect',
      'eventUrl': ['https://18627fc4.ngrok.io/event'],
      'timeout': 45, // the default is 60
      'from': NEXMO_TO_NUMBER,
      'endpoint': [
        {
          'type': 'phone',
          'number': NEXMO_FROM_NUMBER // forwarding to this real number
        }
      ]
    }
  ];
  res.json(ncco);
});

app.post('/event', (req, res) => {
  console.log(req.body);
  res.status(204).end();
});
