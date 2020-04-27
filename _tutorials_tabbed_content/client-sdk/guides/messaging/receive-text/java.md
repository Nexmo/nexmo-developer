---
title: Java
language: java
---

```java
NexmoMessageEventListener messageListener = new NexmoMessageEventListener() {

    @Override
    public void onTextEvent(@NonNull NexmoTextEvent textEvent) {
        String userName = textEvent.getFromMember().getUser().getName();
        String text = textEvent.getText();

        Log.d("TAG", "Message received. User " + userName + " : " + text);
    }

    @Override
    public void onAttachmentEvent(@NonNull NexmoAttachmentEvent attachmentEvent) {}

    @Override
    public void onEventDeleted(@NonNull NexmoDeletedEvent deletedEvent) {}

    @Override
    public void onSeenReceipt(@NonNull NexmoSeenEvent seenEvent) {}

    @Override
    public void onDeliveredReceipt(@NonNull NexmoDeliveredEvent deliveredEvent) {}

    @Override
    public void onTypingEvent(@NonNull NexmoTypingEvent typingEvent) {}
};

conversation.addMessageEventListener(messageListener);
```
