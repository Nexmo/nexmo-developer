---
title: Using the Nexmo Client Library for Java
description: Set up your Gradle project and download the Nexmo Client Library for Java.
---

# Using the Nexmo Client Library for Java

Create a directory to contain your project. Inside this directory, run `gradle init`. Open the file `build.gradle` and change the contents to the following:

```
// We're creating a Java Application:
apply plugin: 'application'
apply plugin: 'java'
 
// Download dependencies from Maven Central:
repositories {
    mavenCentral()
}
 
// Install the Nexmo Client library:
dependencies {
    compile 'com.nexmo:client:2.0.1'
}
 
// We'll create this class to contain our code:
mainClassName = "getstarted.SendSMS"
```

Now, if you open your console in the directory that contains this `build.gradle` file, you can run:

```
gradle build
```

This command will download the Nexmo client library and store it for later. It would also compile any source code you have.

Because of the `mainClassName` set in your Gradle `build` file, you need to create a class called `SendSMS` in the package `getstarted`. In production code, you’d want the package to be something like `com.mycoolcompany.smstool`, but this isn’t production code, so `getstarted` will do.

Gradle uses the same directory structure as Maven, so you need to create the following directory structure inside your project directory: `src/main/java/getstarted`.

On macOS and Linux, you can create this path by running:

```
mkdir -p src/main/java/getstarted
```

Inside the `getstarted` directory, create a file called `SendSMS.java`, open it in your favorite text editor. Start with some boiler-plate code:

```
package getstarted;
 
import com.nexmo.client.NexmoClient;
import com.nexmo.client.auth.AuthMethod;
import com.nexmo.client.auth.TokenAuthMethod;
import com.nexmo.client.sms.SmsSubmissionResult;
import com.nexmo.client.sms.messages.TextMessage;
 
public class SendSMS {
 
    public static void main(String[] args) throws Exception {
        // Our code will go here!
    }
}
```

All this does is import the necessary parts of the Nexmo client library, and create a method to contain our code. It’s worth running `gradle run` now, which should run your main method.
