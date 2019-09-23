---
title: Show the message history
description: In this step you display any messages already sent as part of this Conversation
---

# Show the Message History

You want your users to see the message history. You can achieve this by handling the Conversation's `text` event which alerts your application when a user sends a message.

The event provides details of the user that sent the message and the message contents. In this example you will use the identity of the user to color code messages sent by the user and those received from other users.

```javascript
function setupShowMessages(conv) {
  conversation = conv
  document.getElementById('sessionName').innerHTML = conversation.me.user.name + "'s messages"

  // Bind to events on the conversation
  conversation.on('text', (sender, message) => {
    const rawDate = new Date(Date.parse(message.timestamp))

    const formattedDate = moment(rawDate).calendar()

    let text = ''
    if (message.from !== conversation.me.id) {
      text = `<span style="color:red">${sender.user.name} <span style="color:red">(${formattedDate}): <b>${message.body.text}</b></span><br>`
    } else {
      text = `me (${formattedDate}): <b>${message.body.text}</b><br>`
    }

    messageFeed.innerHTML = messageFeed.innerHTML + text

  })
```