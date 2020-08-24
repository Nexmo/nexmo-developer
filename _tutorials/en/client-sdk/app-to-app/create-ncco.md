---
title: Create a NCCO
description: In this step, you modify your NCCO using GitHub Gist.
---

# Create a NCCO

A Nexmo Call Control Object (NCCO) is a JSON array that you use to control the flow of a Voice API call. More information on NCCO can be found [here](/voice/voice-api/ncco-reference).

The NCCO must be public and accessible by the internet. To accomplish that, you will be using [GitHub Gist](https://gist.github.com/) that provides a convenient way to host the configuration:

1) Make sure you are logged into [GitHub](https://github.com) and then go to [https://gist.github.com/](https://gist.github.com/).

2) Enter `ncco.json` into "Filename including extension".
   
3) Copy and paste the following JSON object into the gist:

```json
[
    {
        "action": "talk",
        "text": "Connecting you to Bob"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "app",
                "user": "Bob"
            }
        ]
    }
]
```

4) Click the `Create secret gist` button:

```screenshot
image: public/screenshots/tutorials/client-sdk/app-to-phone/create-ncco/gist1.png
```

5) Click the `Raw` button:

```screenshot
image: public/screenshots/tutorials/client-sdk/app-to-phone/create-ncco/gist2.png
```

6) Take note of the URL shown in your browser, you will be using it in the next step.
