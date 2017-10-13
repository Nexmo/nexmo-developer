'use strict';

const app = require('express')();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const server = app.listen(process.env.PORT || 4001, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});

app.get('/answer', (req, res) => {
  let from = req.query.from;
  let to = req.query.to;

  const ncco = [
    {
      "action": "connect",
      "timeout": 5,
      "from": from,
      "eventType": "synchronous",
      "endpoint": [
        {
          "type": "sip",
          "uri": "sip:12065551212@sip.example.com"
        }
      ]
    }
  ];

  res.json(ncco);
});

app.post('/event', (req, res) => {
  console.log(req.body);
  var fallbackEvents=['timeout','failed','unanswered','busy','rejected'];
  if (fallbackEvents.indexOf(req.body.status)>-1) {
    const ncco = [
      {
        "action": "connect",
        "timeout": 60,
        "from": req.body.from,
        "eventType": "synchronous",
        "endpoint": [
          {
            "type": "phone",
            "number": "+12065551212"
          }
        ]
      }
    ];
    res.json(ncco);
  }
  else res.status(204).end();
});