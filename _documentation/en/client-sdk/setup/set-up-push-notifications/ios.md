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

You upload your certificate to the Vonage servers by making a POST request. The iOS Push Certificate Uploading Tool, available on [GitHub](https://github.com/nexmo-community/ios-push-uploader), does so with a web interface. Either of the following methods needs your Vonage Application ID. It can be obtained from the [dashboard](https://dashboard.nexmo.com/voice/your-applications).

### Using the Upload Tool

To use the tool you will need to run it locally or deploy it. You can follow the the instructions in the GitHub project's [README](https://github.com/nexmo-community/ios-push-uploader#running-the-project). You will also need the private key for your Vonage Application. 

Once you have the tool running, enter your Vonage Application ID, private key file, and certificate file and click upload. The status of your upload will be shown on the page once it is complete:

![iOS Push Certificate Uploading Tool success](/images/client-sdk/push-notifications/ios-push-uploader-success.png)

### Using the Terminal

In addition to your Vonage Application ID to upload using the terminal, you will also need a `jwt_dev`. Which is a `jwt` without a `sub` claim. More details on how to generate a JWT can be found in the [setup guide](/tutorials/client-sdk-generate-test-credentials#generate-a-user-jwt).

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

> **NOTE** There is no validation at this endpoint. The `200` return code means that Vonage got the data and stored it but hasn't checked that values are valid.

## Integrate push notifications in your application

VoIP push notifications are suitable for VoIP apps. Among other benefits, it allows you to receive notifications even when the app is terminated.

To integrate VoIP push in your app, follow these steps:

#### 1. Enable VoIP Background Mode for your app
   
Similar to the process for adding the push notifications capability earlier, in Xcode, under *your target*, open *Capabilities* and select *Background Modes*. Once the capability is added tick the "Voice over IP" option:
   
![Background modes selected](/images/client-sdk/push-notifications/background-modes.png)

#### 2. Link the `CallKit` Framework

When using VoIP push notifications, you have to use the CallKit framework. Link it to your project by adding it under _Frameworks, Libraries, and Embedded Content_ under General:

![Linking CallKit framework](/images/client-sdk/push-notifications/callkitframework.png)

#### 3. Import `PushKit`, adopt `PKPushRegistryDelegate`, and sign up to VoIP notifications

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/pushkit'
```

#### 4. Enable push notifications through a logged in `NXMClient`

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/enable-notifications-voip'
```

* `'isSandbox'` is `YES`/`true` for an app using the Apple sandbox push servers and NO/false for an app using the Apple production push servers.  

* `'pushKitToken'` is the token received in `pushRegistry(_:didUpdate:for:)`.

#### 5. Implement the following delegate method and add the code to handle an incoming VoIP push notification

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/setup/push-notifications/pushkit-delegate-voip'
```

The `pushPayload` contains information about the incoming call that you can use to [report the call](https://developer.apple.com/documentation/pushkit/responding_to_voip_notifications_from_pushkit) with CallKit. You can view a sample of the JSON contained in the [push payload](/client-sdk/in-app-voice/guides/push-notification-payload.md).

For the SDK to enable push notifications and to process the push notifications properly `NXMClient` should be logged in. You can store both the push token and push payload and handle them when the client successfully connects. For an example of this, view the [blog post](https://learn.vonage.com/blog/2021/01/28/handling-voip-push-notifications-with-callkit) on using push notifications with CallKit and its accompanying [sample project](https://github.com/nexmo-community/swift-phone-to-app-callkit).

## Conclusion

In this guide you have seen how to set up push notifications. You can find the sample project on [GitHub](https://github.com/nexmo-community/swift-phone-to-app-callkit) and learn more about CallKit on [developer.apple.com](https://developer.apple.com/documentation/callkit)
