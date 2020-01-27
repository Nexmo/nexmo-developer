---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
[conversation sendAttachmentWithType:NXMAttachmentTypeImage 
                                name:@"File name"
                                data:[NSData dataWithContentsOfFile:@"file.png"]
                   completionHandler:^(NSError * _Nullable error) {
    NSLog(@"Image sent");
}];
```
