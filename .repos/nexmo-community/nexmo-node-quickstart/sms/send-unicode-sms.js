require('dotenv').config({path: __dirname + '/../.env'})

const NEXMO_API_KEY = process.env.NEXMO_API_KEY
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET
const TO_NUMBER = process.env.TO_NUMBER

const Nexmo = require('nexmo')

const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
})

const from = 'Acme Inc'
const to = TO_NUMBER
const text = 'こんにちは世界'
const opts = {
  "type": "unicode"
}

nexmo.message.sendSms(from, to, text, opts, function(){})
