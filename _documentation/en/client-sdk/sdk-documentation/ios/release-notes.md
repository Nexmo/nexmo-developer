---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes


## 2.1.5 - 2020-03-18

### Internal
- Updated Device Registration format for production environments.


## 2.1.1 - 2020-03-05

### Added
- `NXMClient`'s `getConversationsPageWithSize:order:filter:completionHandler:` method to get conversations with paging.

### Deprecated
- `NXMClient`'s `getConversationsPageWithSize:order:completionHandler:` method to get conversations with paging.

### Internal
- The SDK is now built with Xcode 11.


## 2.1.0 - 2020-01-31

### Added

- `NXMPushPayload` for custom push notifications.

```
 if (NXNClient.shared isNexmoPushWithUserInfo:pushInfo]){
 	NXMPushPayload *pushPayload = [myNXNClient processNexmoPushPayload:pushInfo];
 	if (!pushPayload){
    	// "Not a Nexmo push!!"
    	return;
 	};

	if (pushPayload.template == NXMPushTemplateCustom) {
		// Got custom push
		pushPayload.customData // your customData
	}
 }
```

---

## 2.0.0 - 2020-01-15

### Added
- `NXMHelper` with `descriptionForEventType:` method.
- `NXMConversation`'s `getEvents:` method replaced by `getEventsPage:`, `getEventsPageWithSize:order:completionHandler:`, `getEventsPageWithSize:order:eventType:completionHandler:`.

```
[myNXMConversation getEventsPagePageWithSize:15
                                       order:NXMPageOrderDesc
                                   eventType:nil
                           completionHandler:^(NSError * _Nullable error, NXMEventsPage * _Nullable page) {
                               if (error || !page) {
                                   // handle error...
                                   return;
                               }

                               // use page...
                           }];
```

- `NXMConversationsPage`'s `nextPage:` and `previousPage:` completion handlers are now non-null.

### Fixed
- Calling `conversation.getEvents` returned a `NXMMemberEvent` with the field `member` set to `nil`.

---

## 1.2.3 - 2019-12-17

### Fixed.
- `conversation.getEvents` returned some `NXMEvent`s containing a nil `fromMember`
- Added descriptive `userInfo` for `NXMError`s.

---

## 1.2.2 - 2019-12-12

### Fixed
- Added support for DTLS in WebRTC.
- `didReceiveCall` and `didReceiveConversation` being called only once for the same call or conversation.
- Added option to enable push notification with only one `pushKit` or `userNotification` token.
- Fix for `NXMClientConfig` region URLs.
- On login with invalid user, return `NXMConnectionStatusReasonUserNotFound`.
- Added build architectures: `armv7` and `armv7s`.

---

## 1.2.1 - 2019-12-05
### Added
Configuration for ICE server:

```
NXMClientConfig *config = [[NXMClientConfig alloc] initWithApiUrl:restUrl
                                                     websocketUrl:wsUrl
                                                           ipsUrl:ipsUrl
                                                    iceServerUrls:iceUrls];
[NXMClient setConfiguration:config]
```

This configuration is optional and a default will be set if not specified.

Note: `setConfiguration` should be used before accessing `NXMClient.shared`.

### Fixed
Corrected nil values for `fromMember` for `NXMConversation` events.

---

## 1.2.0 - 2019-12-03

### Added
`NXMClient`'s `getConversationsPageWithSize:order:completionHandler:` method to get conversations with paging.

`NXMConversationsPage`, which represents the retrieved page, provides the following instance methods

- `hasNextPage` / `hasPreviousPage` to check if forward/backward page retrieval is possible and
- `nextPage:` / `previousPage:` to asynchronously retrieve the next/previous page.

### Changed
`NXMClient`'s `getConversationWithUUid:completionHandler:` method's name typo (now called `getConversationWithUuid:completionHandler:`).

---

## 1.1.1 - 2019-11-21

### Added

`NXMClientConfig` object in order to change data center configuration. How to use:

```
[NXMClient setConfiguration:NXMClientConfig.DC]
```

`NXMClient setConfiguration` is optional, configuration will set to a default value.
Note: you most call `setConfiguration` method before using `NXMClient.shared`.

---

## 1.1.0 - 2019-11-14

### Fixed

- iOS 13 push notifications support
- Start server call stability
- Receiving a DTMF event in call and conversation

### Added

`NXMConversationDelegate` did receive DTMF event method:

