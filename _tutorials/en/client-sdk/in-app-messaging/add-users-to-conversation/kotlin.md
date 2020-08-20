---
title: Add users to the conversation
description: Add your two new users as Conversation members
---

# Add Users to the Conversation

You must now add your [Users](/conversation/concepts/user) as [Members](/conversation/concepts/member) of the [Conversation](/conversation/concepts/conversation) using Nexmo CLI. 
To add `Alice` to the conversation replace `CONVERSATION_ID` in the command below with your conversation Id generated previously (`CON-...`) and run the command:

```sh
nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=Alice
```

The output is ID of the Member:

```
Member added: MEM-aaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Now you need to add the second user, `Bob` to the Conversation. Similarly, replace the `CONVERSATION_ID` and execute the command:

```sh
nexmo member:add CONVERSATION_ID action=join channel='{"type":"app"}' user_name=Bob
Member added: MEM-eeeeeee-...
```
