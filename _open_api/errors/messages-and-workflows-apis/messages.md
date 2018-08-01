## Errors

Nexmo uses error codes to report back when an issue was encountered. Below you can find a full table to error codes:

### Asynchronous Errors

Code | Text | Meaning
-- | -- | --
`1000` | Throttled | You have exceeded the submission capacity allowed on this account. Please wait and retry.
`1010` | Missing params | Your request is incomplete and missing some mandatory parameters.
`1020` | Invalid params | The value of one or more parameters is invalid.
`1021` | Invalid tag | The tag value is invalid.
`1022` | Invalid template parameters | Some of the parameters of the template were invalid.
`1030` | Internal error | There was an error processing your request in the Platform.
`1040` | Invalid message | The Platform was unable to process your request. For example, due to an unrecognised prefix for the phone number.
`1050` | Number barred | The number you are trying to submit to is blacklisted and may not receive messages.
`1060` | Partner account barred | The `api_key` you supplied is for an account that has been barred from submitting messages.
`1070` | Partner quota exceeded | Your pre-paid account does not have sufficient credit to process this message.
`1080` | Account not enabled for REST | This account is not provisioned for REST submission, you shoud use SMPP on the SMS API.
`1090` | Message too long | The length of `udh` and `body` was greater than 140 octets for a binary type SMS request.
`1100` | Communication Failed | Message was not submitted because there was a communication failure.
`1110` | Invalid Signature | Message was not submitted due to a verification failure in the submitted signature.
`1120` | Illegal Sender Address - rejected | Due to local regulations, the `SenderID` you set in from in the request was not accepted. Please check the Global messaging section.
`1130` | Invalid TTL | The value of `ttl` in your request was invalid.
`1140` | Facility not allowed | Your request makes use of a facility that is not enabled on your account.
`1150` | Invalid Message class | The value of `message-`class in your request was out of range. See https://en.wikipedia.org/wiki/Data_Coding_Scheme.
`1160` | Non White-listed Destination | The phone number you set in to is not in your pre-approved destination list. To send messages to this phone number, add it using Dashboard.
`1170` | Invalid or Missing Msisdn Param | The phone number you supplied in the to parameter of your request was either missing or invalid.
`1180` | Absent Subscriber Temporary | This message was not delivered because to was temporarily unavailable. For example, the handset used for to was out of coverage or switched off. This is a temporary failure, rety later for a positive result.
`1190` | Absent Subscriber Permanent | `to` is no longer active, You should remove this phone number from your database.
`1200` | Portability Error | There is an issue after the user has changed carrier for to. If the user wants to receive messages from you, they need to contact their carrier directly.
`1210` | Anti-Spam Rejection | Carriers often apply restrictions that block messages following different criteria. For example on SenderID or message content.
`1220` | Handset Busy | The handset associated with to was not available when this message was sent. If status is rejected, this is a temporary failure; retry later for a positive result. If status is submitted, this message has is in the retry scheme and will be resent until it expires in 24-48 hours.
`1230` | Network Error | A network failure while sending your message. This is a temporary failure, retry later for a positive result.
`1240` | Illegal Number | You tried to send a message to a blacklisted phone number. That is, the user has already sent a STOP opt-out message and no longer wishes to receive messages from you.
`1241` | Too many send requests | Too many send requests to phone numbers.
`1250` | Unroutable | The chosen route to send your message is not available. This is because the phone number is either currently on an unsupported network or on a pre-paid or reseller account that could not receive a message sent by from. To resolve this issue either email us at support@nexmo.com or create a helpdesk ticket at https://help.nexmo.com.
`1260` | Destination unreachable | The message could not be delivered to the phone number. If using Viber Service Messages your account might not be enabled for this country.
`1270` | Subscriber Age Restriction | The carrier blocked this message because the content is not suitable for to based on age restrictions.
`1280` | Number Blocked by Carrier | The carrier blocked this message. This could be due to several reasons. For example, to's plan does not include SMS or the account is suspended.
`1290` | Pre-Paid - Insufficent funds | to’s pre-paid account does not have enough credit to receive the message.
`1300` | Not part of the provider network | The number or ID is not a user in the provider network.
`1310` | Not suitable device | The user's device can't receive the message.
`1320` | Message already sent | The message was already sent.
`1330` | Unknown | An unknown error was received from the carrier who tried to send this this message. Depending on the carrier, that to is unknown. When you see this error, and status is rejected, always check if to in your request was valid.
`1340` | Outside of the allowed window | This message is sent outside of allowed response window.
`1350` | Phone matching fee not paid | Requires phone matching access fee to be paid by the the Facebook Page.
`1360` | TTL was activated | TTL was activated, no callbacks and no charge will be issued.
`1370` | Expired access Token | The access token has expired, for Facebook Messenger, the consent has to be periodically given every 90 days. Try to delete and reconnect the Facebook page to Nexmo.
