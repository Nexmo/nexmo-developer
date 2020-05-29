---
title: Create a conversation
description: Create a Conversation that enables Users to communicate
---

# Create a Conversation

Create the [Conversation](/conversation/concepts/conversation) that users will use to communicate with each other.

```bash
nexmo conversation:create display_name="CONVERSATION_NAME"
```

The output is similar to:

```
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Make a note of this newly generated conversation Id (`CON-...`). You will use it later to add [Users](/conversation/concepts/user) to the [Conversation](/conversation/concepts/conversation) as [Members](/conversation/concepts/member).