---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
#import <AVFoundation/AVAudioSession.h>

- (void)askAudioPermissions {
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)])
    {
        [[AVAudioSession sharedInstance] requestRecordPermission: ^ (BOOL granted)
        {
        NSLog(@"Allow microphone use. Response: %d", granted);
        }];
    }
}
```
