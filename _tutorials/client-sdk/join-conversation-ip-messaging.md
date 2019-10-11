---
title: Fetch the conversation
description: In this step you join your Users to your Conversation
---

# Fetch the Conversation

Now that you have a valid user token, it's time to initialize a new `NexmoClient` instance and fetch the conversation to use for our chat app.

```javascript
async function run(userToken) {
  let client = new NexmoClient({ debug: true });
  let app = await client.login(userToken);
  let conversation = await app.getConversation(CONVERSATION_ID);
}
```

