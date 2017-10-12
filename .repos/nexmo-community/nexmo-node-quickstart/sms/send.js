require('dotenv').config({path: __dirname + '/../.env'})

const NEXMO_API_KEY = process.env.NEXMO_API_KEY
const NEXMO_API_SECRET = process.env.NEXMO_API_SECRET
const NEXMO_FROM_NUMBER = process.env.NEXMO_FROM_NUMBER

// By default use the command line argument. Otherwise use the environment variable.
const NEXMO_TO_NUMBER = process.argv[2] || process.env.NEXMO_TO_NUMBER

const Nexmo = require('nexmo')

const nexmo = new Nexmo({
  apiKey: NEXMO_API_KEY,
  apiSecret: NEXMO_API_SECRET
})

const from = NEXMO_FROM_NUMBER
const to = NEXMO_TO_NUMBER
const text = 'A text message sent using the Nexmo SMS API'

nexmo.message.sendSms(from, to, text)
