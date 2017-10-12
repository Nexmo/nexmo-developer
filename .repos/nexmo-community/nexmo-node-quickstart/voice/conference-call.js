'use strict';

require('dotenv').config({path: __dirname + '/../.env'});

const NEXMO_FROM_NUMBER = process.env.NEXMO_FROM_NUMBER;
const NEXMO_TO_NUMBER = process.env.NEXMO_TO_NUMBER;

const app = require('express')();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/answer', (req, res) => {
  const ncco = [
    {
      action: 'talk',
      text: 'Welcome to a Nexmo powered conference call'
    },
    {
      action: 'conversation',
      name: 'nexmo-conference'
    }
  ];
  res.json(ncco);
});

app.post('/events', (req, res) => {
  console.log(req.body);
  res.status(204).end();
});

const server = app.listen(process.env.PORT || 4004, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});