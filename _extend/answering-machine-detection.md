---
title: Answering Machine detection with machine learning.
description: Building a VAPI application that sends Text-To-Speech when an answering machine is detected.
tags: ["Machine Learning","Python"]
cta: Get this Repo
link: https://github.com/nexmo-community/AnsweringMachineDetection
image: /assets/images/extend/machine_learning_icon.png
published: true
---


# AnsweringMachineDetection

For this solution, we built a machine learning algorithm that is able to detect when a call goes to voicemail by listening to the `beep` sound with 96% accuracy. When the call is picked up by the answering machine, we perform a text-to-speech action(TTS) which is recorded by the answering machine.

## Try it out on Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/nexmo-community/AnsweringMachineDetection)

After you deploy the application to Heroku, make a call to the purchased number for the application.

The application will ask to enter a phone number.
Enter any phone number you like, as long as it is picked up by voicemail. The call will go to voicemail and the answering machine model will start listenting on the call.

When a beep is detected, the application performs a Text-To-Speech, with the phrase, `Answering Machine Detected`, and the call will hangup.

## To install
Clone the [github repo](https://github.com/nexmo-community/AnsweringMachineDetection) and run:

`pip install -r requirements.txt`

Create a .env file with the following
```
MY_LVN={YOUR_NEXMO_NUMBER}
APP_ID={YOUR_NEXMO_APPLICATION_ID}
PRIVATE_KEY={PATH_TO_APPLICATION_PRIVATE_KEY}
```

You will need to create a [Nexmo Application](https://developer.nexmo.com/concepts/guides/applications) and [Purchase a phone number](https://developer.nexmo.com/numbers/code-snippets/buy-a-number)

## Resources
* [GitHub Repository](https://github.com/nexmo-community/AnsweringMachineDetection)
* [Demo Video](https://www.youtube.com/watch?v=ZREXmLOtScA)
* Blog post (coming soon)

## Support
This open source project is supported by the Nexmo DevRel team on a best effort basis, issues should be raised in the GitHub repository.
