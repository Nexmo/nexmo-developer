---
title: Xcode Project & Workspace
description: In this step you create an Xcode project and add the iOS Client SDK library.
---

# Xcode Project & Workspace

You will be using the iOS Client SDK library inside an Xcode project you'll create next:


## Create an Xcode Project

1. Open Xcode and, from the menu, select `File` > `New` > `Project...`.

2. Select a `Single View App` for the Appliocation type and click `Next`.

3. For the `Product Name` type in `AppToPhone`, `Swift` for `Language` and `Storyboard` for `User Interface`. Click `Next`.

4. Select the `Desktop` as the place where your project folder will reside. You can select a different location but please make sure to remember it as you'll need to navigate to it soon from the `Terminal`.

5. We now have a brand new Xcode Project.


## Add the iOS Client SDK

You will add the iOS Client SDK library to your project via [CocoaPods](https://cocoapods.org/):

1. Please close the new project you've just created. 

2. Open the `Terminal` app and navigate to the project folder by typing:

``` shell
cd ~/Desktop/AppToPhone
```

3. Install CocoaPods in your system (if you don't have it already):

``` shell
sudo gem install cocoapods
```

4. Create a Podfile for your project

``` shell
pod init
```

5. Add the Nexmo iOS Client SDK to the Podfile. To do this, let's open it in `Xcode`:

``` shell
open - a Xcode Podfile
```

6. Update the Podfile as shown below.

```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AppToPhone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AppToPhone
  pod 'NexmoClient'
  
end
```

7. Install the library:

``` shell
pod install
```

Version 2.1.0 of the library will be added to your project:

```
% pod install
Analyzing dependencies
Downloading dependencies
Installing NexmoClient (2.1.0)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `AppToPhone.xcworkspace` for this project from now on.
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.

[!] Automatically assigning platform `iOS` with version `13.5` on target `AppToPhone` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.
```

## The Workspace

As per the notice you received in the last step above, please use `AppToPhone.xcworkspace` rather than the initial project from now on. To open it, type the following in the terminal:

``` shell
open AppToPhone.xcworkspace
```

