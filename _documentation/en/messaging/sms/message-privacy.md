---
title: Message Privacy
---

# Message Privacy

Vonage's Auto-redact feature enables customers to protect their SMS privacy by replacing all Personally Identifiable Information (PII) in Vonage logs with the string "REDACTED". Auto-redact is automatic and is suitable for cases when you don't want sensitive customer information, like SMS message content, to end up in Vonage logs.

In general, businesses dealing with industries and sectors that are highly regulated, such as financial services, public authorities, educational institutions, hospitals, and the police need to safeguard sensitive data to comply with data protection laws and regulations.

## How does Auto-redact work?

Redaction is the editing of a document or a record to delete or mask Personally Identifiable Information (PII) or confidential information. For example, your telephone number, bank details, or your address.

When you send SMS messages using the Vonage SMS API, two pieces of PII get recorded: the SMS message body content and the receiver's phone number. When you use Vonage SMS API to receive SMS, we record the SMS message body content and the sender's phone number.

This sensitive PII ends up in two places: server logs and transactional records of the activity. Server logs are retained for around 15 days, no more than one month. Transactional records of the activity, however, are stored for 13 months. Transactional records of the activity are known as Call Detail Records (CDRs). Both server logs and CDRs can be viewed by Vonage support staff, for testing, debugging, diagnosing user issues and reconciling CDRs against customers' transaction records.

The image below shows an example of the flow of Advanced SMS Auto-redact with Vonage.

![Advanced SMS Redaction](/assets/images/messaging/sms/advanced_sms_redaction.png)

**Note**: Advanced Auto-redact works only for messages sent using the Vonage SMS API. For messages received using the Vonage SMS API, we can offer the Standard Auto-redact feature. For more information on the Standard Auto-redact please refer to the [Redact API documentation](/redact/overview).

Advanced Auto-redact feature ensures that the message content (SMS text) is redacted before it is written to the server logs and CDRs. The phone number cannot be immediately redacted in the server logs due to data retention regulations, thus we provide an option to encrypt it.

The redaction options available are:

1. Message content redaction only.
2. Phone number redaction only (implies encryption of phone numbers in the server logs and redaction in the long-term storage).
3. Phone number encryption only.
4. Message content redaction combined with either redaction or encryption of the phone number.

A key point of Vonage's immediate Advanced Auto-redact is that the message body is not stored in any of the logs or the CDRs. Phone numbers are also immediately encrypted, with an encryption key that Vonage staff do not have access to. Those encrypted numbers get then redacted in the CDRs, which are stored for 13 months, and the server logs, which are stored for between 15 and 30 days after creation. Please refer to the (Redaction page)[https://developer.nexmo.com/redact/overview] for more information.

## How to set up Auto-redact for your Vonage account

If you wish to activate the Advanced Auto-redact service for your account, please complete the form on [this page](https://info.nexmo.com/RedactAPI.html).

You can find pricing relevant to the Advanced Auto-redact service on the [Vonage pricing](https://www.vonage.com/communications-apis/pricing/) page.
