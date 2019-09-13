---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

## 1.0.0 - 2019-09-05

### Changed

- NexmoClient is a singleton and get only the Context as a mandatory paramerter
    NexmoClient nexmoClientInstance = NexmoClientBuilder.Builder().build(context.getApplicationContext());
- in order to set the NexmoConnectionListener call setConnectionListener
    NexmoConnectionListener myConnectionListener = new NexmoConnectionListener{
    void onConnectionStatusChange(ConnectionStatus status, ConnectionStatusReason reason){
      Log.i("onConnectionStatusChange","status:" + status + " reason:" + reason);
    }
  }
  nexmoClientInstance.setConnectionListener(myConnectionListener);
- NexmoClient call function receive single username/phonenumber
  IN APP CALL
  NexmoClient.call(username, NexmoCallHandler.IN_APP, new NexmoRequestListener<NexmoCall>() {
   void onError(@NonNull NexmoApiError error){
   }
   void onSuccess(@Nullable NexmoCall result){
   }
  });
  SEREVER CALL
  NexmoClient.call([userName/phoneNumber], NexmoCallHandler.SERVER, new NexmoRequestListener<NexmoCall>() {
   void onError(@NonNull NexmoApiError error){
   }
   void onSuccess(@Nullable NexmoCall result){
   }
  });

- Removed NexmoCallMember getMember getter.
- NexmoCallMember add getter:
'''java
NexmoCallMember someCallMember;
NexmoUser user = someCallMember.getUser();
String memberId = someCallMember.getMemberId();
NexmoCallStatus statues = someCallMember.getStatus();
NexmoChannel channel = someCallMember.getChannel();
'''

### New

- Update Android minSDK to 26
- NexmoCallMember status calculated by the current leg status.
- Update default log level to NONE
- Add guard to NexmoClient function to prevent calls while user is not connected
- Add the member state initiator.
- Fill the NexmoUser missing values on login.
- getNemxoEventType in NexmoEvent is public

### Added

- NexmoConversation send and receive CustomEvents
- NexmoCustomEvent:NexmoEvent:
    String                  getCustomType()
    HashMap<String, Object> getData()

- Added NexmoMedia Object.
'''java
    NexmoMember someMember;
    NexmoMedia media = someMember.media;
    media.getEnabled();
    media.getMuted();
    media.getEarmuffed();
'''  
- Added NexmoChannel Object.
'''java
    NexmoMember someMember;
    NexmoChannel channel = someMember.channel;
'''  

### Removed

- remove conversation.getUser()

---

## Version 0.3.0 - June 4, 2019

This version contains many small bug fixes and stability improvements. The major changes are:

### Added

* `NexmoChannel` was added to `NexmoMember`, to exposes the [Channel](/conversation/concepts/channel) data when exists. The `NexmoChannel` object includes `to` and `from` fields with the data of the Channel destination and origin.

### **Breaking Changes**

#### Removed

* `NexmoMember.ChannelType` - should be replaced with `NexmoMember.Channel.from.type`
  
* `NexmoMember.ChannelData` - should be replaced with `NexmoMember.Channel.from.data`

#### Changed

* `NexmoLoginListener` was improved and updated its interface:

* `onLoginStateChange()` and `onAvailabilityChange()` were **removed**

* `onConnectionStatusChange(ConnectionStatus status, ConnectionStatusReason reason)` was added, as an aggregated and improved version of the above methods

### Added

* Support for parsing the MemberId who initiated a call.

### Fixed

* Improvements for cross platform in app calls

* Crash on processing push notifications without SDK initialization

* Crash on sending `markAsDelivered` event

-----

## Version 0.2.67 - April 17, 2019

### Added 
    
* [Support send and receive DTMF during calls](/in-app-voice/guides/send-and-receive-dtmf)

* Emulator support

### Fixed

* Bugs on updating `CallMember` statuses
