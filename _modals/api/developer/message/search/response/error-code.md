Value | Description
-- | --
`0` | Delivered.
`1` | Unknown - either; An unknown error was received from the carrier who tried to send this this message or, depending on the carrier, that `to` is unknown. When you see this error, and `status` is rejected, always check if `to` in your request was valid.
`2` | Absent Subscriber Temporary - this message was not delivered because `to` was temporarily unavailable. For example, the handset used for `to` was out of coverage or switched off. This is a temporary failure, retry later for a positive result.
`3` | Absent Subscriber Permanent - `to` is no longer active, you should remove this phone number from your database.
`4` | Call barred by user - you should remove this phone number from your database. If the user wants to receive messages from you, they need to contact their carrier directly.
`5` | Portability Error - there is an issue after the user has changed carrier for `to`  If the user wants to receive messages from you, they need to contact their carrier directly.
`6` | Anti-Spam Rejection - carriers often apply restrictions that block messages following different criteria. For example, on SenderID or message content.
`7` | Handset Busy - the handset associated with `to` was not available when this message was sent. If `status` is `Failed`  this is a temporary failure; retry later for a positive result. If `status` is `Accepted`  this message has is in the retry scheme and will be resent until it expires in 24-48 hours.
`8` | Network Error - a network failure while sending your message. This is a temporary failure, retry later for a positive result.
`9` | Illegal Number - you tried to send a message to a blacklisted phone number. That is, the user has already sent a STOP opt-out message and no longer wishes to receive messages from you.
`10` | Invalid Message - the message could not be sent because one of the parameters in the message was incorrect. For example, incorrect `type` or `udh`
`11` | Unroutable - the chosen route to send your message is not available. This is because the phone number is either; Currently on an unsupported or  network. On a prepaid or reseller account that could not receive a message sent by `from` To resolve this issue either email us at [support@nexmo.com](mailto:support@nexmo.com) or create a help desk ticket at [https://help.nexmo.com](https://help.nexmo.com).
`12` | Destination unreachable - the message could not be delivered to the phone number.
`13` | Subscriber Age Restriction - the carrier blocked this message because the content is not suitable for `to` based on age restrictions.
`14` | Number Blocked by Carrier - the carrier blocked this message. This could be due to several reasons. For example, `to` s plan does not include SMS or the account is suspended.
`15` | Prepaid - Insufficient funds - `to`’s prepaid account does not have enough credit to receive the message.
`99` | General Error - there is a problem with the chosen route to send your message. To resolve this issue either email us at [support@nexmo.com](mailto:support@nexmo.com) or create a help desk ticket at [https://help.nexmo.com](https://help.nexmo.com).
