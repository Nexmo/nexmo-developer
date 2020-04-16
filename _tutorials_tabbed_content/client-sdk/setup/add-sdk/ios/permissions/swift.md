---
title: Swift
language: swift
menu_weight: 1
---

```swift
import AVFoundation

func askAudioPermissions() {
    AVAudioSession.sharedInstance().requestRecordPermission { (granted:Bool) in
        NSLog("Allow microphone use. Response: %d", granted)
    }
}
```
