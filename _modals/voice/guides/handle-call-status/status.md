# Status Values

Value | Description
-- | --
`started` | Platform has started the call.
`ringing` | the user's handset is ringing.
`answered` | the user has answered your call.
`machine` | Platform detected an answering machine.
`complete` | Platform has terminated this call.
`timeout` | your user did not answer your call with ringing_timer seconds.
`failed` | the call failed to complete
`rejected` | the call was rejected
`unanswered` | the call was not answered
`busy` | the person being called was on another call

When a Call enters a state of `timeout`, `failed`, `rejected`, `unanswered` or `busy` the `event_url` webhook endpoint can optionally return an NCCO to override the current NCCO. See [Connect with fallback NCCO](/voice/guides/ncco-reference).
