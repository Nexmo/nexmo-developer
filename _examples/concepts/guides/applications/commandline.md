---
title: Command Line
menu_weight: 1
---

To create a Voice app and send a text-to-speech message:

1. If you don't already have one, setup a Nexmo account.

2. Use [npm](https://www.npmjs.com/) to install and setup the Nexmo CLI.

    ```sh
    $ npm install nexmo-cli -g
    $ nexmo setup <api_key> <api_secret>
    ```

3. If you do not have one, rent a virtual number using the Dashboard or the command line.

    ```sh
    $ nexmo number:buy 447700900000 --confirm
    ```

4. Create an Application:

    ```sh
    $ nexmo app:create "VoiceApplication" http://example.com/webhooks/answer http://example.com/webhooks/event  --keyfile private.key
    ```

5. Associate the application_id with your virtual number.

    ```sh
    $ nexmo link:app 447700900000 aaaaaaaa-bbbb-cccc-dddd-0123456789ab
