---
title: Handling pagination
navigation_weight: 8
---

# Handling pagination

This guide covers the process loading and displaying chunks of conversation events at a time.

```partial
source: _partials/client-sdk/messaging/chat-app-tutorial-note.md
```

Given a Conversation you are already a Member of, you can download chunks (pages) of events existing within this conversation. 

Load first page of events:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/handling-pagnation/load-page-events
```

After loading the first chunk of events you will get the _reference_ to the current Nexmo Events Page ([JavaScript](/sdk/stitch/javascript/EventsPage.html), [iOS](/sdk/stitch/ios/Classes/NXMEventsPage.html), [Android](/sdk/stitch/android/com/nexmo/client/NexmoEventsPage.html)). This _reference_ allows you to retrieve following event pages:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/handling-pagnation/load-next-event-page
```

Preceding pages can also be retrieved using a similar technique:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/handling-pagnation/load-prev-event-page
```
