---
title: The starter project
description: In this step you will clone the starter project
---

# The starter project

To make things easier, a starter project is provided for you.

1. Clone this [GitHub repository](https://github.com/nexmo-community/client-sdk-android-tutorial-messaging) (Android Studio `New project from version control` feature can’t be used, because repository contains two projects `kotlin-start` and `kotlin-complted`).

2. Open the `kotlin-start` project in the Android Studio:
   
   1. Navigate to the menu `File -> Open` 
   2. Select the `kotlin-start` folder from cloned repository and click `Open`

```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/select-kotlin-start-project.png
```

**3.** Make project `Build -> Make Project`. If `Make Project` button is disabled please wait until Android Studio will finish parsing the project (progress will be displayed in bottom right corner of the Android Studio).
 
```screenshot
image: public/screenshots/tutorials/client-sdk/android-shared/make-project.png
```

## Project navigation overview

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/nav-graph.png
```

The application consists of four screens: 

- **login** - responsible for logging the user
- **chat** - allows to send message and listens for incoming messages

## Project internal structure

All files that will be modified during this tutorial are located in the `app/src/main/java/com/vonage/tutorial/voice` directory:

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/project-files.png
```

> **NOTE:** Each screen is represented by two classes : `Fragment` that is the thin view and `ViewModel` that handles the view logic.

