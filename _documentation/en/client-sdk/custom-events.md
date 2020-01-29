---
title: Custom Events
---

# Custom Events

Custom events allow you to add custom metadata to conversations by recording data alongside your text or audio events. You can add events [using the REST API](/conversation/code-snippets/event/create-custom-event) or using the JavaScript SDK.

## Creating a custom event

Each custom event consists of a unique `type` and a `body`. The `type` has the following restrictions:

* Must not exceed 100 characters
* Must only contain alphanumeric, `-` and `_` characters

In addition, the event body must not exceed 4096 bytes.

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/custom-events/creating
```

## Listening to custom events

In addition to adding custom events to the conversation, you can listen for custom events using the Client SDK. Register an event handler that listens for your custom event name:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/custom-events/listening
```

## Complete example

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/custom-events/complete
```
