---
title: The Conversation UI
description: Walkthrough the ConversationViewController
---

# The Conversation UI

The `ConversationViewController` is responsible for displaying the conversation:

![Conversation UI](/assets/images/client-sdk/ios-messaging/conversation-ui.png)

The interface consists of three groups of elements:

- a `UIActivityIndicatorView` and a (status) `UILabel` to be shown during the initial loading
- a `UITextView` to show the conversation content
- a `UITextField` to compose the message and a `NSLayoutConstraint` for its bottom to change its vertical position when the keyboard is shown

All are referenced as `IBOutlet`s:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/tutorials/ios-in-app-messaging-chat/conversation-ui'
```
