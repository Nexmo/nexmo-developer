require('dotenv').config({path: __dirname + '/../.env'})

const NEXMO_API_KEY = process.env.NEXMO_API_KEY
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET

// By default use the command line argument. Otherwise use the environment variable.
const NEXMO_TO_LOOKUP = process.argv[2] || process.env.NEXMO_TO_NUMBER;

const Nexmo = require('nexmo');

const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
});

nexmo.numberInsight.get({level: 'basic', number: NEXMO_TO_LOOKUP}, (error, result) => {
  if(error) {
    console.error(error);
  }
  else {
    console.log(result);
  }
});
