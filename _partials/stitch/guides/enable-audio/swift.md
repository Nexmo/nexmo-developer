---
title: Swift
language: swift
---

# Enable Audio in your Application

In this guide we'll cover adding audio events to the Conversation we have created in the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/swift) guide. We'll deal with sending and receiving media events to and from the conversation.

## Concepts

This guide will introduce you to the following concepts:

- **Audio Leg** - A server side API term. Legs are a part of a conversation. When audio is enabled on a conversation, a leg is created
- **Media Event** - a `NXMMediaEvent` event that fires on a Conversation when the media state changes for a member

## Before you begin

Run through the [creating a chat app tutorial](/client-sdk/tutorials/in-app-messaging/introduction/swift). You will be building on top of this project.

## Add audio permissions

Since enabling audio uses the device microphone, you will need to ask the user for permission. 

### `Info.plist`

Every Xcode project contains an `Info.plist` file containing all the metadata required in each app or bundle  - you will find the file inside the `AppToAppChat` group.

A new entry in the `Info.plist` file is required:

1. Hover your mouse over the last entry in the list and click the little `+` button that appears.

2. From the dropdown list, pick `Privacy - Microphone Usage Description` and add `Microphone access required in order to make and receive audio calls.` for its value.

### Request permission on application start

Open `AppDelegate.swift` and import the `AVFoundation` library right after where `UIKit` is included.

```swift
import UIKit
import AVFoundation
```

Next, call `requestRecordPermission:` inside `application:didFinishLaunchingWithOptions:`.

``` swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    AVAudioSession.sharedInstance().requestRecordPermission { (granted:Bool) in
        NSLog("Allow microphone use. Response: %d", granted)
    }
    return true
}
```

## Add audio UI

You will now need to add a button for the user to enable and disable audio. In the `viewDidLoad` function in the `ChatViewController.swift` class add a new bar button. 

``` swift
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Audio", style: .plain, target: self, action: #selector(self.toggleAudio))
```

## Enable audio 

Next would be to enable audio. Add a property to the `ChatViewController` class.

``` swift
var audioEnabled = false
```

The bar button from the previous step calls a `toggleAudio` function when tapped so add the following function to the `ChatViewController` class.

```swift
@objc func toggleAudio() {
    if audioEnabled {
        conversation?.disableMedia()
        navigationItem.rightBarButtonItem?.title = "Start Audio"
        audioEnabled = false
    } else {
        conversation?.enableMedia()
        navigationItem.rightBarButtonItem?.title = "Stop Audio"
        audioEnabled = true
    }
}
```

Note that enabling audio in a conversation establishes an audio leg for a member of the conversation. The audio is only streamed to other members of the conversation who have also enabled audio.

## Display audio events

When enabling media, `NXMMediaEvent` events are sent to the conversation. To display these you will need to add a function from the `NXMConversationDelegate` which will append the media events to events array for processing.

```swift
extension ChatViewController: NXMConversationDelegate {
  ...
    
  func conversation(_ conversation: NXMConversation, didReceive event: NXMMediaEvent) {
      self.events?.append(event)
  }
}
```

In the process events function you will need to add a clause for a `NXMMediaEvent`, which in turn calls `showMediaEvent` to display the audio events.

```swift
func processEvents() {
    DispatchQueue.main.async { [weak self] in
       ...
        self.events?.forEach { event in
            ...
            if let mediaEvent = event as? NXMMediaEvent {
                self.showMediaEvent(event: mediaEvent)
            }
        }
    }
}

func showMediaEvent(event: NXMMediaEvent) {
    if event.isEnabled {
        addConversationLine("\(event.fromMember?.user.name ?? "A user") enabled audio")
    } else {
        addConversationLine("\(event.fromMember?.user.name ?? "A user") disabled audio")
    }
}
```

## Build and run

Press `Cmd + R` to build and run again. Once logged in you can enable or disable audio. To test it out you can run the app on two different simulators/devices.

![Enable media](/images/client-sdk/ios-enable-media.png)
