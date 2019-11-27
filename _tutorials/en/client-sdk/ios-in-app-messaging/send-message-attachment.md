---
title: Send a message with attachment
description: In this step you learn how to send a message with attachment.
---

# Send a message with attachment

You can use the conversation object to send attachments. The following example shows how to send an attachment in a conversation:

```objective-c
[conversation sendAttachmentOfType:NXMAttachmentTypeImage WithName:filename data:data completion:^(NSError * _Nullable error) {
    if(error) {
        //Handle error sending image
        return;
    }
    //image sent to server
}];
```
