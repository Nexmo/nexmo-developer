---
title: Conversation
description: A Conversation connects Users and allows them to communicate.
navigation_weight: 3
---

# Conversation

A Conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple [Media](/conversation/concepts/media) (text, voice, video) and can have associated [Users](/conversation/concepts/user) through [Member](/conversation/concepts/member) objects.

The Conversation object is key to understanding the Conversation API. In order for Users to communicate, they must connect to a Conversation, at which point an associated Member object is created in that Conversation.

A Conversation is capable of supporting text messaging, audio calls, or video calls. For text messaging a Conversation can be thought of as like a chat room. Users can be invited to join a Conversation and they can leave a Conversation. A single User can also join multiple Conversations through multiple Member objects.

Over the course of a Conversation, Nexmo emits various [Events](/conversation/concepts/event). These events can be communication events such as messages, voice and video streams or other events such as added or removed users, typing indicators and so on. The intention is that these events should be handled as they occur, although a log of events is recorded by Nexmo which can later be searched.

There can be no communication outside of the context of a Conversation.

A Conversation can be used for a single temporary communication interaction with a beginning and end, such as a call. Alternatively, it can be utilized as a permanent container for the complete history of all related interactions.

## An example Conversation

Consider the following example. A User calls a Nexmo Number associated with a Nexmo Application. The application forwards the call to a second phone. This is illustrated in the following diagram:

![Conversation](/assets/images/conversation-api/call-forward-conversation.png)

## Conversation details

The Call consists of two legs: inbound and outbound, and two Members, all contained in a Conversation object. If you used the Conversation API call [Get Conversation](/conversation/code-snippets/conversation/get-conversation) to obtain details of this Conversation you would obtain a response similar to the following:

``` json
{
    "uuid": "CON-bc643220-2542-499a-892e-c982c4150c06",
    "name": "NAM-1b2c4274-e3f2-494e-89c4-46856ee84a8b",
    "timestamp": {
        "created": "2018-10-25T09:26:18.999Z"
    },
    "sequence_number": 8,
    "numbers": {},
    "properties": {
        "ttl": 172800,
        "video": false
    },
    "members": [
        {
            "member_id": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
            "user_id": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6",
            "name": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6",
            "state": "JOINED",
            "timestamp": {
                "joined": "2018-10-25T09:26:30.334Z"
            },
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            },
            "initiator": {
                "joined": {
                    "isSystem": true
                }
            }
        },
        {
            "member_id": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
            "user_id": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b",
            "name": "vapi-user-f59c1ff26c0543fdb6c02fd30617a1c0",
            "state": "JOINED",
            "timestamp": {
                "invited": "2018-10-25T09:26:19.385Z",
                "joined": "2018-10-25T09:26:30.270Z"
            },
            "invited_by": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b",
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000001",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            },
            "initiator": {
                "invited": {
                    "isSystem": true
                }
            }
        }
    ],
    "_links": {
        "self": {
            "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06"
        }
    }
}
```

In the above response the phone numbers are as follows:

Number | Description
---- | ----
447700000001 | Phone making inbound call (Alice)
447700000002 | Nexmo Number linked to the Nexmo Application
447700000003 | The destination phone (Bob)

If you look carefully at the response you can see the following:

* There is one Conversation identified by the ID of the form `CON-<uuid>`.
* This Conversation has two Members - one for each User.
* Both Members are `JOINED` into the Conversation.
* Each Member has a Channel which has the type `phone`.
* Each Channel has an ID.
* Each Channel has a different Leg associated with it.
* Each Leg has a unique ID.

This is illustrated in the following diagram:

![Conversation](/assets/images/conversation-api/conversation-detail.png)

To summarize, in this example there is one call and one Conversation consisting of two Legs (inbound and outbound). Each User involved in the call is joined into the Conversation by becoming a Member of that Conversation.

## Events

If, while the call is in session, you get Events for the Conversation using the [List Events](/conversation/code-snippets/event/list-events) API call you would see Events that have taken place so far during the call:

