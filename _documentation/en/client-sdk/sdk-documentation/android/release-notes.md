---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

## Version 1.0.3 - 2019-11-20

###Changes

- change signature of `NexmoClient.login()`, remove `NexmoRequestListener<NexmoUser>` parameter:

```
    nexmoClient = new NexmoClient.Builder().build(context);
    nexmoClient.setConnectionListener(new NexmoConnectionListener() {
          @Override
          public void onConnectionStatusChange(ConnectionStatus connectionStatus, ConnectionStatusReason connectionStatusReason) {
              switch (connectionStatus){
                case CONNECTED:
                    //the client is connected to the server - the login successed 
                case DISCONNECTED:
                case CONNECTING:
                case UNKNOWN:
                    //the client is not connected to the server - the login failed/not yet successed 
            } 
          });
    NexmoClient.login("MY_AUTH_TOKEN")
```

- change signature of `NexmoPushEventListener.onIncomingCall()`, remove `MemberEvent` parameter:

```
    override public void onMessageReceived(@Nullable RemoteMessage message) {
    if (NexmoClient.isNexmoPushNotification(message.getData())) {
                handleNexmoPushForLoggedInUser(message)
            } 
    }
    nexmoClient.processPushNotification(message.getData(), new NexmoPushEventListener(){
        public void onIncomingCall(NexmoCall nexmoCall){
        }
        public void onNewEvent(NexmoEvent event){
        }

        public void onError(NexmoApiError error){
        }
    })
```

### Fixed

- fix `NexmoConversation.sendAttachment` bug
- fix `NexmoAttachmentEvent` received from backend
- fix race condition bug cause drop calls
- fix bug in push notification

## Version 1.0.2 - 2019-11-11

### Changes

- Rename `GetConversationsPage` to `GetConversations`
- Rename `GetEventsPage` to `GetEvents`
- `NexmoClient.GetConversations` default `pageSize` is 10
- `NexmoConversation.GetEvents` default `pageSize` is 10

## Version 1.0.1

### New

- Add `getConversationsPage` in `NexmoClient`
```NexmoClient.get().getConversationsPage(50, NexmoPageOrderDesc, new NexmoRequestListener<NexmoConversationsPage>(){
   void onError(@NonNull NexmoApiError error){

   }
   void onSuccess(@Nullable NexmoConversationsPage result){
        //Get the current page conversations -Sync
        Collection<NexmoConversation> conversations = result.getData()
        //Get the next page -Async
        result.getNext(new NexmoRequestListener<NexmoConversationsPage>(){
        void onError(@NonNull NexmoApiError error){
        
           }
           void onSuccess(@Nullable NexmoConversationsPage result){
            
           }
        })
        
        //Get the previous page -Async
        result.getPrev(new NexmoRequestListener<NexmoConversationsPage>(){
        void onError(@NonNull NexmoApiError error){
        
           }
           void onSuccess(@Nullable NexmoConversationsPage result){
            
           }
        })
   }
});
```
- Add `getEventsPage` in `NexmoConversation`
```    NexmoConversation myConversation;
    ...
    myConversation.getEventsPage(50, NexmoPageOrderDesc, new NexmoRequestListener<NexmoEventsPage>(){
        void onError(@NonNull NexmoApiError error){
     
        }
        void onSuccess(@Nullable NexmoEventsPage result){
            //Current event page data -Sync
            Collection<NexmoEvent> events = result.getData();
            //Get the next page -Async
            result.getNext( new NexmoRequestListener<NexmoEventsPage>(){
                 void onError(@NonNull NexmoApiError error){
                     
                        }
                void onSuccess(@Nullable NexmoEventsPage result){
                }
            }
            );
            
            //Get the previous page -Async
            result.getPrev( new NexmoRequestListener<NexmoEventsPage>(){
                 void onError(@NonNull NexmoApiError error){
                     
                        }
                void onSuccess(@Nullable NexmoEventsPage result){
                }
            }
            );
        }
    );
``` 
### Removed
- remove `conversation.getEvents()`

### Fixed
- `NexmoConversation` `Parcelable` fixed 

## Version 1.0.0 - 2019-09-05

### Changed

- `NexmoClient` is a singleton and get only the Context as a mandatory parameter. To initialize `NexmoClient`:

```java
    NexmoClient nexmoClientInstance = NexmoClientBuilder.Builder().build(context);
```

- In order to set `NexmoConnectionListener`:

```java
    NexmoConnectionListener myConnectionListener = new NexmoConnectionListener{
    void onConnectionStatusChange(ConnectionStatus status, ConnectionStatusReason reason){
      Log.i("onConnectionStatusChange","status:" + status + " reason:" + reason);
    }
  }
  nexmoClientInstance.setConnectionListener(myConnectionListener);
```

- `NexmoClient` call function receives a single username or phone number:
  
```java
//IN APP CALL:
NexmoClient.get().call(callee, NexmoCallHandler.IN_APP, new NexmoRequestListener<NexmoCall>() {
    void onError(@NonNull NexmoApiError error){
    }
    void onSuccess(@Nullable NexmoCall result){
    }
});

//SERVER CALL:
NexmoClient.call(callee, NexmoCallHandler.SERVER, new NexmoRequestListener<NexmoCall>() {
    void onError(@NonNull NexmoApiError error){
    }
    void onSuccess(@Nullable NexmoCall result){
    }
});
```

- Removed `NexmoCallMember.getMember()`, and added getters:

```java
NexmoCallMember someCallMember;
NexmoUser user = someCallMember.getUser();
String memberId = someCallMember.getMemberId();
NexmoCallStatus statues = someCallMember.getStatus();
NexmoChannel channel = someCallMember.getChannel();
```

### New

- Android `minSDK` is now 23.
- `CustomEvents` support in `NexmoConversation`:

```java
//NexmoCustomEvent:NexmoEvent:
    String                  getCustomType()
    HashMap<String, Object> getData()
```

- `NexmoMedia` added to `NexmoConversation`, for audio features support within a `NexmoConversation` context:

```java
    NexmoMember someMember;
    NexmoMedia media = someMember.media;
    media.getEnabled();
    media.getMuted();
    media.getEarmuffed();
```

- `getNemxoEventType()` in `NexmoEvent` is public

### Fixed

- `NexmoCallMember.status` reflects the current leg status.
- Added guard to `NexmoClient` function to prevent calls while user is not connected.
- Updated `NexmoUser` missing values after login.

### Removed

- Removed `conversation.getUser()`. The current user can be accessed with: `NexmoClient.getUser()`.

### Added

- `NexmoConversation` send and receive `CustomEvent`s
- `NexmoCustomEvent`:`NexmoEvent`:
    `String`                  `getCustomType()`
    `HashMap<String, Object>` `getData()`
- `NexmoChannel` Object to `NexmoMember`.

```java
    NexmoMember someMember;
    NexmoChannel channel = someMember.channel;
```

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

* Support for parsing the `MemberId` who initiated a call.

### Fixed

* Improvements for cross platform in app calls

* Crash on processing push notifications without SDK initialization

* Crash on sending `markAsDelivered` event

-----
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

* Support for parsing the `MemberId` who initiated a call.

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
