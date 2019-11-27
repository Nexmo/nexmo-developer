---
title: iOS
language: ios
---

# Overview

On incoming events such as a new message, or an incoming call, the user often expects to receive a push notification, if the app is not active.

This guide explains how to configure your iOS app to receive push notifications from the Nexmo Client SDK.

## Create a push certificate

Log in to your Apple developer account and [create a push certificate](https://developer.apple.com/account/ios/certificate/) for your app. Find more details in [Apple's official documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns). 

Download your certificate. In the next step the downloaded certificate name is referred to as `applecert.p12`.

## Upload your certificate

Obtain a `jwt_dev`, which is a `jwt` without a `sub` claim. More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

Get your Nexmo Application ID, `app_id`. It can be obtained from [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).

Run the following Curl command, replacing `jwt_dev`, `applecert.p12`, `app_id` with your values:

```sh
hexdump -ve '1/1 "%.2x"' < applecert.p12 > applecert.pfx.hex
hextoken=`cat applecert.pfx.hex`

curl -v -X PUT \
   -H "Authorization: Bearer $jwt_dev" \
   -H "Content-Type: application/json" \
   -d "{\"token\":\"$hextoken\"}" \
   https://api.nexmo.com/v1/applications/$app_id/push_tokens/ios
```

## Integrate push notifications in your application

There are two types of push notifications that you can use:

* *VoIP push* - the better fit for applications that use Nexmo In-App Voice functionality.
* *Regular push*

### Integrate VoIP push

VoIP push notifications are suitable for VoIP apps. Among other benefits, it allows you to receive notifications even when the app is terminated.

To integrate VoIP push in your app, follow these steps:

#### 1. Enable VoIP push notifications for your app
   
   In Xcode, under *your target*, open *Capabilities*:

   * Enable Push Notifications
   * Enable background modes with Voice over IP selected

#### 2. Import `PushKit`, adopt `PKPushRegistryDelegate`, and sign up to VoIP notifications

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/pushkit'
```

#### 3. Implement the following delegate method and add the the code to handle an incoming VoIP push notification

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/pushkit-delegate-voip'
```

For the SDK to process the push properly `NXMClient` should be logged in.

#### 4. Enable Nexmo push notifications through a logged in `NXMClient`

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/enable-notifications-voip'
```

* `'isSandbox'` is `YES`/`true` for an app using the Apple sandbox push servers and NO/false for an app using the Apple production push servers.  

* `'deviceToken'` is the token received in `application:didRegisterForRemoteNotificationsWithDeviceToken:`.

### Integrate Regular Push

If your app is not a VoIP app, you should use regular push notifications. Nexmo push is sent silently to allow you control over what is presented to your user.  

To receive silent push notifications in your app use the following steps.

#### 1. Enable push notifications for your app

In Xcode under your target, open *Capabilities*:

    * Enable Push Notifications.
    * Enable background modes with remote notifications selected.

#### 2. Register for device token

In your app delegate implement the following delegate method to receive a device token:  

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/device-token'
```

#### 3. Handle an incoming push notification

In your app delegate adopt the `UNUserNotificationCenterDelegate`.

Implement the following delegate method and add the the code to handle an incoming push notification:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/incoming'
```

For the SDK to process the push properly the `NXMClient` needs to be logged in.

#### 4. Enable Nexmo push notifications through a logged in `NXMClient`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/enable-notifications'
```

* `'isSandbox'` is YES/true for an app using the Apple sandbox push servers and NO/false for an app using the Apple production push servers.  
* `'deviceToken'` is the token received in `application:didRegisterForRemoteNotificationsWithDeviceToken:`.

## Conclusion

In this guide you have seen how to set up push notifications.