``` json
[
    {
        "id": 1,
        "type": "member:joined",
        "from": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
        "to": "",
        "body": {
            "user": {
                "id": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6"
            },
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            },
            "timestamp": {
                "joined": "2018-10-25T09:26:19.204Z"
            }
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:19.207Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/1"
    },
    {
        "id": 2,
        "type": "sip:ringing",
        "from": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
        "to": "",
        "body": {
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000003",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            }
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:24.384Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/2"
    },
    {
        "id": 3,
        "type": "sip:answered",
        "from": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
        "to": "",
        "body": {
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000003",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            },
            "direction": "outbound"
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:30.277Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/3"
    },
    {
        "id": 4,
        "type": "member:joined",
        "from": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
        "to": "",
        "body": {
            "user": {
                "id": "USR-b9948493-be4a-4b36-bb4d-c96bcc2af85b"
            },
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000003",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            },
            "timestamp": {
                "invited": "2018-10-25T09:26:19.385Z",
                "joined": "2018-10-25T09:26:30.270Z"
            }
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:30.273Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/4"
    },
    {
        "id": 5,
        "type": "member:media",
        "from": "MEM-25ccda92-839d-4ac6-a7b2-de310224878b",
        "to": "",
        "body": {
            "audio": true,
            "media": {
                "audio": true,
                "audio_settings": {
                    "enabled": true,
                    "earmuffed": false,
                    "muted": false
                }
            },
            "channel": {
                "type": "phone",
                "id": "30cecc87-7ac9-4d03-910a-e9d69558263c",
                "from": {
                    "number": "Unknown",
                    "type": "phone"
                },
                "leg_ids": [
                    "30cecc87-7ac9-4d03-910a-e9d69558263c"
                ],
                "to": {
                    "number": "447700000003",
                    "type": "phone"
                },
                "cpa": false,
                "preanswer": false,
                "ring_timeout": 60000,
                "cpa_time": 5000,
                "max_length": 7200000
            }
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:30.274Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/5"
    },
    {
        "id": 6,
        "type": "sip:answered",
        "from": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
        "to": "",
        "body": {
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            },
            "direction": "inbound"
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:30.340Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/6"
    },
    {
        "id": 7,
        "type": "member:joined",
        "from": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
        "to": "",
        "body": {
            "user": {
                "id": "USR-33a51f4d-d06b-42f6-a525-90d2859ab9f6"
            },
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            },
            "timestamp": {
                "joined": "2018-10-25T09:26:30.334Z"
            }
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:30.337Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/7"
    },
    {
        "id": 8,
        "type": "member:media",
        "from": "MEM-f44c872e-cba9-444f-88ae-0bfa630865a6",
        "to": "",
        "body": {
            "audio": true,
            "media": {
                "audio": true,
                "audio_settings": {
                    "enabled": true,
                    "earmuffed": false,
                    "muted": false
                }
            },
            "channel": {
                "type": "phone",
                "id": "797168e24c19a3c45e74e05b10fef2b5",
                "from": {
                    "type": "phone",
                    "number": "447700000001"
                },
                "to": {
                    "type": "phone",
                    "number": "447700000002"
                },
                "leg_ids": [
                    "797168e24c19a3c45e74e05b10fef2b5"
                ]
            }
        },
        "state": "",
        "timestamp": "2018-10-25T09:26:30.337Z",
        "href": "https://api.nexmo.com/beta/conversations/CON-bc643220-2542-499a-892e-c982c4150c06/events/8"
    }
]
```

You can see the Events that occurred during this transient Conversation are as follows:

Event ID | Member ID | Event type | Description
----|----|----|----
1 | MEM-f44c872e-cba9-444f-88ae-0bfa630865a6 | `member:joined` | Alice to Nexmo Number
2 | MEM-25ccda92-839d-4ac6-a7b2-de310224878b | `sip:ringing` | Nexmo to Bob
3 | MEM-25ccda92-839d-4ac6-a7b2-de310224878b | `sip:answered` | Bob answered
4 | MEM-25ccda92-839d-4ac6-a7b2-de310224878b | `member:joined` | Bob joined the Conversation
5 | MEM-25ccda92-839d-4ac6-a7b2-de310224878b | `member:media` | Bob audio setup
6 | MEM-f44c872e-cba9-444f-88ae-0bfa630865a6 | `member:answered` | Alice answers
7 | MEM-f44c872e-cba9-444f-88ae-0bfa630865a6 | `member:joined` | Alice joins the Conversation
8 | MEM-f44c872e-cba9-444f-88ae-0bfa630865a6 | `member:media` | Alice audio set up

> **NOTE:** Each event has an Event ID.

As this is a transient Conversation (call) once the call ends the Conversation will no longer be available unless otherwise specified, so you can only see events that take place while the Conversation is live, and not the terminating event. A Conversation could be made persistent, for example, by specifying the `conversation` action in an NCCO controlling the call. You could see the terminating event if you looked at the activity on the Event webhook for your application, for example on `https://www.example.com:9000/webhooks/event` you would see a series of events such as the following:

Timestamp | Direction (Leg) | From | To | Event Type (status) | Notes
----|----|----|----|----|----
2018-10-25T09:26:18.991Z | Inbound | 447700000001 | 447700000002 | `started` | Calls Nexmo number
2018-10-25T09:26:18.991Z | Inbound | 447700000001 | 447700000002 | `ringing` | Now ringing
2018-10-25T09:26:19.827Z | N/A | 447700000001 | 447700000002 | N/A | At this point the call is answered
2018-10-25T09:26:24.384Z | Outbound | Unknown | 447700000003 | `started` | Nexmo calls out
2018-10-25T09:26:24.384Z | Outbound | Unknown | 447700000003 | `ringing` | Bob is ringing
2018-10-25T09:26:30.277Z | Outbound | Unknown | 447700000003 | `answered` | Bob answers
2018-10-25T09:26:30.340Z | Inbound | 447700000001 | 447700000002 | `answered` | Alice and Bob connected
2018-10-25T09:31:30.179Z | Inbound | 447700000001 | 447700000002 | `completed` | Inbound leg completes
2018-10-25T09:31:30.179Z | Outbound | Unknown | 447700000003 | `completed` | Outbound leg completes

This shows that Bob `completed` the call, and the Conversation was subsequently deleted.

This description so far has dealt with a Voice (Media) call over Phone (Channel) with two Legs. However, the same basic concepts would apply for different Media (Text, Voice or Video) and different Channels (Phone, SIP, Websocket, or App). The details for different call types would be a little different, for example Video calls would include different Event types.
