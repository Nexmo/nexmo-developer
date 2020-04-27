---
title: Java
language: java
---

```java
private NexmoMessageEventListener messageListener = new NexmoMessageEventListener() {
    @Override
    public void onTextEvent(@NonNull NexmoTextEvent textEvent) {}

    @Override
    public void onAttachmentEvent(@NonNull NexmoAttachmentEvent attachmentEvent) {
        String userName = attachmentEvent.getFromMember().getUser().getName();

        Log.d("TAG", "Image event received. User " +  userName);

        // Event contains URL's for multiple sizes of images
        attachmentEvent.getOriginal().getUrl();
        attachmentEvent.getMedium().getUrl();
        attachmentEvent.getThumbnail().getUrl();

        //Download the image using one of open-source libraries: Coil, Picasso, Glide, etc.
    }

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
