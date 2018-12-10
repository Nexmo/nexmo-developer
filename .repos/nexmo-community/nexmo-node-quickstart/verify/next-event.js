require('dotenv').config({
  path: __dirname + '/../.env'
});

const NEXMO_API_KEY = process.env.NEXMO_API_KEY;
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;

const REQUEST_ID = process.argv[2];
if (!REQUEST_ID) {
  console.error('Please supply the `request_id`');
  return;
}

const Nexmo = require('nexmo');
const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
}, {
  debug: true
});

nexmo.verify.control({
  request_id: REQUEST_ID,
  cmd: 'trigger_next_event'
}, (err, result) => {
  if (err) {
    console.error(err);
  } else {
    console.log(result);
  }
});
