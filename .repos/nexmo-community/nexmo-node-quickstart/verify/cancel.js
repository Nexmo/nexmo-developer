require('dotenv').config({path: __dirname + '/../.env'});

var NEXMO_API_KEY = process.env.NEXMO_API_KEY;
var NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;

var REQUEST_ID = process.argv[2];
if(!REQUEST_ID) {
  console.error('Please supply a single argument for the `request_id`');
  return;
}

var Nexmo = require('nexmo');
var nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
}, {
  debug:true
});

nexmo.verify.control({request_id: REQUEST_ID, cmd: 'cancel'}, function(err, result) {
  if(err) { console.error(err); }
  else {
    console.log(result);
  }
});
