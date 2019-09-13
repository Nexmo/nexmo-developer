---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

## 1.0.0 - 2019-09-05

### Fixed

- NexmoClient when disconnected returns error callback for all function.
- CallMember status calculated by the current leg status.
- CallMember supports failed, busy, timeout and canceled statuses.
- Supports member invited.
- Conversation has media methods.
- NexmoClient is now singelton.
- Call method changed to string instead of array.
- NexmoClient delegate methods renamed.

### Added

Added conversation media

```swift
NXMConversation myConversation;
[myConversation enableMedia];   // my media will be enabled
[myConversation disableMedia];  // my media will be disabled
```
​
Added invite member
```swift
NXMConversation myConversation;
[myConversation inviteMemberWithUsername:@"someUsername"
                      completion:myCompletionBlock];
```
​
Added the member state initiator.

```swift
NXMMember *member = someMember;
NSDictionary<NSValue *, NXMInitiator *> *initiators = member.initiators; 
​
NXMInitiator leftStateInitiator = initiators[NXMMemberStateLeft];
leftStateInitiator.isSystem; 
leftStateInitiator.userId; 
leftStateInitiator.memberId;
leftStateInitiator.time;
```
​
Added NXMConversationUpdateDelegate to notify on member updates like media,leg,state.
Added updatesDelegate property to NXMConversation.

```swift
@property (nonatomic, weak, nullable) id <NXMConversationUpdateDelegate> updatesDelegate;
```

Example
```swift

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
NXMClient is now singleton

```swift
NXMClient.shared // the shared instance of NXMClient
```
Renamed:

```swift
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
- NXMClientDelegate renamed:
```swift
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
NXMConversation otherMembers property renamed to allMembers.
```swift
NXMConversation myConversation = someConversation;
NSArray<NXMMember *> * allMembers = myConversation.allMembers // return the all conversation members
​
- (void)joinMemberWithUsername:(nonnull NSString *)username // username instead of userId
```
​
NXMConversationDelegate renamed methods:
```swift
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
Use username instead of userId
NXMCallDelegate Renamed:
```swift
// was - (void)statusChanged:(nonnull NXMCallMember *)callMember;
- (void)didUpdate:(nonnull NXMCallMember *)callMember status:(NXMCallMemberStatus)status; 
- (void)didUpdate:(nonnull NXMCallMember *)callMember muted:(BOOL)muted;
​
// was - (void)DTMFReceived:(nonnull NSString *)dtmf callMember:(nonnull NXMCallMember *)callMember;
- (void)didReceive:(nonnull NSString *)dtmf fromCallMember:(nonnull NXMCallMember *)callMember;
```
​
NXMEvent and NXMMemberEvent add member object instead of memberId:
```swift
@property (nonatomic, readonly, nonnull) NXMMember *member;
```
​
NXMImageInfo renamed properties
```swift
@property NSInteger sizeInBytes; // was size
@property NXMImageSize size; // was type
```
​
NXMMessageStatusEvent renamed property
```swift
@property NSInteger referenceEventId; // was refEventId
```
​
NexmoClient logger exposed - NXMLogger object
```swift
[NXMLogger setLogLevel:NXMLoggerLevelDebug];
NSArray *logNames = [NXMLogger getLogFileNames];
```
Removed NXMLoggerDelegate
```swift
NXMClient myClient
[myClient setLoggerDelegate:LoggerDelegate];
```

---

## Version 0.3.0 - June 03, 2019

### Added

- Interoperability with the JS and Android SDKs - Calls can now be placed between apps using the iOS, JS or Android SDKs.

### Changed

- `NXMCallMember` - added member channel with direction data

```swift
@interface NXMCallMember : NSObject
...
@property (nonatomic, readonly, nullable) NXMChannel *channel;
...
@end
```

```swift
@interface NXMChannel : NSObject

@property (nonatomic, readonly, nonnull) NXMDirection *from;
@property (nonatomic, readonly, nullable) NXMDirection *to;

@end

```

```swift
@interface NXMDirection : NSObject

@property (nonatomic, assign) NXMDirectionType type;
@property (nonatomic, copy, nullable) NSString *data;

@end
```

### Removed

- `NXMCallMember`'s `phoneNumber` and `channelType` were removed




## Version 0.2.56 - January 24, 2019

### Added
- Change log file.

### Changed
- Memory management improvements.
- Fetch missing and new events on network changes.
- Returning User objects instead of Ids.
- Bug fixes.
- Add non-null or nullable to properties
- Rename call.decline to call.reject


## Version 0.1.52 - January 01, 2019

- Initial beta release with basic call and chat features.

	- Please refer to list of features and usage  
	  https://developer.nexmo.com/

	- **Cocoapods**  
	  https://cocoapods.org/pods/nexmoclient