```
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveDTMFEvent:(nullable NXMDTMFEvent *)event;
```

### Changed

`NXMClient` - client enable push notifications method changed.
`param pushKitToken` - only for VoIP push (incoming calls).
`param userNotificationToken` - all push types:

```
- (void)enablePushNotificationsWithPushKitToken:(nullable NSData *)pushKitToken
                          userNotificationToken:(nullable NSData *)userNotificationToken
                                      isSandbox:(BOOL)isSandbox
                              completionHandler:(void(^_Nullable)(NSError * _Nullable error))completionHandler;
```

## Version 1.0.0 - 2019-09-05

### Fixed

- `NexmoClient` when disconnected returns error callback for all function.
- `CallMember` status calculated by the current leg status.
- `CallMember` supports failed, busy, timeout and canceled statuses.
- Supports member invited.
- `Conversation` has media methods.
- `NexmoClient` is now singleton.
- Call method changed to string instead of array.
- `NexmoClient` delegate methods renamed.

### Added

- Added conversation media:

```objective-c
NXMConversation myConversation;
[myConversation enableMedia];   // my media will be enabled
[myConversation disableMedia];  // my media will be disabled
```
​
Added invite member:

```objective-c
NXMConversation myConversation;
[myConversation inviteMemberWithUsername:@"someUsername"
                      completion:myCompletionBlock];
```
​
- Added the member state initiator:

```objective-c
NXMMember *member = someMember;
NSDictionary<NSValue *, NXMInitiator *> *initiators = member.initiators; 
​
NXMInitiator leftStateInitiator = initiators[NXMMemberStateLeft];
leftStateInitiator.isSystem;
leftStateInitiator.userId;
leftStateInitiator.memberId;
leftStateInitiator.time;
```

Added `NXMConversationUpdateDelegate` to notify on member updates like media,leg, and state.
Added `updatesDelegate` property to `NXMConversation`:

```objective-c
@property (nonatomic, weak, nullable) id <NXMConversationUpdateDelegate> updatesDelegate;
```

Example:

```objective-c
@interface MyClass() <NXMConversationUpdateDelegate>
@implementation MyClass
​
- (void)setConversation:(NXMConversation *conversation) {
	conversation.updatesDelegate(self); // register to conversation updatesDelegate
}
​
- (void)conversation:(nonnull NXMConversation *)conversation didUpdateMember:(nonnull NXMMember *)member withType:(NXMMemberUpdateType)type {
	if (type == NXMMemberUpdateTypeState) {
		// the member state changed
	}
​
	if (type == NXMMemberUpdateTypeMedia) {
		// the member media changed
	}
}
@end
```
​
### Changed
​
- `NXMClient` is now a singleton:

```objective-c
NXMClient.shared // the shared instance of NXMClient
```

Renamed:

```objective-c
@property (nonatomic, readonly, nullable, getter=getToken) NSString *authToken; // was token
​
// was - (void)login;
- (void)loginWithAuthToken:(NSString *)authToken;
​
// was - (void)refreshAuthToken:(nonnull NSString *)authToken;
- (void)updateAuthToken:(nonnull NSString *)authToken;
​
// was callees array
- (void)call:(nonnull NSString *)callee
    callHandler:(NXMCallHandler)callHandler
    delegate:(nullable id<NXMCallDelegate>)delegate
  completion:(void(^_Nullable)(NSError * _Nullable error, NXMCall * _Nullable call))completion;
completionHandler:(void(^_Nullable)(NSError * _Nullable error, NXMCall * _Nullable call))completionHandler;
```
​
- `NXMClientDelegate` renamed:

```objective-c
@protocol NXMClientDelegate <NSObject>
​
// was - (void)connectionStatusChanged:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason;
- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason;
​
// was - (void)incomingCall:(nonnull NXMCall *)call;
- (void)client:(nonnull NXMClient *)client didReceiveCall:(nonnull NXMCall *)call;
​
// was - (void)incomingConversation:(nonnull NXMConversation *)conversation;
- (void)client:(nonnull NXMClient *)client didReceiveConversation:(nonnull NXMConversation *)conversation;
@end
```
​
- `NXMConversation` `otherMembers` property renamed to `allMembers`:

```objective-c
NXMConversation myConversation = someConversation;
NSArray<NXMMember *> * allMembers = myConversation.allMembers // return the all conversation members
​
- (void)joinMemberWithUsername:(nonnull NSString *)username // username instead of userId
```
​
- `NXMConversationDelegate` renamed methods:

