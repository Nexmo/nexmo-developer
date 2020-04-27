---
title: Add users to the conversation
description: Add your two new users as Conversation members
---

# Add Users to the Conversation

You must now add your two new Users as [Members](/conversation/concepts/member) of the Conversation.

Use the Nexmo CLI for this, replacing `CONVERSATION_ID` in the examples below with your own value given previously:

```sh
$ nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=Jane
```

The output is similar to:

```
Member added: MEM-aaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Similarly, to add the second user:

```sh
$ nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=Joe
Member added: MEM-eeeeeee-...
```
