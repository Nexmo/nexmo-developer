---
title: iOS
language: ios
---

# Overview

On incoming events such as a new message, or an incoming call, the user often expects to receive a push notification, if the app is not active.

There are two types of push notifications that you can use:

* VoIP push *([PushKit](https://developer.apple.com/documentation/pushkit))* - the better fit for applications that use Vonage In-App Voice functionality.
* Regular push *([UserNotifications](https://developer.apple.com/documentation/usernotifications))* - the better fit for applications that use Vonage In-App Chat functionality.

This guide will cover how to VoIP push notifications with the Client SDK.

## Create a push certificate

Apple Push Notifications service (APNs) uses certificate-based authentication to secure the connections between APNs and Vonage servers. So you will need to create a certificate and upload it to the Vonage Servers.

### Adding a push notification capability

To use push notifications you are required to add the push notification capability to your Xcode project. To do this select your target and select *Signing & Capabilities*:

![Signing & Capabilities](/images/client-sdk/push-notifications/signing.png)

Then select add capability and add the *Push Notifications* capability:

![Add push capability](/images/client-sdk/push-notifications/add-capability.png)

If Xcode is automatically managing the signing of your app it will update the provisioning profile linked to your Bundle Identifier to include the capability.

### Generating a push certificate

To generate a push certificate you will need to log in to your Apple developer account and head to the [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list) page and add a new certificate:

![Add certificate button](/images/client-sdk/push-notifications/add-certificate.png)

Choose a *VoIP Services Certificate* and continue. You will now need to choose the App ID for the app that you want to add VoIP push notifications to and continue. If your app is not listed you will have to create an App ID. Xcode can do this for you if it automatically if it manages your signing for you, otherwise you can create a new App ID on the [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list) page under *Identifiers*. Make sure to select the push notifications capability when doing so.

You will be prompted to upload a Certificate Signing Request (CSR). You can follow the instructions on [Apple's help website](https://help.apple.com/developer-account/#/devbfa00fef7) to create a CSR on your Mac. Once the CSR is uploaded you will be able to download the certificate. Double click the `.cer` file to install it in Keychain Access. 
 
To get the push certificate in the format that is needed by the Vonage servers you will need to export it. Locate your VoIP Services certificate in Keychain Access and right-click to export it. Name the export `applecert` and select `.p12` as the format:

![Keychain export](/images/client-sdk/push-notifications/keychain-export.png)

You can find more details about connecting to APNs in [Apple's official documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns). 

## Upload your certificate

To upload your certificate to the Vonage servers you will also need:

* A `jwt_dev`, which is a `jwt` without a `sub` claim. More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

* Your Vonage Application ID. It can be obtained from the [dashboard](https://dashboard.nexmo.com/voice/your-applications).

Then run the following Curl command, replacing `jwt_dev`, `applecert.p12`, `app_id` with your values:

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

VoIP push notifications are suitable for VoIP apps. Among other benefits, it allows you to receive notifications even when the app is terminated.

To integrate VoIP push in your app, follow these steps:

#### 1. Enable VoIP Background Mode for your app
   
Similar to the process for adding the push notifications capability earlier, in Xcode, under *your target*, open *Capabilities* and select *Background Modes*. Once the capability is added tick the "Voice over IP" option:
   
![Background modes selected](/images/client-sdk/push-notifications/background-modes.png)

#### 2. Import `PushKit`, adopt `PKPushRegistryDelegate`, and sign up to VoIP notifications

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/pushkit'
```

#### 3. Implement the following delegate method and add the code to handle an incoming VoIP push notification

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/pushkit-delegate-voip'
```

For the SDK to process the push properly `NXMClient` should be logged in.

#### 4. Enable push notifications through a logged in `NXMClient`

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/enable-notifications-voip'
```

* `'isSandbox'` is `YES`/`true` for an app using the Apple sandbox push servers and NO/false for an app using the Apple production push servers.  

* `'pushKitToken'` is the token received in `pushRegistry(_:didUpdate:for:)`.

## Conclusion

In this guide you have seen how to set up push notifications.
