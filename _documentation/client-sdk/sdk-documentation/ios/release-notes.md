---
title: Release Notes
description: Release notes. A list of most important fixes and new features for Client SDK.
navigation_weight: 0
---

# Release Notes

## Version 0.3.0 - June 03, 2019

### Added

- Calls JS and Native SDKs support.

### Changed

- Add member channel and direction data
```
NXMCallMember
@property (nonatomic, readonly, nullable) NXMChannel *channel;


NXMChannel channel {
	NXMDirection from {
		NXMDirectionType type,
		NSString Data
	},
	NXMDirection to {
		NXMDirectionType type,
		NSString Data
	}
}
```

Deprecated
```
NXMCallMember
@property (nonatomic, copy, nullable) NSString *phoneNumber;
@property (nonatomic, copy, nonnull) NSString *channelType;
```

## Version 0.2.56 - January 24, 2019

### Added
- Change log file.

### Changed
- Memory managment improvments.
- Fetch missing and new events on network changes.
- Returning User objects instead of Ids.
- Bug fixes.
- Add nonnull or nullable to properties
- Rename call.decline to call.reject.


## Version 0.1.52 - January 01, 2019

- Initial beta release with basic call and chat features.

	- Please refer to list of features and usage  
	  https://developer.nexmo.com/

	- **Cocoapods**  
	  https://cocoapods.org/pods/nexmoclient