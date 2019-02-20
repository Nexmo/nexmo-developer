require('dotenv').config({path: __dirname + '/../.env'})

const TO_NUMBER = process.env.TO_NUMBER
const NEXMO_NUMBER = process.env.NEXMO_NUMBER

const NEXMO_API_KEY = process.env.NEXMO_API_KEY
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET
const NEXMO_APPLICATION_ID = process.env.NEXMO_APPLICATION_ID
const NEXMO_APPLICATION_PRIVATE_KEY_PATH = __dirname +"/../"+ process.env.NEXMO_APPLICATION_PRIVATE_KEY_PATH

const Nexmo = require('nexmo')

const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET,
  applicationId: NEXMO_APPLICATION_ID,
  privateKey: NEXMO_APPLICATION_PRIVATE_KEY_PATH
})

nexmo.channel.send(
  { "type": "mms", "number": "TO_NUMBER" },
  { "type": "mms", "number": "FROM_NUMBER" },
  {
    "content": {
      "type": "image",
       "image": { "url": "IMG_URL" }
    }
  },
  (err, data) => { console.log(data.message_uuid); }
);