```objective-c
// was - (void)customEvent:(nonnull NXMCustomEvent *)customEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveCustomEvent:(nonnull NXMCustomEvent *)event;
​
// was - (void)textEvent:(nonnull NXMMessageEvent *)textEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveTextEvent:(nonnull NXMTextEvent *)event;
​
// was - (void)attachmentEvent:(nonnull NXMMessageEvent *)attachmentEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveImageEvent:(nonnull NXMImageEvent *)event;
​
// - (void)messageStatusEvent:(nonnull NXMMessageStatusEvent *)messageStatusEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveMessageStatusEvent:(nonnull NXMMessageStatusEvent *)event;
​
// was - (void)typingEvent:(nonnull NXMTextTypingEvent *)typingEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveTypingEvent:(nonnull NXMTextTypingEvent *)event;
​
// was - (void)memberEvent:(nonnull NXMMemberEvent *)memberEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveMemberEvent:(nonnull NXMMemberEvent *)event;
​
// was - (void)legStatusEvent:(nonnull NXMLegStatusEvent *)legStatusEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveLegStatusEvent:(nonnull NXMLegStatusEvent *)event;
​
// was - (void)mediaEvent:(nonnull NXMEvent *)mediaEvent;
- (void)conversation:(nonnull NXMConversation *)conversation didReceiveMediaEvent:(nonnull NXMMediaEvent *)event;
```
​
Use `username` instead of `userId`.

`NXMCallDelegate` renamed:

```objective-c
// was - (void)statusChanged:(nonnull NXMCallMember *)callMember;
- (void)didUpdate:(nonnull NXMCallMember *)callMember status:(NXMCallMemberStatus)status; 
- (void)didUpdate:(nonnull NXMCallMember *)callMember muted:(BOOL)muted;
​
// was - (void)DTMFReceived:(nonnull NSString *)dtmf callMember:(nonnull NXMCallMember *)callMember;
- (void)didReceive:(nonnull NSString *)dtmf fromCallMember:(nonnull NXMCallMember *)callMember;
```
​
`NXMEvent` and `NXMMemberEvent` add member object instead of `memberId`:

```objective-c
@property (nonatomic, readonly, nonnull) NXMMember *member;
```
​
`NXMImageInfo` renamed properties:

```objective-c
@property NSInteger sizeInBytes; // was size
@property NXMImageSize size; // was type
```
​
`NXMMessageStatusEvent` renamed property:

```objective-c
@property NSInteger referenceEventId; // was refEventId
```
​
`NexmoClient` logger exposed - `NXMLogger` object:

```objective-c
[NXMLogger setLogLevel:NXMLoggerLevelDebug];
NSArray *logNames = [NXMLogger getLogFileNames];
```

- Removed `NXMLoggerDelegate`:

```objective-c
NXMClient myClient
[myClient setLoggerDelegate:LoggerDelegate];
```

---

## Version 0.3.0 - June 03, 2019

### Added

- Interoperability with the JS and Android SDKs - Calls can now be placed between apps using the iOS, JS or Android SDKs.

### Changed

- `NXMCallMember` - added member channel with direction data:

```objective-c
@interface NXMCallMember : NSObject
...
@property (nonatomic, readonly, nullable) NXMChannel *channel;
...
@end
```

```objective-c
@interface NXMChannel : NSObject

@property (nonatomic, readonly, nonnull) NXMDirection *from;
@property (nonatomic, readonly, nullable) NXMDirection *to;

@end
```

```objective-c
@interface NXMDirection : NSObject

@property (nonatomic, assign) NXMDirectionType type;
@property (nonatomic, copy, nullable) NSString *data;

@end
```

### Removed

- `NXMCallMember`'s `phoneNumber` and `channelType` were removed.

---

## Version 0.2.56 - January 24, 2019

### Added

- Change log file.

### Changed

- Memory management improvements.
- Fetch missing and new events on network changes.
- Returning User objects instead of Ids.
- Bug fixes.
- Add `non-null` or `nullable` to properties.
- Rename `call.decline` to `call.reject`.

## Version 0.1.52 - January 01, 2019

- Initial beta release with basic call and chat features.

	- Please refer to list of features and usage  
	  https://developer.nexmo.com/

	- **Cocoapods**  
	  https://cocoapods.org/pods/nexmoclient
