---
title: Project permissions
description: In this step you will add the necessary permissions to the project properties.
---

# Project permissions

As you'll be using the microphone when making a call, you need to request the permission to use it.

## Info.plist

A new entry in the `Info.plist` file is required:

1. Hover your mouse over the last entry in the list and click the little `+` button that appears.

2. From the dropdown list, pick `Privacy - Microphone Usage Description` and add `Microphone access required in order to make and receive audio calls.` for its value.

Your `Info.plist` should look like this:

![Info.plist](/assets/images/client-sdk/ios-voice/Xcode-permissions.jpg)

## Request permission on application start

Open `AppDelegate.swift` and import the `AVFoundation` library right after where `UIKit` is included:

```swift
import UIKit
import AVFoundation
```

Next, add the following method above `// MARK: UISceneSession Lifecycle`:

``` swift
func askAudioPermissions() {
    AVAudioSession.sharedInstance().requestRecordPermission { (granted:Bool) in
        NSLog("Allow microphone use. Response: %d", granted)
    }
}
```

You will then call this method from within `application:didFinishLaunchingWithOptions:`:

``` swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    askAudioPermissions()
    return true
}
```

You can now build and run the project, by either selecting `Product` > `Run` from the top menu, or pressing `Cmd + R`, and launch it in the simulator. 

Notice the prompt asking for permission to use the microphone:

![Simulator microphone permission ask](/assets/images/client-sdk/ios-voice/Simulator-microphone-permission-ask.jpg)