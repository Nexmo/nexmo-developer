---
title: SMS Reports
---

# SMS

Download records of your SMS usage

## Contents

* [Field Reference](#field-reference)
* [MT only Field Reference](#outbound-field-reference)

## Definitions

* __MT__: an outbound message
* __MO__: an inbound message

## Field Reference

| Field                  | Description                                                                                       |
|------------------------|---------------------------------------------------------------------------------------------------|
| account_id             | ID of the account (API key)                                                                       |
| message_id             | Unique ID of the SMS in the Nexmo system                                                          |
| type                   | The message type.  Possible values are: <ul><li>__MT__ - mobile terminated or outbound</li><li>__MO__ - mobile originated or inbound</li></ul>                                                                          |
| network                | The MCCMNC for the carrier which delivered this message                                           |
| network_name           | The name of the network e.g. Vodafone                                                             |
| from                   | Sender ID of this message: <ul><li>__MT__: set in API call</li><li>__MO__: end user's phone number</li></ul>                                                                                                             |
| to                     | Number of message recipient: - <ul><li>__MT__: set in API call</li><li>__MO__: Nexmo virtual number rented by customer</li></ul>  |
| date_received          | The date and time at UTC+0 when Nexmo received the API request or mobile originated message in the following format: YYYY-MM-DD HH:MM:SS. <br />For example: 2011-11-15 14:34:10                                                      |
| country                | Country of the non-Nexmo number. i.e. the STD code at the start of an E.164 number e.g. 44 for UK <ul><li>__MT__: country of the to number</li><li>__MO__: country of the from number</li></ul>                                                              |
| country_name           | Name of the country in the "country" field                                                        |

## Outbound Field Reference

| Field                  | Description                                                                                       |
|------------------------|---------------------------------------------------------------------------------------------------|
| date_closed            | The date and time at UTC+0 when Nexmo received the delivery receipt from the carrier who delivered the MT message. <br />This parameter is in the following format YYYY-MM-DD HH:MM:SS. <br />For example: 2011-11-15 14:34:40             |
| status                 | A code that explains where the message is in the delivery process. If status is not delivered check error-code for more information. If status is accepted ignore the value of error-code. <br />Possible values are: <ul><li>__delivered__ - this message has been delivered to the phone number.</li><li>__expired__ - the target carrier did not send a status in the 48 hours after this message was delivered to them.</li><li>__failed__ - the target carrier failed to deliver this message.</li><li>__rejected__ - the target carrier rejected this message.</li><li>__accepted__ - the target carrier has accepted to send this message.</li><li>__buffered__ - This message is in the process of being delivered.</li><li>__unknown__ - the target carrier has returned an undocumented status code.</li></ul> |
| error_code             | Numeric value between 0 and 99                                                                    |
| error_code_description | Text description of the error: <ul><li>__0__ - Delivered</li><li>__1__ - Unknown</li><li>__2__ - Absent Subscriber Temporary</li><li>__3__ - Absent Subscriber Permanent</li><li>__4__ - Call barred by user</li><li>__5__ - Portability Error</li><li>__6__ - Anti-Spam Rejection</li><li>__7__ - Handset Busy</li><li>__8__ - Network Error</li><li>__9__ - Illegal Number</li><li>__10__ - Invalid Message</li><li>__11__ - Unroutable</li><li>__12__ - Destination unreachable</li><li>__13__ - Subscriber Age Restriction</li><li>__14__ - Number Blocked by Carrier</li><li>__15__ - Pre-Paid - Insufficient funds</li><li>__99__ - General Error</li></ul>       |
| price                  | Price in EURO for a MT message. <br />For example: 0.035                                                |
| latency                | The overall latency between date-received and date-closed in milliseconds. <br />For example: 4302      |
| account_ref            | The customer account via an anonymised id, if present                                   |
| client_ref             | The customer reference set in the request, if present                                             |
| final_state            | The status of message-id at date-closed. Possible values are: <ul><li>DELIVRD</li><li>EXPIRED</li><li>UNDELIV</li><li>REJECTD</li><li>UNKNOWN</li></ul>                                                                                                       |
