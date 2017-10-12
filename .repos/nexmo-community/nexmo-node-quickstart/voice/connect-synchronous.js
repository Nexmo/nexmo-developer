"use strict";

require('dotenv').config({path: __dirname + '/../.env'});

const NEXMO_FROM_NUMBER = process.env.NEXMO_FROM_NUMBER;
const NEXMO_TO_NUMBER = process.env.NEXMO_TO_NUMBER;
const NEXMO_ALT_NUMBER = process.env.NEXMO_ALT_NUMBER;

const app = require('express')();
const bodyParser = require('body-parser');

app.use(bodyParser.json());
app.set('port', (process.env.PORT || 5000));

app.get('/answer', function (req, res) {

  const serverHost = req.protocol + '://' + req.get('host');

  const ncco = [{
      action: "connect",
      from: NEXMO_FROM_NUMBER,
      timeout: 5,
      eventType: 'synchronous',
      eventUrl: [`${serverHost}/connect-event`],
      endpoint: [{
        type: 'phone',
        number: NEXMO_ALT_NUMBER
      }]
  }];

  console.log('Returning NCCO');
  console.dir(ncco)
  
  res.json(ncco);
  
});

app.post('/connect-event', function(req, res) {
  const ncco = [];
  
  if(req.body.status === 'timeout') {
    // Note: you cannot presently do this
    // ncco.push({
    //   action: 'talk',
    //   text: 'Sorry, the attempt to connect your call timed out.'
    // });
    
    ncco.push({
        action: 'connect',
        from: NEXMO_FROM_NUMBER,
        endpoint: [{
          type: 'phone',
          number: NEXMO_TO_NUMBER
        }]
      });
  }
  
  res.json(ncco);
});

app.post('/events', function(req, res) {
  console.log(req.body);
});

const server = app.listen(process.env.PORT || 4004, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});