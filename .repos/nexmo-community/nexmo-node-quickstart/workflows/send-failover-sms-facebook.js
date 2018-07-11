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

nexmo.workflow.create("failover", [
  {
    "from": { "type": "messenger", "id": "SENDER_ID" },
    "to": { "type": "messenger", "id": "RECIPIENT_ID" },
    "message": {
      "content": {
        "type": "text",
        "text": "This is a Facebook Messenger message sent from the Workflows API"
      }
    },
    "failover":{
      "expiry_time": 600,
      "condition_status": "read"
    }
  },
  {
    "from": {"type": "sms", "number": "FROM_NUMBER"},
    "to": { "type": "sms", "number": "TO_NUMBER"},
    "message": {
      "content": {
        "type": "text",
        "text": "This is an SMS sent from the Workflows API"
      }
    }
  },
  (err, data) => { console.log(data.workflow_uuid); }
])
