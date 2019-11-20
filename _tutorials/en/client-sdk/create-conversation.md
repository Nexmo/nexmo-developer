---
title: Create a conversation
description: Create a Conversation that enables Users to communicate
---

# Create a Conversation

Create the [Conversation](/conversation/concepts/conversation) that users will use to communicate.

Replace `CONVERSATION_NAME` with a suitable name for your Conversation:

```bash
nexmo conversation:create display_name="CONVERSATION_NAME"
```

The output is similar to:

```
Conversation created: CON-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Make a note of this ID. You will use it to add Users to the Conversation as Members.