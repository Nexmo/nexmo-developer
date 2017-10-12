/* Voice Tutorial 3-1: Using Nexmo API to record a call
   This webhook receives a call, and lets the caller leave a message.
   The `record` event receives the URL where the recorded message (mp3) locates.
   The mp3 is saved to local disk using `nexmo.files.save`.
   API Referene: https://docs.nexmo.com/voice/voice-api/api-reference
 */

'use strict';

require('dotenv').config({path: __dirname + '/../.env'});
const Nexmo = require('nexmo');
const appId = 'c6b78717-db0c-4b8b-9723-ee91400137cf'; // Use your App ID, generated with the CLI
const privateKey = require('fs').readFileSync(__dirname + '/private.key');

const nexmo = new Nexmo({
  apiKey: process.env.NEXMO_API_KEY,
  apiSecret: process.env.NEXMO_API_SECRET,
  applicationId: appId,
  privateKey: privateKey
});

const app = require('express')();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const server = app.listen(process.env.PORT || 4002, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});

app.get('/answer', (req, res) => {
  let from = req.query.from;
  let to = req.query.to;

  const ncco = [
    {
      action: 'talk',
      voiceName: 'Jennifer',
      text: 'Hello, you\'ve reached Jennifer. Please leave your name and quick message after the tone, then press pound.'
    },
    {
      'action': 'record',
      'eventUrl': ['https://0522c7a8.ngrok.io/record'],
      'endOnSilence': '3',
      'endOnKey' : '#',
      'beepStart': 'true'
    },
    {
      'action': 'talk',
      'text': 'Thank you for your message. Ciao!'
    }
  ];

  res.json(ncco);
});

// General event endpoint for the Application
app.post('/event', (req, res) => {
  console.log(req.body);
  res.status(204).end();
});

// Record action event endpoint
app.post('/record', (req, res) => {
  console.log('*** Recording... ***');
  console.log(req.body);

  let audioURL = req.body.recording_url;
  let audioFile = audioURL.split('/').pop() + '.mp3';

  nexmo.files.save(audioURL, audioFile, (err, response) => {
    if(response) {console.log('The audio is downloaded: ' + audioFile + '.mp3');}
  });
  res.status(204).end();
});
