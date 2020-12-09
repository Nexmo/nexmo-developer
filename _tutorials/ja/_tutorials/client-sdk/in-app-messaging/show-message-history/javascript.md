---
title:  メッセージ履歴を表示する
description:  このステップでは、この会話の一部として送信済みのメッセージを表示します

---

メッセージ履歴を表示する
============

ユーザーがカンバセーション内のすべてのメッセージを表示するようにします。これは、カンバセーションの`getEvents`メソッド（現在のセッションが開始する前に送受信されたメッセージを取得する）とその`text`イベント（ユーザーがメッセージを送信したときにアプリケーションに警告する）を処理することで実現できます。

メッセージの数がリクエストのページサイズよりも多い場合は、`getNext()`を使用して次のページを受信できます。`getNext()`の詳細については、[ドキュメント](https://developer.nexmo.com/sdk/stitch/javascript/EventsPage.html#getNext)を参照してください。この関数は、[Load Previous Messages (前のメッセージをロード)]ボタンがクリックされたときに呼び出されます。このコードは、`loginForm`イベントリスナーの後、`run`関数の前に配置します。

```javascript
loadMessagesButton.addEventListener('click', async (event) => {
  // Get next page of events
  let nextEvents = await listedEvents.getNext();
  listMessages(nextEvents);
});
```

アプリケーションは、各ハンドラに送信されたイベントデータからメッセージの詳細を取得し、メッセージのリストに追加できます。

メッセージを一覧表示するには、イベントページを取り、いくつかの手順を実行する`listMessages`関数を作成します。

まず、イベントページの次のページにメッセージがある場合、[Load Previous Messages (前のメッセージをロード)]ボタンが表示されます。これを行うには、`hasNext()`を呼び出し、メッセージの別のページがあるかどうかに基づいてブール値を返します。`hasNext()`の詳細については、[ドキュメント](https://developer.nexmo.com/sdk/stitch/javascript/EventsPage.html#hasNext)を参照してください。

次に、イベントをループし、それらをフォーマットして結合し、メッセージリストに追加します。

`chat.js`の末尾に次のコードを追加します：

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

この例では、ユーザーのIDを使用して、ユーザーが送信したメッセージと他のユーザーから受信したメッセージを異なる色で表示して区別します。`chat.js`の末尾に次のコードを追加して、このための`formatMessage`関数を作成します：

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

ページ上にメッセージを表示する方法を実装したので、`run`関数の下部に次の項目を追加して、履歴メッセージをロードします：

```javascript
// Update the UI to show which user we are
document.getElementById('sessionName').innerHTML = conversation.me.user.name + "'s messages"

// Load events that happened before the page loaded
  let initialEvents = await conversation.getEvents({ event_type: "text", page_size: 10, order:"desc" });
  listMessages(initialEvents);

```

最後に、新しい受信メッセージのイベントリスナーを設定する必要があります。これは、`conversation.on('text')`イベントを聞くことによって行うことができます。これにより、メッセージ数も更新されます。`run`関数の末尾に以下を追加します：

```javascript
  // Any time there's a new text event, add it as a message
  conversation.on('text', (sender, event) => {
    const formattedMessage = formatMessage(sender, event, conversation.me);
    messageFeed.innerHTML = messageFeed.innerHTML +  formattedMessage;
    messagesCountSpan.textContent = `${messagesCount}`;
  });
```

