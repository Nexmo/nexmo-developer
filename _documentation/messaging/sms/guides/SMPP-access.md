---
title: SMPP access
---

# SMPP access

By default, your Nexmo account is configured for REST. Compared to REST, SMPP uses more resources. However, most of the SMS volume processed at Nexmo uses SMPP and if you would prefer to use SMPP, we are happy to assist you to switch your traffic over to us.

If you already use SMPP and want to use Nexmo, you can switch to us in minutes without changing your app. Just update your configuration to point to Nexmo's SMPP server.

- [Standard SMPP access](#standard-smpp-access)
- [SMPP access with Kannel](#smpp-access-with-kannel)

## Standard SMPP access

To switch to Nexmo:

1. Email your monthly volume forecast to us at [smpp@nexmo.com](mailto:smpp@nexmo.com). We will configure our system for you and send back your SMPP credentials.

2. Check out our [SMPP FAQ] to find out more about supported character encodings, delivery receipt formats, throttle management, sending concatenated messages and more.

## SMPP access with Kannel

If you use version 1.4.3 or higher of [Kannel](http://www.kannel.org/download.shtml), we have a ready-to-use configuration for you.

To use our configuration:

1. Email your monthly volume forecast to us at [smpp@nexmo.com](mailto:smpp@nexmo.com). We will configure our system for you and send back your SMPP credentials.

2. Download the `kannel.conf` configuration via [Nexmo Support](https://help.nexmo.com/hc/en-us/articles/204015673).

3. In `kannel.conf`, replace `$nexmo_user` and `$nexmo_password` with your Nexmo SMPP credentials.

4. For security reasons `kannel.conf` allows access from `localhost` only. To enable access from a different machine, edit the following parameters in `kannel.conf`. For example, for the IP addresses `X.X.X.X` and `Y.Y.Y.Y`:

    ```
    admin-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ...
    box-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ...
    user-allow-ip = "127.0.0.1;X.X.X.X;Y.Y.Y.Y"
    ```

5. Restart Kannel

6. Send a test message. For example:

    ```
    https://localhost:13013/cgi-bin/sendsms?username=username&password=pwd&to=%2B33XXXXXXX&text=Hello%20World&from=test&charset=ISO-8859-1&dlr-mask=17
    ```

> Note: Check out our [SMPP FAQ] for information about supported character encodings, delivery receipt formats, throttle management, concatenated messages and more.

[SMPP FAQ]: https://help.nexmo.com/hc/en-us/sections/200621223-FAQ-SMPP-API
