## Errors

Nexmo uses error codes to report back when an issue was encountered. Below you can find a full table to error codes:

Code | Text | Meaning
-- | -- | --
`1` | Throttled | You have exceeded the submission capacity allowed on this account. Please wait and retry.
`2` | Missing params | Your request is incomplete and missing some mandatory parameters.
`3` | Invalid params | The value of one or more parameters is invalid.
`4` | Invalid credentials | The `api_key` / `api_secret` you supplied is either invalid or disabled.
`5` | Internal error | There was an error processing your request in the Platform.
`6` | Invalid message | The Platform was unable to process your request. For example, due to an unrecognised prefix for the phone number.
`7` | Number barred | The number you are trying to submit to is blacklisted and may not receive messages.
`8` | Partner account barred | The api_key you supplied is for an account that has been barred from submitting messages.
`9` | Partner quota exceeded | Your pre-paid account does not have sufficient credit to process this message.
`11` | Account not enabled for REST | This account is not provisioned for REST submission, you should use SMPP instead.
`12` | Message too long | The length of `udh` and `body` was greater than 140 octets for a `binary` type SMS request.
`13` | Communication Failed | Message was not submitted because there was a communication failure.
`14` | Invalid Signature | Message was not submitted due to a verification failure in the submitted signature.
`15` | Illegal Sender Address - rejected | Due to local regulations, the SenderID you set in from in the request was not accepted. Please check the Global messaging section.
`16` | Invalid TTL | The value of `ttl` in your request was invalid.
`19` | Facility not allowed | Your request makes use of a facility that is not enabled on your account.
`20` | Invalid Message class | The value of message-class in your request was out of range. `See` https://en.wikipedia.org/wiki/Data_Coding_Scheme.
`23` | Bad callback :: Missing Protocol | You did not include `https` in the URL you set in callback.
`29` | Non White-listed Destination | The phone number you set in to is not in your pre-approved destination list. To send messages to this phone number, add it `using` Dashboard.
`34` | Invalid or Missing Msisdn Param | The phone number you supplied in the `to` parameter of your request was either missing or invalid.

**The following response codes are for 2FA and Campaign Subscription Management only.**

Code | Text
-- | -- | --
`101` | `RESPONSE_INVALID_ACCOUNT_CAMPAIGN`

**The following response codes are for 2FA only.**

Code | Text | Meaning
-- | -- | --
`102` | `RESPONSE_MSISDN_OPTED_OUT_FOR_CAMPAIGN` | You tried to send a message to a destination number that has opted out of your program.

**The following response codes are for Campaign Subscription Management only.**

Code | Text
-- | --
`102` | `RESPONSE_INVALID_CAMPAIGN_SHORTCODE`
`103` | `RESPONSE_INVALID_MSISDN`
