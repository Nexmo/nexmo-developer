---
title: Number Insight Reports
---

# Number Insight

Download records of your Number Insight usage.

## Contents

* [Field Reference](#field-reference)

## Field Reference

| Field                   | Description                                                                                      |
|-------------------------|--------------------------------------------------------------------------------------------------|
| acc                     | ID of the account (API key)                                                                      |
| callback                | The URL to notify about events related to the request                                            |
| callerName              | Full name of the person or business who owns the phone number                                    |
| callerSubscriptionType  | The mobile number subscription type. Possible values are: <ul><li>unknown</li><li>postpaid</li><li>prepaid</li></ul>   |
| callerType              | The type of the owner. Possible values are: <ul><li>unknown</li><li>consumer</li><li>business</li></ul>   |
| country                 | The country where the phone number is registered                                                 |
| dateSubmitted	          | The date the request was submitted to Nexmo                                                      |
| err                     | The status of the request. Possible values are: <ul><li>Success</li><li>Lookup Handler unable to handle request</li><li>Internal error</li><li>Lookup Handler timed out</li><li>No handler available to service this request</li></ul>             |
| firstName               | The first name registered to the number. Can be unknown for businesses                           |
| id                      | Unique ID of the request                                                                         |
| ip                      | The customer's IP address where the request originated from                                      |
| ipCountry               | The country where the IP address is registered                                                   |
| ipMatchLevel            | The match status between ip and number parameters. Possible values are: <ul><li>unknown</li><li>country</li><li>mismatch</li></ul>|
| lastName                | The last name registered to the number. Can be unknown for businesses                            |
| msisdn                  | The phone number searched                                                                        |
| netType                 | The network type of the number. Possible values are: <ul><li>unknown</li><li>mobile</li><li>landline</li><li>virtual</li><li>landline_premium</li><li>landline_tollfree</li><li>pager</li></ul>|
| ported                  | The porting status of the number. Possible values are: <ul><li>unknown</li><li>assumed_not_ported</li><li>ported</li><li>not_ported</li><li>assumed_ported</li></ul>|
| price                   | The price paid for the request                                                                   |
| reachable               | Can you call the number now? This is applicable to mobile numbers only. Possible values are: <ul><li>unknown</li><li>reachable</li><li>undeliverable</li><li>bad_number</li><li>absent</li></ul>|
| responseCode            | The response code of the request as defined [here](https://developer.nexmo.com/api/number-insight)|
| roaming                 | The roaming status of the number. Possible values are: <ul><li>unknown</li><li>false</li><li>true</li></ul>            |
| roamingCountry          | If number is roaming, this is the code  of the country number is roaming in                      |
| valid                   | Does the number exist? This is applicable to mobile numbers only. Possible values are: <ul><li>unknown</li><li>valid</li><li>inferred_not_valid</li><li>not_valid</li></ul>|
