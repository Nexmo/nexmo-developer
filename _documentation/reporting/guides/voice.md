---
title: Voice Reports
---

# Voice

Download records of your Voice usage. Please note that the products currently supported via the Reports API are:

* SIP
* TTS

Data from the Voice API will be available for download soon.

## Contents

* [Field Reference](#field-reference)

## Field Reference

| Field              | Description                                                                                           |
|--------------------|-------------------------------------------------------------------------------------------------------|
| account_id         | ID of the account (API key)                                                                           |
| application_id     | ID of the application                                                                                 |
| conversation_id    | ID of the conversation (if applicable)                                                                |
| call_id            | ID of the call leg                                                                                    |
| start_time         | Time the call started in ISO 8601 format                                                              |
| end_time           | Time the call ended ISO 8601 format                                                                   |
| duration           | Length of the call in seconds                                                                         |
| from               | Origin of the call <ul><li>E.164</li><li>SIP</li><li>username</li><li>WebSocket</li></ul>             |
| to                 | Destination of the call <ul><li>E.164</li><li>SIP</li><li>username</li><li>WebSocket</li></ul>        |
| cost               | Cost of the call in €/min                                                                             |
| total_cost         | Cost of the call in €                                                                                 |
| price              | Price of the call in €/min                                                                            |
| total_price        | Price of the call in €                                                                                |
| direction          | Direction of the call (mo or mt)                                                                      |
| network            | Network used for call                                                                                 |
| status             | Final status of the call                                                                              |
| product            | Product ID (Always set to 5)                                                                          |
| country            | Country that the network belongs to                                                                   |
