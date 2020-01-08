---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes
## Version 2.1.0 - January 01, 2020

### Added
- Add `clearNexmoEventsListeners` method in `NexmoConversation` to clear all listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
            //Add listener to events
            myConversation.addMemberEventListener(new NexmoMemberEventListener(){
                    //implement functions
                }
            });
            
            myConversation.addCustomEventListener(new NexmoCustomEventListener(){
                    //implement functions
            });
            //Add more listeners
        }
        
        @Override public void onStop(){
            //Clear all listeners
            myConversation.clearNexmoEventsListeners();
        }
    }
```
- Add `clearMemberEventListeners` method in `NexmoConversation` to clear all `NexmoMemberEventListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoMemberEvent
            myConversation.addMemberEventListener(new NexmoMemberEventListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearMemberEventListeners();
        }
    }
```
- Add `clearCustomEventListeners` method in `NexmoConversation` to clear all `NexmoCustomEventListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoCustomEvent
            myConversation.addCustomEventListener(new NexmoCustomEventListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearCustomEventListeners();
        }
    }
```
- Add `clearLegStatusEventListeners` method in `NexmoConversation` to clear all `NexmoLegStatusEventListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoLegStatusEvent
            myConversation.addLegStatusEventListener(new NexmoLegStatusEventListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearLegStatusEventListeners();
        }
    }
```
- Add `clearDTMFEventListeners` method in `NexmoConversation` to clear all `NexmoDTMFEventListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoDTMFEvent
            myConversation.addDTMFEventListener(new NexmoDTMFEventListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearDTMFEventListeners();
        }
    }
```
- Add `clearMessageEventListeners` method in `NexmoConversation` to clear all `NexmoMessageEventListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoMessageEvent
            myConversation.addMessageEventListener(new NexmoMessageEventListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearMessageEventListeners();
        }
    }
```
- Add `clearNexmoConversationListeners` method in `NexmoConversation` to clear all `NexmoConversationListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoConversation
            myConversation.addNexmoConversationListener(new NexmoConversationListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearNexmoConversationListeners();
        }
    }
```
- Add `clearTypingEventListeners` method in `NexmoConversation` to clear all `NexmoTypingEventListener` listeners

```
    class MyActivity extends Activity{
        NexmoConversation myConversation;
        
        @Override public void onStart(){
        //Add listener to NexmoTypingEvent
            myConversation.addTypingEventListener(new NexmoTypingEventListener(){
            
            });
        }
        
        @Override public void onStop(){
            myConversation.clearTypingEventListeners();
        }
    }
```
- Add `NexmoMember` parameter to `NexmoMemberEvent` with respect to the `NexmoMember` acted on by: 

```
    NexmoConversation myConversation;
    myConversation.addMemberEventListener(new NexmoMemberEventListener{
        void onMemberInvited(@NonNull final NexmoMemberEvent event){
            //The invitee member
            event.getMember()
            //the inviter member
            event.getFromMember()
        }
    });
```

### Fixed
- dispatch `NexmoAttachmentEvent` with respect to `NexmoConversation`

```
    NexmoConversation myConversation;
    myConversation.addNexmoMessageEventListener(new NexmoMessageEventListener(){
        
        void onAttachmentEvent(@NonNull final NexmoAttachmentEvent attachmentEvent){
            //handle attachment event
        }    
    });
```
- dispatch `NexmoMediaEvent` with respect to `NexmoConveration`
- dispatch `NexmoMediaActionEvent` with respect to `NexmoConveration`
- make `NexmoDTMFEvent` inheritance `NexmoEvent`
- `NexmoTextEvent.equals` to use `super.equals`
- `NexmoConversation.getCreationDate` to return `Date` java object 
- `NexmoEvent.getCreationDate` fix `IllegalArgumentException`

---

## 2.0.0 - 2019-12-22

### Added
- Add filter by `EventType` in `NexmoConversation.getEvents`
```
    NexmoConversation myConversation
    //Get all text event for a specifc conversation
    myConversation.getEvents(10, NexmoPageOrderDesc, "text", new NexmoRequestListener<NexmoEventsPage> {
        void onError(@NonNull NexmoApiError error){
        }
        
        void onSuccess(@Nullable NexmoEventsPage result){
            Collection<NexmoEvent> textEvents =  result.getData()
        }
    });
    //Get all member event for a specifc conversation
    myConversation.getEvents(10, NexmoPageOrderDesc, "member:*", new NexmoRequestListener<NexmoEventsPage> {
        void onError(@NonNull NexmoApiError error){
        }
        
        void onSuccess(@Nullable NexmoEventsPage result){
            Collection<NexmoEvent> memberEvents =  result.getData()
        }
    });
```

### Changed
- `NexmoDeliveredEvent` remove `InitialEvent` parameter and add `InitialEventId`
- `NexmoSeenEvent` remove `InitialEvent` parameter and add `InitialEventId`

### Fixed
- Support for DTLS in WebRTC
- `NexmoConversationsPage.getPrev()` return the conversations from the right cursor

---

## 2.0.0 - 2019-12-22

### Added
- Add filter by `EventType` in `NexmoConversation.getEvents`

```
    NexmoConversation myConversation
    //Get all text event for a specifc conversation
    myConversation.getEvents(10, NexmoPageOrderDesc, "text", new NexmoRequestListener<NexmoEventsPage> {
        void onError(@NonNull NexmoApiError error){
        }
        
        void onSuccess(@Nullable NexmoEventsPage result){
            Collection<NexmoEvent> textEvents =  result.getData()
        }
    });
    //Get all member event for a specifc conversation
    myConversation.getEvents(10, NexmoPageOrderDesc, "member:*", new NexmoRequestListener<NexmoEventsPage> {
        void onError(@NonNull NexmoApiError error){
        }
        
        void onSuccess(@Nullable NexmoEventsPage result){
            Collection<NexmoEvent> memberEvents =  result.getData()
        }
    });
```

### Changed
- `NexmoDeliveredEvent` remove `InitialEvent` parameter and add `InitialEventId`
- `NexmoSeenEvent` remove `InitialEvent` parameter and add `InitialEventId`

### Fixed
- Support for DTLS in WebRTC
- `NexmoConversationsPage.getPrev()` return the conversations from the right cursor

---

## 1.2.0 - 2019-12-16 

### Added
- Add filter by `EventType` in `NexmoConversation.getEvents`

```
    NexmoConversation myConversation
    //Get all text event for a specifc conversation
    myConversation.getEvents(10, NexmoPageOrderDesc, "text", new NexmoRequestListener<NexmoEventsPage> {
        void onError(@NonNull NexmoApiError error){
        }
        
        void onSuccess(@Nullable NexmoEventsPage result){
            Collection<NexmoEvent> textEvents =  result.getData()
        }
    });
    //Get all member event for a specifc conversation
    myConversation.getEvents(10, NexmoPageOrderDesc, "member:*", new NexmoRequestListener<NexmoEventsPage> {
        void onError(@NonNull NexmoApiError error){
        }
        
        void onSuccess(@Nullable NexmoEventsPage result){
            Collection<NexmoEvent> memberEvents =  result.getData()
        }
    });
```

### Fixed
- Support for DTLS in WebRTC

---
## Version 1.1.0 - 2019-12-04

### Changes
- Add `iceServerUrls` parameters to `NexmoClient.Builder`

```
    nexmoClient = new NexmoClient.Builder().iceServerUrls(new String[]{"stun/turn servr url"}).build(context);
``` 

### Fixed
- fix Push Notification incoming call issue

---

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
