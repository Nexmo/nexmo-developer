---
title: Xcode Project and Workspace
description: In this step you create an Xcode project and add the iOS Client SDK library.
---

# Xcode Project & Workspace

You will be using the iOS Client SDK library inside an Xcode project you'll create..

## Create an Xcode Project

* Open Xcode and, from the menu, select `File` > `New` > `Project...`.

* Select a `Single View App` for the Application type and click `Next`.

* For the `Product Name` type in `PhoneToApp`, select the relevant `Team` and `Organisation Identifier`.

* User `Objective-C` for `Language` and `Storyboard` for `User Interface`. Click `Next`.

* Select the `Desktop` as the place where your project folder will reside. You can select a different location but please make sure to remember it as you'll need to navigate to it soon from the `Terminal`.

* You now have a brand new Xcode Project.


**Before continuing, please close the new project you've just created.**

You will add the iOS Client SDK library to your project via [CocoaPods](https://cocoapods.org/).

## Install CocoaPods

* Open the `Terminal` app and navigate to the project folder by typing.

``` shell
cd ~/Desktop/PhoneToApp
```

* Install CocoaPods in your system, if you don't have it already.

``` shell
sudo gem install cocoapods
```

Note: CocoaPods is built with Ruby, available by default on macOS.

* Create a Podfile for your project.

``` shell
pod init
```

## Add the iOS Client SDK

* Add the Nexmo iOS Client SDK to the Podfile. To do this, let's open it in `Xcode`.

``` shell
open -a Xcode Podfile
```

* Update the Podfile as shown below.

```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PhoneToApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PhoneToApp
  pod 'NexmoClient'
  
end
```

* Install the library.

``` shell
pod install
```

The latest version of the library will be added to your project:

```
Analyzing dependencies
Downloading dependencies
Installing NexmoClient (2.1.0)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `PhoneToApp.xcworkspace` for this project from now on.
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.

[!] Automatically assigning platform `iOS` with version `13.5` on target `PhoneToApp` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.
```

## Open the Workspace

As described in the output above, please use `PhoneToApp.xcworkspace` rather than the initial project from now on. To open it, type the following in the terminal.

``` shell
open PhoneToApp.xcworkspace
```

