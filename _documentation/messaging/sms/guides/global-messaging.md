---
title: Global messaging
---

# Global messaging

Countries have different technical standards and restrictions around the [SMS] standard. Nexmo sends the message you give us to the phone number you designate cheaply and efficiently. Before you start your messaging campaign you need to plan for:

- [Encoding](#encoding) - set the correct encoding so your users can read your message clearly.
- [Concatenation](#concatenation) - check the length of the message in relation to the character set and send the minimum number of SMS.
- [Custom senderIDs](#custom-senderid) - can you use your company brand for each message or must it be a virtual number, a short code or a random number?
- [Delivery receipts](#delivery-receipts) - check if the country you are sending to will correctly validate that each message is delivered.
- [Country specific features](#country-specific-features) - a comprehensive list of the sms features available internationally.


## Encoding

By default all text SMS sent by Nexmo are in UTF-8 with URL encoding. A message saying `Hello World`, [`Bonjour le monde`](lang: 'fr') or [`Hola mundo`](lang: 'es') is delivered seamlessly.

However, sending [`Привет мир`](lajng: 'ru'), [`שלום עולם`](lang: 'he') or [`مرحبا بالعالم`](lang: 'ar') requires more thought. Languages such as Arabic, Chinese, Korean, Japanese, or Cyrillic alphabet languages need the 16-bit characters available in unicode. You can also send messages in binary, wappush, vcal and vcard formats.

### Maximum number of characters

The maximum number of characters you can fit into a single message depends on the encoding you are using:

* 7-bit encoding such as latin-1/9 and GSM8 - 160 characters.

    ```
    But, soft! what light through yonder window breaks?
    It is the east, and Juliet is the sun.
    Arise, fair sun, and kill the envious moon,
    Who is already sick and
    ```
  > Note: the [GSM alphabet] contains an extended alphabet. Characters in the extended alphabet are escaped and use up 2 characters *escape character + character* For example, `£` or `€` are sent as `\£` or `\€`.

* 8-bit encoding for binary - 140 characters.

    ```
    But, soft! what light through yonder window breaks?
    It is the east, and Juliet is the sun.
    Arise, fair sun, and kill the envious moon,
    Who
    ```

* 16-bit encoding for unicode - 70 characters.

    ```
    But, soft! what light through yonder window breaks?
    It is the east, and
    ```

If you use [SMPP](/messaging/sms/guides/SMPP-access) rather than REST, the default character encoding is Latin 1 ([ISO-8859-1]). Binary and unicode are supported following the [SMPP 3.4] specification. You change the encoding of messages sent using SMPP in the `API settings` in [Dashboard](https://dashboard.nexmo.com). Changes take effect after an SMPP rebind.

Before you start your messaging campaign:

1. Check the format to send your message in. You can see the full UTF-8 character set [here](http://www.fileformat.info/info/charset/UTF-8/list.htm):

    Use <http://www.url-encode-decode.com/> to see if your message can be URL encoded. If you need to use another format, set the *type* parameter in your [request](/api/sms#request).

2. If you need to use unicode, check if unicode is supported in the country you are sending to [Country Specific Features](#country-specific-features).

3. For messages where you have not set [type](/api/sms#parameters) to `text`, check that your user's handset supports the format. For example, a US handset may not display Arabic.

## Concatenation

If you send a message that contains more than the maximum number of characters for your encoding, Nexmo sends a concatenated SMS. A concatenated SMS contains multiple SMS parts that are connected by segmentation information in the User Data Header (UDH). Segmentation information tells the handset the number of messages that make up the concatenated SMS, and the position of each SMS part in the concatenated SMS. The parts of a concatenated SMS arrive at the user's handset out of sequence. When the handset has received all the SMS parts, it presents your message as a single text to your user.

Segmentation information takes up 8 bytes of the message body for each SMS part. The maximum number of characters in the message body for each SMS part in a concatenated SMS is:

* 7-bit encoding such as latin-1/9 and GSM8 - 152 characters.
* 8-bit encoding for binary - 134 characters.
* 16-bit encoding for unicode - 62 characters.

You can send a message of up to 3200 characters in your request to the SMS API. Best practice is that the message in the text parameter is no longer than 6 SMS parts. For example, to send the first stanza of the balcony speech in Chinese, Nexmo would send a concatenated SMS with the following SMS parts:

```tabbed_examples
source: '_examples/messaging/chinese-parts'
```

You are charged for each SMS sent as part of a concatenated SMS.

If you rent one or more virtual numbers from Nexmo, inbound SMS to that number are sent to your webhook endpoint using either GET or POST. Inbound messages comply with the SMS format. If an SMS sent to your virtual number is longer than the [maximum number of characters](#maximum-number-of-characters) for an individual SMS, you should receive the concatenated message in SMS parts. Use the `concat-ref`, `concat-total` and `concat-part` parameters to reassemble the parts into the message. However, you can only receive inbound concatenated SMS if the carrier your user is sending through supports them. If the carrier who sent the inbound SMS does not support concatenation, a workaround is to consider messages coming from the same number within a close time period as concatenated.

Before you start your messaging campaign:

1. Check the format to send your message in. You can see the full UTF-8 character set [here](http://www.fileformat.info/info/charset/UTF-8/list.htm):

    Use <http://www.url-encode-decode.com/> to see if your message can be URL encoded. If you need to use another format, set the *type* parameter in your [request](/api/sms#request).

2. If you need to use unicode, check if unicode is supported in the country you are sending to [Country Specific Features](#country-specific-features).

3. Check in the [Country Specific Features](#country-specific-features) if concatenated messages are supported in the country you are sending to. If they are not:

    * Keep your message concise. Calculate the number of characters you can send in a message for your character set.
    * Configure your app for the time period workaround for inbound messages.

## Custom senderID

The senderID is the number or text shown on a handset when it displays a message. You set a custom senderID to better represent your brand. The senderID can be either:
* Numeric - up to a 15 digit telephone number in international format without a leading `+` or `00`
* Alphanumeric - an 11 digit string made up of the following supported characters: `abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`

Using other characters may result in failed delivery or an altered senderID.

However, depending on the jurisdiction one or more of the following can happen:

* Your senderID must be a virtual number.
* SMS filtering is applied and the senderID is modified.
* Numeric-only senderIDs are replaced by short codes.
* You can only send traffic in a limited time window.
* For marketing traffic you have to implement a STOP system.

> Note: [SMS spoofing] is strictly forbidden.

Before you start your messaging campaign:

1. Check the SenderID columns in the [Country Specific Features](#country-specific-features).
2. Batch send your messages to each country and set `from` to match the SenderID capabilities.

## Delivery receipts

When Nexmo sends an SMS to a carrier, the carrier should return a delivery receipt (DLR). Carriers send delivery receipts at a moment of their choice, they do not have to wait for delivery confirmation.

Delivery receipts are either:

* Carrier - returned when the SMS is received by the telecommunications service providers.
* Handset - returned when the message is received on your user's handset.

If your message is longer than a single SMS, carriers should send a DLR for each part of the concatenated SMS. Handset delivery receipts for a concatenated message are delayed. This is because each part of the concatenated message takes about 10 seconds to be processed by the handset.

In practice, some carriers either do not send the delivery receipt or send a fake. Depending on the country you are sending to, Nexmo cannot be 100% certain that a *successfully delivered* delivery receipt means that the message reached your user.

Before you start your messaging campaign:

1. Check the [Country Specific Features](#country-specific-features) for the countries you are sending to.
2. If the country you are sending to does not supply reliable DLRs, use [Conversion API](/messaging/conversion-api/overview) so Nexmo has more data points to ensure the best routing.

## Country specific features

The following table shows the features available in different countries. Click the column header to sort countries by feature:

| Country | Reliable DLR | Alphanumeric | Short code | Your virtual number | Long code | Preregistered | Concatenated SMS | Unicode |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| Australia           | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Brazil              | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| Canada              | ✖ | ✖ | ✔ | ✔ | ✖ | ✖ | ✖ | ✖ |
| Colombia            | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ |
| France              | ✔ | ✔ | ✖ | ✔ | ✖ | ✖ | ✖ | ✖ |
| France (Free)       | ✔ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| Germany             | ✔ | ✔ | ✖ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Iraq                | ✖ | ✔ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| Iraq (Zain)         | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ |
| India               | ✔ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✔ |
| Indonesia           | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| Iran (MCI)          | ✔ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ |
| Iran (MTN)          | ✔ | ✖ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Italy               | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Japan               | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ |
| Kuwait              | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| Mexico              | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| Netherlands         | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Philippines         | ✖ | ✖ | ✖ | ✔ | ✖ | ✔ | ✔ | ✖ |
| Philippines (Globe) | ✖ | ✖ | ✖ | ✔ | ✖ | ✔ | ✔ | ✖ |
| Russia              | ✔ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| Saudi Arabia        | ✔ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| South Africa        | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ |
| Spain               | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Syria               | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ |
| Taiwan              | ✔ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ |
| Thailand            | ✔ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| Turkey              | ✔ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| UAE                 | ✔ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |
| UK                  | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| US                  | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✖ | ✖ |
| Vietnam             | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✔ |

> Note: a long code is a phone number that is tied to a device. That is, a landline or SIM.

[SMS]: https://en.wikipedia.org/wiki/Short_Message_Service
[GSM alphabet]: https://en.wikipedia.org/wiki/GSM_03.38
[ISO-8859-1]: https://en.wikipedia.org/wiki/ISO/IEC_8859-1
[SMPP 3.4]: http://opensmpp.org/specs/smppv34_gsmumts_ig_v10.pdf
[SMS spoofing]: https://en.wikipedia.org/wiki/SMS_spoofing
