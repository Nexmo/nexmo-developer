---
title: Authenticate your Users
description: In this step you authenticate your users via the JWTs you created earlier
---

# Authenticate your Users

Your users must be authenticated to be able to participate in the `Conversation`. Login screen (`LoginFragment` and `LoginViewModel` classes) is responsible for authenticating the users.

```screenshot
image: public/screenshots/tutorials/client-sdk/android-in-app-messaging-chat/login-screen.png
```

> **NOTE:** You perform this authentication using the `JWTs` generated and provided in previous steps.

Now You have to retrieve client instance inside `LoginViewModel` class. Usually, it would be provided it via injection, but for tutorial purposes you will retrieve instance directly using static method. Locate the `private val client` property in the `LoginViewModel` class and update its implementation:

```kotlin
private val client = NexmoClient.get()
```

Make sure to add missing import again.

Your user must be authenticated to be able to participate in the Call. Locate the `onLoginUser` method inside `LoginViewModel` class and replace it with this code:

```kotlin
fun onLoginUser(user: User) {
    if (!user.jwt.isBlank()) {
        this.user = user
        client.login(user.jwt)
    }
}
```

> **NOTE:** Inside `LoginFragment` class, explore the `loginUser` method that was written for you. This method is called when one of the two `Login ...` buttons are clicked. This method calls the above `onLoginUser` method. 

> **NOTE:** The `User` type is the `data class` that we've defined in the `Config.kt` file.


Now add a connection listener to listen to the `client` instance to listen for connection state changes and use `_connectionStatus` `LiveData` to propagate a new connection state to the view (`LoginFragment`). Locate the `init` block inside `LoginViewModel` class and replace it with this code:


```kotlin
init {
    client.setConnectionListener { newConnectionStatus, _ ->
        _connectionStatus.postValue(newConnectionStatus)
    }
}
```

Now view needs to react to the newly dispatched connection state. Locate the `private val stateObserver` property within `LoginFragment` and fill its body:

```kotlin
private val stateObserver = Observer<ConnectionStatus> {
    connectionStatusTextView.text = it.toString()

    if (it == ConnectionStatus.CONNECTED) {
        val navDirections = LoginFragmentDirections.actionLoginFragmentToChatFragment()
        findNavController().navigate(navDirections)
    } else if (it == ConnectionStatus.DISCONNECTED) {
        dataLoading = false
    }
}
```

The above code will display the current connection state and if the user is authenticated (`ConnectionStatus.CONNECTED`) it will navigate the user to the `ChatFragment` where the user can view and interact with the conversation.

You're now ready to fetch the conversation within the app.
