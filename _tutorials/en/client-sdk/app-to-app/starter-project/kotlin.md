---
title: The starter project
description: In this step you will clone the starter project
---

# The starter project

To make things easier, a starter project is provided for you.

1. Clone this [GitHub project](https://github.com/nexmo-community/client-sdk-android-tutorial-voice-app-to-app).

2. Open the project in the `Android Studio`:
   
   1. Navigate to the menu `File -> Open` 
   2. Select the `kotlin-start` folder from cloned repository

3. Make project `Build -> Make Project` 

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/make-project.png
```

## Project navigation overview

```screenshot
image: public/screenshots/tutorials/client-sdk/android-app-to-app/nav-graph.png
```

The application consists of four screens: 

- **login** - responsible for logging the user
- **main** - allows to start a call and listens for incoming call
- **incoming call** - answer or reject incoming call
- **on call** - displayed during ongoing call, allows to end current call

## Project internal structure

All files that will be modified during this tutorial are located in the `app/src/main/java/com/vonage/tutorial/voice` directory:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-app-to-app/project-files.png
```

> **NOTE:** Each view is represented by two classes -> `Fragment` that is the thin view and `ViewModel` that handles the view logic.