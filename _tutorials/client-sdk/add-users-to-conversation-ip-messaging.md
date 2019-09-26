---
title: Add users to the conversation
description: Add your two new users as Conversation members
---

# Add Users to the Conversation

You must now add your two new Users as [Members](/conversation/concepts/member) of the Conversation.

Use the Nexmo CLI for this, replacing `CONVERSATION_ID`, `USER1_MEMBER_ID` and `USER2_MEMBER_ID` in the examples below with your own values:

```sh
$ nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_id=USER1_USER_ID
Member added: MEM-5254e70c-...

$ nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_id=USER2_MEMBER_ID
Member added: MEM-39cccf48-...
```