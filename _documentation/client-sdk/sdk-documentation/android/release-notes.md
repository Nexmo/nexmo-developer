---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

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