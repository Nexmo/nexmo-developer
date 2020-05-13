---
title: Seen Receipt
navigation_weight: 5
---

# Seen Receipt

## Overview

This guide covers seen receipts within a conversation.

Before you begin, make sure you [added the SDK to your app](/client-sdk/setup/add-sdk-to-your-app) and you are able to [create a simple conversation](/client-sdk/in-app-messaging/guides/simple-conversation).

```partial
source: _partials/client-sdk/messaging/chat-app-tutorial-note.md
```

This guide will make use of the following concepts:

- **Conversation Events** - `text:seen` events that fire on a Conversation, after you are a Member


## Text Seen Receipt

Given a conversation you are already a member of, `text:seen` events will be received when members have seen previously received `text` events in the context of the current conversation:

```tabbed_content
source: _tutorials_tabbed_content/client-sdk/guides/messaging/seen-receipt
```
