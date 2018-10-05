---
title: Users
description: Introduction to the concept of Users in Stitch.
navigation_weight: 2
---

# Users

The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

A person who will communicate via Stitch must first have a User object created. A User can be thought of as an end-point for communication. When the User object is created it is assigned a unique user ID.

## Create a user

You can create a User on the command line with:

``` shell
$ nexmo user:create name="jamie"
```

This will return a unique User ID:

```
USR-cf0e4ff6-fd86-4d4a-9a90-282a59593480
```

## List all Users

A REST API call is available that will list all Users. As the JWT used to authenticate this REST API call is tied to a specific Nexmo application, all Users associated with that application will be returned:

``` shell
$ curl "https://api.nexmo.com/beta/users" \
     -H 'Authorization: Bearer eyJ0eXAiOiJKV1Q....7Rckzv3QiOqSjmj1JQGq7smQ' \
     -H 'Content-Type: application/json'
```
