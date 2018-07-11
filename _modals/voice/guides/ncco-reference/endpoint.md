## `endpoint` Values

### Phone - phone numbers in e.164 format

Value | Description
-- | --
`number` | the phone number to connect to in [E.164](https://en.wikipedia.org/wiki/E.164) format.
`dtmfAnswer` | Set the digits that are sent to the user as soon as the Call is answered. The * and # digits are respected. You create pauses using p. Each pause is 500ms.

### Websocket - the websocket to connect to

Value | Description
-- | --
`uri` | the URI to the websocket you are streaming to.
`content-type` | the internet media type for the audio you are streaming. Possible values are: `audio/l16;rate=16000`
`headers` | a JSON object containing any metadata you want.

### sip - the sip endpoint to connect to

Value | Description
-- | --
`uri` | the SIP URI to the endpoint you are connecting to in the format sip:rebekka@sip.example.com.
