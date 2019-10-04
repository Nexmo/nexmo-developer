---
title: Show the message history
description: In this step you display any messages already sent as part of this Conversation
---

# Show the Message History

You want your users to see the message history. You can achieve this by calling the Conversation's `getEvents` method (to retrieve historical messages sent and received before the current session started) and handling its `text` event (which alerts your application when a user sends a message).

Your application must inspect the event data sent to each handler to determine the message sender and its contents and then append it to the list of messages.

In this example you will use the identity of the user to distinguish between messages sent by them and those received from other users by displaying them in a different color. Create an `addMessage` function for this, by adding the following code to the bottom of `chat.js`:

```javascript
function addMessage(sender, message, me) {
  const rawDate = new Date(Date.parse(message.timestamp))
  const formattedDate = moment(rawDate).calendar()

  let text = ''
  if (message.from !== me.id) {
    text = `<span style="color:red">${sender.user.name} <span style="color:red;">(${formattedDate}): <b>${message.body.text}</b></span>`
  } else {
    text = `me (${formattedDate}): <b>${message.body.text}</b>`
  }

  messageFeed.innerHTML = messageFeed.innerHTML + text + '<br />';
}
```

Now that you have implemented a way to show messages on the page, add the following to the bottom of your `run` function to load historical messages:

```javascript
// Update the UI to show which user we are
document.getElementById('sessionName').innerHTML = conversation.me.user.name + "'s messages"

// Load events that happened before the page loaded
let events = await conversation.getEvents({event_type: "text", page_size: 100});
events.items.forEach(event => {
  addMessage(conversation.members.get(event.from), event, conversation.me);
});
```

Finally, you need to set up an event listener for any new incoming messages. You can do this by listening to the `conversation.on('text')` event. Add the following to the bottom of the `run` function:

```javascript
// Any time there's a new text event, add it as a message
conversation.on('text', (sender, event) => {
  addMessage(sender, event, conversation.me); 
});
```
