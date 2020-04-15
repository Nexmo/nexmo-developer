---
title: Java
language: java
---

```java
private NexmoMessageEventListener messageListener = new NexmoMessageEventListener() {
    @Override
    public void onTextEvent(@NonNull NexmoTextEvent textEvent) {}

    @Override
    public void onAttachmentEvent(@NonNull NexmoAttachmentEvent attachmentEvent) {}

    @Override
    public void onEventDeleted(@NonNull NexmoDeletedEvent deletedEvent) {}

    @Override
    public void onSeenReceipt(@NonNull NexmoSeenEvent seenEvent) {}

    @Override
    public void onDeliveredReceipt(@NonNull NexmoDeliveredEvent deliveredEvent) {}

    @Override
    public void onTypingEvent(@NonNull NexmoTypingEvent typingEvent) {
        String userName = typingEvent.getFromMember().getUser().getName();

        String typingState;

        if(typingEvent.getState() == NexmoTypingState.ON) {
            typingState = "typing";
        } else {
            typingState = "not typing";
        }

        Log.d("TAG", "User " + userName + " is " + typingState);
    }
};

conversation.addMessageEventListener(messageListener);
```
