---
title: Members
description: Introduction to the concept of Members in Stitch.
navigation_weight: 4
---

# Members

Memberships connect users with Conversations. When a User joins a Conversation a Member is created. Each Membership has one Conversation and one User. However, a User can have many Memberships to Conversations just as Conversations can have many Members.

Each Member has a unique Member ID of the form:

```
MEM-df8e57d8-1c8e-4573-bf4d-29d5414dcb42
```

Memberships can be created in various ways: via the REST API, using the functions provided by the SDKs, or using the command line.

## Adding a Member to a Conversation

You can add a User into a Conversation (creating a Member) on the command-line as follows:

``` shell
$ nexmo member:add YOUR_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=YOUR_USER_ID
```

## Viewing the Members of a Conversation

You can view the Members of a Conversation with the command:

``` shell
$ nexmo member:list CON-35663e9d-687f-4e5c-bd37-91837294bd76 -v
```

This returns output similar to the following:

``` shell
name  | user_id                                  | user_name | state
----------------------------------------------------------------------
pete  | USR-fa1acfbb-0087-4fa5-911d-045586470edc | pete      | JOINED
alice | USR-cf0e4ff6-fd86-4d4a-9a90-282a59593480 | alice     | INVITED
bobby | USR-6a8cb033-e8fc-482f-8404-63085ab984d6 | bobby     | LEFT
bobby | USR-6a8cb033-e8fc-482f-8404-63085ab984d6 | bobby     | JOINED
```

The will also show the state of the Member such as `JOINED`, `INVITED`, `LEFT` and so on.

You can also use the REST API to get a list of Members:

``` shell
$ curl "https://api.nexmo.com/beta/conversations/CON-35663e9d-687f-4e5c-bd37-91837294bd76/members" \
     -H 'Authorization: Bearer eyJ0eXAiOiJKV1Q....YdVEyolrHqSKQ' \
     -H 'Content-Type: application/json'
```