---
title: Verify Reports
---

# Verify

Download records of your Verify usage

## Contents

* [Field Reference](#field-reference)

## Field Reference

| Field              | Description                                                                                           |
|--------------------|-------------------------------------------------------------------------------------------------------|
| account_id         | ID of the account (API key)                                                                           |
| request_id         | Unique ID of this Verify request                                                                      |
| to                 | Phone number being verified (if not anonymised)                                                       |
| date_submitted     | The date and time the Verification Request was submitted. This response parameter is in the following format YYYY-MM-DD HH:MM:SS.<br />For example, 2012-04-05 09:22:57.                                                           |
| date_finalized     | The date and time the Verification Request was completed. This response parameter is in the following format YYYY-MM-DD HH:MM:SS. <br />For example, 2012-04-05 09:22:57.                                                          |
| sender_id          | The sender ID specified in the Verify request                                                         |
| status             | The status of this Verify request. Possible values are:<ul><li>IN PROGRESS - still in progress.</li><li>SUCCESS - your user entered the PIN correctly.</li><li>FAILED - user entered the wrong pin more than 3 times.</li><li>EXPIRED - no PIN entered during the pin_expiry time.</li><li>CANCELLED - the request was cancelled using Verify Control</li></ul>                                                                                                            |
| price              | The price charged for the request                                                                     |
| currency           | Currency code of the price                                                                            |
| first_event_date   | Time first attempt was made. This response parameter is in the following format YYYY-MM-DD HH:MM:SS. <br />For example, 2012-04-05 09:22:57.                                                                                      |
| last_event_date    | Time last attempt was made. This response parameter is in the following format YYYY-MM-DD HH:MM:SS. <br />For example, 2012-04-05 09:22:57.                                                                                          |
| error_text         | Error encountered when processing the request                                                         |
| locale             | Locale code specified for the Verify request                                                          |
| sms_event_count    | Number of SMS messages sent as part of this request                                                   |
| tts_event_count    | Number of TTS calls made as part of this request                                                      |
| country_code       | Country code of number that was provided by customer in Verify request                                |
| network            | Network that number belongs to                                                                        |
| number_type        | Possible values are: <ul><li>MOBILE</li><li>LANDLINE</li><li>LANDLINE_PREMIUM</li><li>LANDLINE_TOLLFREE</li><li>PAGER</li><li>VIRTUAL</li><li>UNKNOWN</li></ul>                                                |
