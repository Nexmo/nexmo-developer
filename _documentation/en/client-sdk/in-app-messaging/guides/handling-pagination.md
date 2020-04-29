---
title: Handling pagination
navigation_weight: 8
---

# Handling Events

This guide covers the process loading and displaying chunks of conversation events at a time.

> **NOTE:** A step-by-step tutorial to building a web-based chat application is also available here for [JavaScript](/client-sdk/tutorials/in-app-messaging) and [iOS](/client-sdk/tutorials/ios-in-app-messaging-chat).

Given a Conversation you are already a Member of, you can download chunks (pages) of events existing within this conversation. 

Load first page off events:
```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/handling-pagnation/load-page-events
```

After loading the first chunk of events you will get the reference to the current [NexmoEventsPage](https://developer.nexmo.com/sdk/stitch/android/). This reference allows to retrieve following event pages:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/handling-pagnation/load-next-event-page
```

Preceding pages can also be retrieved using a similar technique:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/handling-pagnation/load-prev-event-page
```

