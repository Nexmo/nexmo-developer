---
title: Create a NCCO
description: In this step, you modify your NCCO using GitHub Gist.
---

# Create a NCCO

A Nexmo Call Control Object (NCCO) is a JSON array that you use to control the flow of a Voice API call. More information on NCCO can be found [here](https://developer.nexmo.com/voice/voice-api/ncco-reference).

The NCCO must be public and accessible by the internet. To accomplish that, we will be using [GitHub Gist](https://gist.github.com/):

1) Go to [https://gist.github.com/](https://gist.github.com/).

2) Enter `ncco.json` into "Filename including extension".
   
3) Copy and paste the following JSON object into the gist:

```json
[
    {
        "action": "talk",
        "text": "Please wait while we connect you."
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "phone",
                "number": "PHONE_NUMBER"
            }
        ]
    }
]
```

4) Replace `PHONE_NUMBER` with your phone number (must be in [E.164](https://developer.nexmo.com/concepts/guides/glossary#e-164-format) format, for example: 14155550100 or 447700900001)

5) Click the `Create secret gist` button.

6) Click the `Raw` button and take note of the URL shown in your browser, you will be using it in the next step. It should look like this:
**https://gist.githubusercontent.com/`USERNAME`/`RANDOM_HEX`/raw/`RANDOM_HEX`/ncco.json**


