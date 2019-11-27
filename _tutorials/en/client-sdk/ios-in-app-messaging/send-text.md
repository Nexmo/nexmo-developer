---
title: Send text message
description: In this step you learn how to send a text message.
---

# Send a text message

Use the conversation object to send a text message:

```objective-c
[conversartion sendText:@"text" completion:^(NSError * _Nullable error) {
    if(error) {
        //handle error in sending text
    }
    //text arrived at server
}];
```
