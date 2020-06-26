---
title: The Starter Project
description: In this step you will clone the starter project
---

# The Starter Project

To make things easier, a `Starter` project is provided for you. It is a simple Android Studio project that contains an application with the following two screens:

1. Clone this [GitHub project](https://github.com/nexmo-community/client-sdk-android-tutorial-voice).
2. Open the project in the `Android Studio` - navigate to menu `File -> Open` and select the `kotlin-start` folder from cloned repository.

## Project navigation overview

```screenshot
image: public/assets/images/client-sdk/android-app-to-phone/nav-graph.png
```

The application consists of four screens: 

- **login** - responsible for logging the user
- **main** - allows to start a call and listens for incoming call
- **incoming call** - answer or reject incoming call
- **on call** - displayed during call, allows to end current call

## Project internal structure

All files that will be modified during this tutorial are located in the `app/src/main/java/com/vonage/tutorial/voice` directory:

```screenshot
image: public/assets/images/client-sdk/android-app-to-phone/project-files.png
```
