---
title: API
menu_weight: 2
---

1. Use the following code examples to create a new Application for Voice API:

    ```tabbed_examples
    source: _examples/concepts/guides/applications/code1
    ```

2. Keep a reference of the following items from the response:

    Key | Description
    -- | --
    `application id` | This ID is used to perform all actions on your application.
    `private_key` | The JWTs used to authenticate your requests to Nexmo API are based on this private key. You should keep this key in a file that is not accessible from the Internet.

3. If you do not have one, rent a virtual number.

4. Use the following code examples to make a [POST] request with Developer API and associate the `application_id` with your virtual number at msisdn.

    ```tabbed_examples
    source: _examples/concepts/guides/applications/code2
    ```
