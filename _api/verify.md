---
title: Verify API Reference
description: Reference guide for the Verify API.
api: Verify
---

# Verify API Reference

You use the Verify API to Verify that a phone number is valid, reachable, and accessible by your user. You can customise the message used during verification.

The endpoints for the Verify API are:

* [Verify Request](#verify-request): generate and send a PIN to your user. You use the `request_id` in the [response](#rresponse) for the Verify Check.
* [Verify Check](#verify-check): confirm that the PIN you received from your user matches the one sent by Nexmo as a result of your [Verify Request](#verify-request).
* [Verify Search](#verify-search): lookup the status of one or more requests.
* [Verify Control](#verify-control): control the progress of your Verify Requests.

## Verify Request

To use Verify Request you:

* Create a [Request](#request) to send a PIN to your user.
* Check the response codes in the [Response](#response) to ensure that your request was successful.

### Request

```
[GET] https://api.nexmo.com/verify/:format
```

#### Parameters

The following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`format` | The response format. Either `json` or `xml` | Yes
`number` | The mobile or landline phone number to verify. Unless you are setting `country` explicitly, this number must be in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example, `447700900000`. | Yes
`country` | If do not set *number* in international format or you are not sure if *number* is correctly formatted, set `country` with the two-character country code. For example, *GB*, *US*. Verify works out the international phone number for you. | No
`brand` | The name of the company or App you are using Verify for.  This 18 character alphanumeric string is used in the body of Verify message. For example: "Your *brand* PIN is ..". |  Yes
`sender_id` | An 11 character alphanumeric string to specify the SenderID for SMS sent by Verify. Depending on the destination of the phone number you are applying, restrictions may apply. By default, `sender_id` is VERIFY.   |  No
`code_length` |  The length of the PIN. Possible values are 6 or 4 characters. The default value is 4. |  No
`lg` |  By default, the SMS or text-to-speech (TTS) message is generated in the locale that matches the *number*. For example, the text message or TTS message for a 33* number is sent in French. Use this parameter to explicitly control the [language and accent](#language-codes) used for the Verify request. The default language is `en-us`. |  No
`require_type` |  Restrict verification to a certain network type. Possible values are: <ul><li>All (Default)</li><li>Mobile</li><li>Landline</li></ul><br>**Note**: contact [support@nexmo.com](mailto:support@nexmo.com) to enable this feature. |  No
`pin_expiry` |  The PIN validity time from generation. This is an integer value between 60 and 3600 seconds. The default is 300 seconds. When specified together, pin_expiry must be an integer multiple of `next_event_wait`. Otherwise, pin_expiry is set to equal next_event_wait. For example: <ul><li>`pin_expiry` = 360 seconds, so `next_event_wait` = 120 seconds - all three attempts have the same PIN.</li><li>`pin_expiry` = 240 seconds, so `next_event_wait` = 120 seconds - 1st and 2nd attempts have the same PIN, third attempt has a different PIN.</li><li>`pin_expiry` = 120 (or 200 or 400 seconds) - each attempt has a different PIN.</li></ul> |  No
`next_event_wait` |  An integer value between 60 and 900 seconds inclusive that specifies the wait time between attempts to deliver the PIN. Verify calculates the default value based on the average time taken by users to complete verification. |  No

⚓ rresponse
### Response

The following table shows example Responses in JSON or XML:

**JSON**

```json
{
  "request_id":"requestId",
  "status":"status",
  "error_text":"error"
}
```

*or* **XML**

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<verify_response>
    <request_id>requestId</request_id>
    <status>status</status>
    <error_text>error</error_text>
</verify_response>
```

#### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`request_id` | The unique ID of the Verify request you sent. The value of request_id is up to 32 characters long. You use this request_id for the [Verify Check](#verify-check).
`status` | The response code that explains how your request proceeded. (verify_response_codes: somevalue)
`error_text` | If status is not 0, this explains the error encountered.

#### Status values

Status&nbsp;code | Text | Description
--|--|--
0 | Success | The request was successfully accepted by Nexmo.
1 | Throttled | You are trying to send more than the maximum of 30 requests per second.
2 | Your request is incomplete and missing the mandatory parameter: `$parameter` | The stated parameter is missing.
3 | Invalid value for parameter: $parameter | Invalid value for parameter. If you see Facility not allowed in the error text, check that you are using the correct Base URL in your request.
4 | Invalid credentials were provided | The supplied API key or secret in the request is either invalid or disabled.
5 | Internal Error | An error occurred processing this request in the Cloud Communications Platform.
6 | The Nexmo platform was unable to process this message for the following reason: $reason | The request could not be routed.
7 | The number you are trying to verify is blacklisted for verification |
8 | The api_key you supplied is for an account that has been barred from submitting messages |
9 | Partner quota exceeded | Your account does not have sufficient credit to process this request.
10 | Concurrent verifications to the same number are not allowed |
15 | The destination number is not in a supported network | The request has been rejected. You can find more detail about this [on our knowledgebase](https://help.nexmo.com/hc/en-us/articles/360018406532-Verify-On-demand-Service-to-High-Risk-Countries)
16 | The code inserted does not match the expected value |
17 | The wrong code was provided too many times | You can run Verify Check on a `request_id` up to three times unless a new PIN code is generated. If you check a request more than 3 times, it is set to FAILED and you cannot check it again.
18 | Too many request_ids provided | You added more than the maximum of 10 `request_id`s to your request.
19 | No more events are left to execute for the request |
101 | No request found | There are no matching Verify requests.


⚓ check
## Verify Check

To use Verify Check you:

* Use a check [request](#request-2) to send the PIN you received from your user to Nexmo.
* Check the response codes in the [response](#response-2) to see if the PIN sent by your user matched the PIN generated by Nexmo.

⚓ crequest
### Request

```
[GET] https://api.nexmo.com/verify/check/:format
```

#### Parameters

The following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`format` | The response format. Either `json` or `xml`. | Yes
`request_id` | The identifier of the Verify request to check. This is the [request_id](#keys-and-values) you received in the Verify Request [response](#response).  | Yes
`code` | The PIN given by your user. | Yes

⚓ cresponse
### Response

The following table shows example responses in JSON or XML:

**JSON**

```json
{
  "request_id": "aaaaaaaafffffffff0000000099999999",
  "status": "0",
  "event_id": "aaaaaaaafffffffff0000000099999999",
  "price": "0.10000000",
  "currency": "EUR"
}
```

*or* **XML**

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<verify_response>
  <event_id>requestId</event_id>
  <status>status</status>
  <price>price</price>
  <currency> currency</currency>
  <error_text>error</error_text>
</verify_response>
```

#### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`event_id` | The identifier of the [SMS](/api/sms) `message-id`.
`status` | If the value of status is `0`, your user entered the correct PIN. If it is not, check the response code.
`price` | The price charged for this Verify request.
`currency` | Currency code.
`error_text` | If status is not 0, this is brief explanation about the error.


## Verify Search

> <strong>Please note that the Verify Search API is rate limited to one request per second.</strong>

1. Send a Verify Search [request](#request-3) containing the [request_id](#keys-and-values)'s of the Verify requests to search for.
2. Check the *status* response parameter in the Search [Response](#response-4) to see if the request was successfully completed.

⚓ srequest
### Request

```
[GET] https://api.nexmo.com/verify/search/:format
```

#### Parameters

The following table shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`format` | The response format. Either `json` or `xml` | Yes
`request_id` | The [request_id](#keys-and-values) you received in the Verify Request [Response](#rresponse). | ^[Conditional](Either `request_id` or `request_ids` must be provided)
`request_ids` | More than one [request_id](#keys-and-values). Each request_id is a new parameter in the Verify Search request. A maximum of 10 request_id parameters can be specified. | ^[Conditional](Either `request_id` or `request_ids` must be provided)

### Response

The following table shows example responses in JSON or XML:

**JSON**

```json
{
   "request_id":"requestId",
   "account_id":"accountId",
   "number":"number",
   "sender_id":"sender",
   "date_submitted":"date",
   "date_finalized":"date",
   "first_event_date":"date",
   "last_event_date":"date",
   "status":"status",
   "price":"price",
   "currency":"currency",
   "error_text":"error",
   "checks":[
      {
         "date_received":"date",
         "code":"code",
         "status":"status",
         "ip_address":"ip"
      }
   ]
}
```

*or* **XML**

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<verify_request>
    <request_id>requestId</request_id>
    <account_id>accountId</account_id>
    <number>number</number>
    <sender_id>senderId</sender_id>
    <date_submitted>date</date_submitted>
    <date_finalized>date</date_finalized>
    <checks>
       <check>
       <date_received>date</date_received>
       <status> status</status>
       <code>code</code>
       </check>
    </checks>
    <price>price</price>
    <currency> currency</currency>
    <error_text>error</error_text>
    <status>status</status>
</verify_request>
```

#### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`request_id` | The [request_id](#keys-and-values) you received in the Verify Request [Response](#rresponse) and used in the Verify Search [request](#srequest).
`account_id` | The Account ID the request was for.
`status` | The status of the Verify Request. Possible values are: <ul><li>`IN PROGRESS` - still in progress.</li><li>`SUCCESS` - your user entered the PIN correctly.</li><li>`FAILED` - user entered the wrong pin more than 3 times.</li><li>`EXPIRED` - no PIN entered during the [pin_expiry](#keys-and-values) time.</li><li>`CANCELLED` - the request was cancelled using Verify Control</li><li>101 - the [request_id](#keys-and-values) you set in the Verify Search [request](#srequest) is invalid.</li><ul>
`number` | The phone number this *Verify Request* was made for.</td>
`price` | The price charged for this *Verify Request*.
`currency` | The currency code.</td>
`sender_id` | The sender_id you provided in the *Verify Request*.
`date_submitted` | The date and time the *Verification Request* was submitted. This response parameter  is in the following format YYYY-MM-DD HH:MM:SS. For example, *2012-04-05 09:22:57*.</td>
`date_finalized` | The date and time the *Verification Request* was completed. This response parameter  is in the following format YYYY-MM-DD HH:MM:SS. For example, *2012-04-05 09:22:57*.</td>
`first_event_date` | Time first attempt was made. This response parameter  is in the following format YYYY-MM-DD HH:MM:SS. For example, *2012-04-05 09:22:57*.</td>
`last_event_date` | Time last attempt was made. This response parameter  is in the following format YYYY-MM-DD HH:MM:SS. For example, *2012-04-05 09:22:57*.</td>
`checks` | The list of checks made for this verification and their outcomes. Possible values are:<ul><li>date_received - in YYYY-MM-DD HH:MM:SS format</li><li>code</li><li>status - possible values are: <ul><li>VALID</li><li>INVALID</li></ul></li><li>ip_address</li></ul>
error_text | If *status* is not *SUCCESS*, this message explains the issue.

## Verify Control

To control the progress of your Verify Requests:

1. Send a Verify [request](#request-4).
2. Check the [response](#response-4).

⚓ conrequest
### Request

```
[GET] https://api.nexmo.com/verify/control/:format
```

#### Parameters

The following table shows the parameters you use in the request:

⚓ cmd

Parameter | Description | Required
-- | -- | --
`format` | The response format. Either `json` or `xml` | Yes
`request_id` | The [request_id](#keys-and-values) you received in the Verify Request [Response](#rresponse).| Yes
`cmd` | Change the command workflow. Supported values are: <ul><li>`cancel` - stop the request</li><li>`trigger_next_event` - advance the request to the next part of the process.</li></ul> Verification requests can't be cancelled within the first 30 seconds.	You must wait at least 30s after sending a Verify Request before cancelling. | Yes

⚓ conresponse
### Response

Example responses in JSON and XML:

**JSON**

```json
{
  "status":"0",
  "command":"cancel"
}
```

*or* **XML**

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<response>
    <status>0</status>
    <command>cancel</command>
</response>
```

#### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`status` | The Verify Control Response code that explains how your request proceeded. @[Possible Values](/_modals/api/verify/control/response/status.md).
`command` | The [cmd](#cmd) you sent in the request.


## Language codes

The following languages are accepted on the Verify API. The language code is used to manually set the language of the SMS text message and both the language and accent for the subsequent phone call.

Code    | Language
--------|---------
`de-de` | German, German
`en-au` | English, Australian
`en-gb` | English, UK
`en-us` | English, US (default)
`en-in` | English, Indian
`es-es` | Spanish, Spanish
`es-mx` | Spanish, Mexican
`es-us` | Spanish, US
`fr-ca` | French, Canadian
`fr-fr` | French, French
`is-is` | Icelandic, Icelandic
`it-it` | Italian, Italian
`ja-jp` | Japanese, Japanese
`ko-kr` | Korean, Korean
`nl-nl` | Dutch, Netherlands
`pl-pl` | Polish, Polish
`pt-pt` | Portuguese, Portuguese
`pt-br` | Portuguese, Brazilian
`ro-ro` | Romanian, Romanian
`ru-ru` | Russian, Russian
`sv-se` | Swedish, Sweden
`tr-tr` | Turkish, Turkish
`zh-cn` | Chinese (Mandarin), Simplified Chinese
`zh-tw` | Chinese, Traditional

If you request Taiwanese (`zh-tw`), the text message will be sent in Traditional Chinese, but the voice call uses a female voice speaking English with a Chinese accent.
