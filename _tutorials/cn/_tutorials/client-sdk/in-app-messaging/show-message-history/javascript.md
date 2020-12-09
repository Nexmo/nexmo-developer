---
title:  Show the message history
description:  In this step you display any messages already sent as part of this Conversation

---

Show the Message History
========================

You want your users to see all the messages in the Conversation. You can achieve this by handling the Conversation’s `getEvents` method (to retrieve messages sent and received before the current session started) and its `text` event (which alerts your application when a user sends a message).

In the case where the number of messages are more than the page size of the request, you can use `getNext()` to receive the next page. More information on `getNext()` can be found in the [documentation](https://developer.nexmo.com/sdk/stitch/javascript/EventsPage.html#getNext). This function is called when the Load Previous Messages button is clicked. Place this code after the `loginForm` event listener and before the `run` function.

```javascript
loadMessagesButton.addEventListener('click', async (event) => {
  // Get next page of events
  let nextEvents = await listedEvents.getNext();
  listMessages(nextEvents);
});
```

Your application can retrieve the message detail from the event data sent to each handler and add it to the list of messages.

To list the messages, we will create a `listMessages` function that will take an events page and perform a few steps.

First, if the events page has messages on a following page, the "Load Previous Messages" button is visible. To do that, `hasNext()` is called and returns a boolean based on if there is another page of messages. You can find out more information about `hasNext()` in the [documentation](https://developer.nexmo.com/sdk/stitch/javascript/EventsPage.html#hasNext).

Next, you will loop through the events, format and combine them and then add to the message list.

Add the following code to the bottom of `chat.js`:

```javascript
function listMessages(events) {
  let messages = '';

  // If there is a next page, display the Load Previous Messages button
  if (events.hasNext()){
    loadMessagesButton.style.display = "block";
  } else {
    loadMessagesButton.style.display = "none";
  }

  // Replace current with new page of events
  listedEvents = events;

  events.items.forEach(event => {
    const formattedMessage = formatMessage(conversation.members.get(event.from), event, conversation.me);
    messages = formattedMessage + messages;
  });

  // Update UI
  messageFeed.innerHTML = messages + messageFeed.innerHTML;
  messagesCountSpan.textContent = `${messagesCount}`;
  messageDateSpan.textContent = messageDate;
}
```

In this example, you will use the identity of the user to distinguish between messages sent by them and those received from other users by displaying them in a different color. Create a `formatMessage` function for this, by adding the following code to the bottom of `chat.js`:

```javascript
function formatMessage(sender, message, me) {
  const rawDate = new Date(Date.parse(message.timestamp));
  const formattedDate = moment(rawDate).calendar();
  let text = '';
  messagesCount++;
  messageDate = formattedDate;

  if (message.from !== me.id) {
    text = `<span style="color:red">${sender.user.name} (${formattedDate}): <b>${message.body.text}</b></span>`;
  } else {
    text = `me (${formattedDate}): <b>${message.body.text}</b>`;
  }

  return text + '<br />';

}
```

Now that you have implemented a way to show messages on the page, add the following to the bottom of your `run` function to load historical messages:

```javascript
// Update the UI to show which user we are
document.getElementById('sessionName').innerHTML = conversation.me.user.name + "'s messages"

// Load events that happened before the page loaded
  let initialEvents = await conversation.getEvents({ event_type: "text", page_size: 10, order:"desc" });
  listMessages(initialEvents);

```

Finally, you need to set up an event listener for any new incoming messages. You can do this by listening to the `conversation.on('text')` event. This will also update the messages count. Add the following to the bottom of the `run` function:

```javascript
  // Any time there's a new text event, add it as a message
  conversation.on('text', (sender, event) => {
    const formattedMessage = formatMessage(sender, event, conversation.me);
    messageFeed.innerHTML = messageFeed.innerHTML +  formattedMessage;
    messagesCountSpan.textContent = `${messagesCount}`;
  });
```

