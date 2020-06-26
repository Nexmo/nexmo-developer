---
title: Authenticate Your Users
description: In this step you authenticate your users via the JWTs you created earlier
---

# Authenticate Your Users

Your users must be authenticated to be able to participate in the `Conversation`. Login screen (`LoginFragment` and `LoginViewModel` classes) is responsible for authenticating the users.

```screenshot
image: public/assets/images/client-sdk/android-app-to-phone/login-screen.png
```

> **NOTE:** You perform this authentication using the `JWTs` generated and provided in previous steps.

## Get NexmoClient instance

You have to retrieve client instance inside `LoginViewModel` class. Usually, it would be provided it via injection, but for tutorial purposes you will retrieve instance directly using static method. Locate the `private val client` property in the `LoginViewModel` class and update its implementation:

```kotlin
private val client = NexmoClient.get()
```

## Login user

Now you should locate the `onLoginUser` method within the `LoginViewModel` class and fill its body to enable user login:

```kotlin
fun onLoginUser(user: User) {
    if (!user.jwt.isBlank()) {
        client.login(user.jwt)
    }
}
```

> **NOTE:** Inside `LoginFragment` class, explore the `loginUser` method that was written for you. This method is called when one of the two `Login ...` buttons are clicked. This method calls the above `onLoginUser` method. 

> **NOTE:** The `User` type is the `data class` that we've defined in the `Config.kt` file.

## Monitor connection state

Now add a connection listener to listen to the `client` instance to listen for connection state changes and use `_connectionStatus` `LiveData` to propagate a new connection state to the view (`LoginFragment`). Locate the `init` block inside `LoginViewModel` class and replace it with this code:


```kotlin
init {
        client.setConnectionListener { newConnectionStatus, _ ->

            if (newConnectionStatus == ConnectionStatus.CONNECTED) {
                navigateToMainFragment()
                return@setConnectionListener
            }

            _connectionStatus.postValue(newConnectionStatus)
        }
}
```

The above code will monitor connection state and if the user is authenticated (`ConnectionStatus.CONNECTED`) it will navigate the user to the `MainFragment`.

You're now ready to make the call within the app.