Code | Error Text | Meaning
-- | -- | --
`0` | Success | The request was successfully accepted by Nexmo.
`1` | Throttled | You are trying to send more than the maximum of 30 requests-per-second.
`2` | Your request is incomplete and missing the mandatory parameter: `$parameter` | A parameter is missing.
`3` | Invalid value for parameter: `$parameter` | Invalid value for parameter. If you see Facility not allowed in the error text, check that you are using the correct Base URL in your request.
`4` | Invalid credentials were provided | The `api_key` or `api_secret` you supplied in the request is either invalid or disabled.
`5` | Internal Error | An error occurred processing this request in the Cloud Communications Platform.
`6` | The Nexmo platform was unable to process this message for the following reason: `$reason` | The request could not be routed.
`7` | The number you are trying to verify is blacklisted for verification | As error text.
`8` | The `api_key` you supplied is for an account that has been barred from submitting messages | As error text.
`9` | Partner quota exceeded | Your account does not have sufficient credit to process this request.
`10` | Concurrent verifications to the same number are not allowed | As error text.
`15` | The destination number is not in a supported network | The request has been rejected.
`16` | The code inserted does not match the expected value | As error text.
`17` | The wrong code was provided too many times | You can run Verify Check on a Verify `request_id` up to three times unless a new PIN code is generated. If you check a request more than 3 times, it is set to FAILED and you cannot check it again.
`18` | Too many `request_ids` provided | You added more than the maximum of 10 `request_ids` to your request.
`19` | No more events are left to execute for the request | As error text.
`101` | No response found | There are no matching Verify request.
