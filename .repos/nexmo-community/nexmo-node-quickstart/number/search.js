require('dotenv').config({path: __dirname + '/../.env'});

var NEXMO_API_KEY = process.env.NEXMO_API_KEY;
var NEXMO_API_SECRET = process.env.NEXMO_API_SECRET;

var Nexmo = require('nexmo');

var nexmo = new Nexmo({apiKey: NEXMO_API_KEY, apiSecret: NEXMO_API_SECRET}, {debug: true});

nexmo.number.search('GB', {features: 'SMS'}, function(err, res) {
  if(err) {
    console.error(err)
  }
  else {
    console.log(res);
    console.log(res.numbers[0].features);
    
    var numbers = res.numbers;
    // do something with numbers
  }
});
