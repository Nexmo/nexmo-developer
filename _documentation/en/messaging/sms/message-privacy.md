---
title: Message Privacy
---

# Message Privacy

Vonage's Auto-redact feature enables customers to protect their SMS privacy. Auto-redact automatically replaces all Personal Identifiable Information (PII) with the string "REDACTED". The Advanced Auto-redact is an important feature for when you don't want full logs of sensitive customer information in their messages.

Businesses in industries that are highly regulated, such as financial services, education, and the police require redacted content to meet compliance and regulation rules. 

## How does Auto-redact work?

Redaction is the editing of a document or a record to delete or mask Personal Identifiable Information (PII) or confidential information. For example, your telephone number, bank details, or your address.

When you send SMS messages using the Vonage SMS API, two pieces of information containing PII get recorded: sender or receiver's phone number and the message body content.

With Vonage, inbound messages can be auto-redacted with the Standard Auto-redact feature. However, the outbound messages can be Auto-redacted using the Advanced Auto-redact feature found under the Vonage Enterprise Plan.

When a customer sends an SMS through the SMS API, logs get stored in two locations. Server logs get created as are transactional records of the activity known as a Call Detail Record (CDR). Server logs are retained for around 15 days, no more than one month. CDRs, however, are stored for 13 months. Both server logs and CDRs can be viewed by Vonage support staff, for testing, debugging, diagnosing user issues and reconciling CDRs against customer's transaction records.

Advanced Auto-redact feature ensures that the message content is encrypted or redacted or both before the server logs and CDRs are stored. The phone number cannot be redacted in the server logs in order to meet data retention requirements. The configurations available are listed below:

1. Message content redaction only.
2. Phone number redaction only.
3. Phone number encryption only.
4. Message content redaction together with redaction or encryption of the phone number.

However, with immediate Advanced Auto-redact Vonage does not store the message body in any of the logs or the CDRs. Phone numbers are also immediately encrypted, with an encryption key that Vonage staff do not have access to.

The image below shows an example of the flow of Advanced SMS Auto-redact with Vonage.

![Advanced SMS Redaction](/assets/images/messaging/sms/advanced_sms_redaction.png)

## How to set up Auto-redact for your Vonage account

You can find pricing relevant to the Advanced Auto-redact service on the [Vonage pricing](https://www.vonage.com/communications-apis/pricing/) page.

If you wish to activate the Advanced Auto-redact service for your account, please complete the form on [this page](https://info.nexmo.com/RedactAPI.html).



