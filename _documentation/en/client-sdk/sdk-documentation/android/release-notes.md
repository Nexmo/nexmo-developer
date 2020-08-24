---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

## Version 2.6.5 - Aug 24, 2020

### Enhancements

- Improved SDK logs implementation and socket connection stability.

## Version 2.6.4 - May 19, 2020

### New

- We have split our artifacts from this version, so custom maven repository has to be added to the project:

```groovy
    //Groovy - build.gradle
    allprojects {
        repositories {
            …
            maven {
                url "https://artifactory.ess-dev.com/artifactory/gradle-dev-local"
            }
        }
    }
```

```kotlin
    // Kotlin Gradle script  - build.gradle.kts
    allprojects {
        repositories {
        …
            maven("https://artifactory.ess-dev.com/artifactory/gradle-dev-local")
        }
    }
```

### Enhancements

- Improved user-agent SDK version reporting.

## Version 2.6.3 - May 4, 2020

### Fixed

- Changed visibility of `Nexmo.page.isPrevPageExist()` to `public`.

## Version 2.6.2 - April 29, 2020

### Fixed

- Potential `NullPointerException` when processing push notifications during client login.

## Version 2.6.1 - April 22, 2020

### Added

- Expose the interface `NexmoDTMFEventListener` to subscribe for DTMF events on `NexmoConversation`.

## Version 2.6.0 - April 20, 2020

### Added

- Expose connection status `isConnected` in `NexmoClient`.

```java
    NexmoClient.get().isConnected()
```

### Fixed

- Avoid invoking `login` multiple times when the user is already connected.

## Version 2.5.1 - April 20, 2020

### Enhancements

- Improved single ICE candidate gathering implementation.

## Version 2.5.0 - March 25, 2020

### Added

- Add `useFirstIceCandidate` parameters to `NexmoClient.Builder`

```java
    nexmoClient = new NexmoClient.Builder().useFirstIceCandidate(true/false).build(context);
```

---

## Version 2.4.0 - March 3 , 2020

### Added

- Add filter by state to `getConversationsPage`  in `NexmoClient`.

```java
    NexmoClient.get().getConversationsPage(50, NexmoPageOrderDesc, "JOINED", new NexmoRequestListener<NexmoConversationsPage>(){
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

## Version 2.3.0 - February 11, 2020

### Added

- Add `updateAsDelivered` and `UpdateAsSeen` to `NexmoAttachmentEvent` and `NexmoTextEvent` as helper method
to update event locally after `markAsSeen` or `markAsDelivered` has been successful.

```kotlin
  NexmoTextEvent.markAsDelivered(object: NexmoRequestListener<Any>{
       override fun onSuccess(result: Any?) {
       Log.d(TAG, TAG + "onTextEvent.markAsDelivered():onSuccess with: " + result.toString())

            NexmoTextEvent.updateAsDelivered(my_member_id, Date.now())

       }
   })
```

### Fixed

- Fix `markAsSeen` and `markAsDelivered` for `NexmoTextEvent` and `NexmoAttachmentEvent`

### Changed

- Upgrade dependency libraries please add to your build Gradle

```groovy
android {
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}
```

---

## Version 2.2.0 - January 31, 2020

### Added

- Add support for Custom Push Notifications, using `processNexmoPush()` ,`processPushNotification()` is deprecated

```kotlin
if (NexmoClient.isNexmoPushNotification(message!!.data)) {
    val pushListener = object : NexmoPushEventListener {
            override fun onIncomingCall(nexmoCall: NexmoCall?) {
                Log.d(TestAppMessagingService.TAG, "$TAG:TestAppMessagingService:onIncomingCall() with: $nexmoCall")
            }
            override fun onError(nexmoError: NexmoApiError?) {
                Log.d(TestAppMessagingService.TAG, "$TAG:TestAppMessagingService:onError() with: $nexmoError")
            }
            override fun onNewEvent(event: NexmoEvent?) {
                Log.d(TestAppMessagingService.TAG, "$TAG:TestAppMessagingService:onNewEvent() with: $event")
            }
        }
    NexmoPushPayload nexmoPushPayload = nexmoClient.processNexmoPush(message!!.data, pushListener)
    when(nexmoPushPayload.pushTemplate){
        Default ->
            // you can use nexmoPushPayload.eventData if needed
        Custom ->
            // got nexmo custom push. 😀
            // you should parse nexmoPushEvent.customData your backend had defined.
    }
}
```

- Add `markAsDelivered()` method to `NexmoTextEvent` and `NexmoAttachmentEvent`

```kotlin
  NexmoTextEvent.markAsDelivered(object: NexmoRequestListener<Any>{
       override fun onSuccess(result: Any?) {
       Log.d(TAG, TAG + "onTextEvent.markAsDelivered():onSuccess with: " + result.toString())
       }
       override fun onError(error: NexmoApiError) {
       Log.d(TAG, TAG + "onTextEvent.markAsDelivered():onError with: " + error)
        }
   })
```
   
 - Add `markAsSeen()` method to `NexmoTextEvent` and `NexmoAttachmentEvent`

```kotlin
  NexmoAttachmentEvent.markAsSeen(object: NexmoRequestListener<Any>{
       override fun onSuccess(result: Any?) {
       Log.d(TAG, TAG + "onAttachmentEvent.markAsSeen():onSuccess with: " + result.toString())
       }
       override fun onError(error: NexmoApiError) {
       Log.d(TAG, TAG + "onAttachmentEvent.markAsSeen():onError with: " + error)
        }
   })
```

---

## Version 2.1.2 - January 12, 2020

### Added
- Add annotation of `PermissionRequired` for function that start media: `NexmoClient.call` , `NexmoCall.answer` , `NexmoConvesation.enableMedia`

```java
    class MyAcitivity MakeCallActivity extends Activity {
        @Override public void onCreate(Bundle savedInstanceState){
            //Call requires permission which may be rejected by user: 
            //code should explicitly check to see if permission is available (with 'checkPermission') 
            //or explicitly handle a potential 'SecurityException'
            NexmoClient.get().call("1234567890", NexmoCallHandler.SERVER, new NexmoRequestListener<NexmoCall>(){
                @Override 
                void onError(NexmoApiError error) {
                    Log.d("NexmoCallListener", "onError call:" + error.toString())
                }
                
                @Override 
                void onSuccess(NexmoCall call) {
                    Log.d("NexmoCallListener", "onSuccess call:" + cal.toString())
        
                }
            });
        }
    }
```

### Removed
- Remove require for permission `PROCESS_OUTGOING_CALLS` 
- Remove require for permission `READ_PHONE_STATE`

---

## Version 2.1.0 - January 01, 2020

### Added

- Add `clearNexmoEventsListeners` method in `NexmoConversation` to clear all listeners

```java
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

```java
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

```java
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

```java
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

```java
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

```java
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

```java
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

```java
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

```java
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

```java
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
```java
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

```java
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

```java
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

```java
    nexmoClient = new NexmoClient.Builder().iceServerUrls(new String[]{"stun/turn servr url"}).build(context);
```

### Fixed
- fix Push Notification incoming call issue

---

## Version 1.0.3 - 2019-11-20

###Changes

- change signature of `NexmoClient.login()`, remove `NexmoRequestListener<NexmoUser>` parameter:

```java
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

```java
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

```java
    NexmoClient.get().getConversationsPage(50, NexmoPageOrderDesc, new NexmoRequestListener<NexmoConversationsPage>(){
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

```java
    NexmoConversation myConversation;
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
