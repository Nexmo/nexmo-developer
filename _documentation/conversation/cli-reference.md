---
title: Nexmo CLI Command Reference
description: A list of commands supported by the Nexmo CLI for Conversation API
---

# Nexmo CLI Command Reference

Commands for dealing with Conversation API.

Command | Example | Description
---- | ---- | ----
`conversation:create` | `nexmo conversation:create display_name="Nexmo Chat"` | Create a new Conversation
`user:create` | `nexmo user:create name="alice"` | Create a new User
`member:add` | `nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}`user_id=USER_ID` | Adds a User to a Conversation
`member:list` | `nexmo member:list CONVERSATION_ID -v` | Lists Members of a Conversation

## Install the Beta version of the CLI

When working with Conversation API you will need to use the Beta version of the library.

To install the Beta version of the CLI with NPM you can use:

``` shell
npm install nexmo-cli@beta -g
```