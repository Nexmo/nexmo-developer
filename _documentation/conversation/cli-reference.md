---
title: Nexmo Command CLI Reference
description: A list of commands supported by the Nexmo CLI for Conversation API
---

# Nexmo CLI Command Reference

Commands for dealing with Conversation API.

Command | Example | Description
---- | ---- | ----
`conversation:create` or `cc` **payload** | `nexmo conversation:create display_name="Nexmo Chat"` | Create a new Conversation
`user:create` or `uc` **payload** | `nexmo user:create name="alice"` | Create a new User
`member:add` or `ma` **conversation_id** **payload** | `nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_id=USER_ID` | Adds a User to a Conversation
`member:list` or `ml` **conversation_id** | `nexmo member:list CONVERSATION_ID -v` | Lists Members of a Conversation
